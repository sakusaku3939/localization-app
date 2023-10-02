import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/constant/global_state.dart';
import 'package:localization/model/firebase_api.dart';
import 'package:localization/view/helper/dialog_helper.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:localization/view_model/floor_map/pin/pin.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_state/pin_sheet_state.dart';
import 'package:uuid/uuid.dart';

final pinSheetProvider =
    StateNotifierProvider.autoDispose<PinSheetViewModel, PinSheetState>(
  (ref) => PinSheetViewModel(ref),
);

class PinSheetViewModel extends StateNotifier<PinSheetState> {
  final Ref ref;
  final controller = DraggableScrollableController();
  final snaps = <double>[0, 0.12, 0.6, 0.95];
  final firebase = FirebaseApi();

  int? textFieldPinX;
  int? textFieldPinY;
  bool hasUploaded = false;

  PinSheetViewModel(this.ref)
      : super(const PinSheetState(
          isShow: false,
          id: "",
          pinX: 0,
          pinY: 0,
          storageRefList: null,
        )) {
    firebase.deleteTempFiles();
  }

  bool get isSheetSizeMiddle =>
      controller.isAttached ? controller.size.round() <= snaps[1] : false;

  bool get isSheetSizeMax =>
      controller.isAttached ? controller.size <= snaps.last : false;

  Future<void> closeSheet() async {
    await controller.animateTo(
      0.04,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    state = state.copyWith(storageRefList: null);
    showBottomSheet(false);
  }

  void popSheet() {
    if (isSheetSizeMiddle) {
      closeSheet();
    } else if (isSheetSizeMax) {
      controller.animateTo(
        snaps[1],
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  void showBottomSheet(
    bool isShow, {
    LocationPin? pin,
  }) {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    final pinTop = pin?.pinTop;
    final pinX = pin?.x;
    final pinY = pin?.y;

    if (isShow) {
      // シートの位置に合わせてマップを移動
      final topMargin = isSheetSizeMiddle
          ? floorMapNotifier.screenHeight * (1 - snaps[1]) / 2
          : floorMapNotifier.screenHeight * (1 - snaps[2]) / 2;

      floorMapNotifier.state.photoController.updateMultiple(
        position: Offset(
          floorMapNotifier.state.photoController.position.dx,
          floorMapNotifier.state.photoController.position.dy -
              (pinTop ?? 0) +
              topMargin +
              20,
        ),
      );
      fetchDatasets();
    } else if (hasUploaded) {
      firebase.deleteTempFiles();
      hasUploaded = false;
    }

    floorMapNotifier.setEditMode(isShow);
    state = state.copyWith(
      isShow: isShow,
      id: pin?.id ?? "",
      pinX: pinX ?? state.pinX,
      pinY: pinY ?? state.pinY,
    );
  }

  void onInputFieldsChanged(String label, String value) {
    switch (label) {
      case "X":
        textFieldPinX = int.parse(value);
      case "Y":
        textFieldPinY = int.parse(value);
    }
  }

  Future<void> onKeyboardFocus(bool hasFocus) async {
    // キーボードに合わせてシートの高さを調節する
    updatePin() => ref.read(floorMapProvider.notifier).update();
    controller.addListener(updatePin);
    if (hasFocus) {
      await controller.animateTo(
        snaps.last,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    } else {
      // ピンの位置を入力フィールドの値に合わせて更新する
      final floorMapNotifier = ref.read(floorMapProvider.notifier);
      floorMapNotifier.addEditablePin(
        pinX: textFieldPinX ?? floorMapNotifier.state.editablePin.x,
        pinY: textFieldPinY ?? floorMapNotifier.state.editablePin.y,
      );
      await controller.animateTo(
        snaps[2],
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
    controller.removeListener(updatePin);
    updatePin();
  }

  Future<void> uploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageFile = File(image.path);
    await firebase.uploadToStorage(
      firestoreId: ref.read(floorMapProvider.notifier).state.editablePin.id,
      name: "${DateTime.now().microsecondsSinceEpoch}.jpg",
      data: imageFile,
    );
    hasUploaded = true;
    fetchDatasets();
  }

  Future<void> fetchDatasets() async {
    state = state.copyWith(storageRefList: null);
    final path = await firebase.getStoragePath(
      firestoreId: ref.read(floorMapProvider.notifier).state.editablePin.id,
    );
    if (path != null) {
      final refs = await firebase.fetchStorageRefs(path: path);
      state = state.copyWith(storageRefList: refs);
    }
  }

  Future<void> addDataset() async {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    final data = {
      "x": state.pinX.toString(),
      "y": state.pinY.toString(),
    };
    if (hasUploaded) {
      final path = const Uuid().v4();
      firebase.copyStorageFiles(srcPath: "Temp", destPath: path);
      data.addAll({
        "path": path,
      });
    }
    final id = await firebase.addToFirestore(
      root: "storage",
      data: data,
    );
    if (id.isNotEmpty) {
      floorMapNotifier.pins.add(Pin(
        id: id,
        x: state.pinX,
        y: state.pinY,
      ));
    }
    floorMapNotifier.setAddMode(false);
    closeSheet();
  }

  Future<void> updateDataset() async {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    floorMapNotifier.updatePin(
      id: state.id,
      pinX: state.pinX,
      pinY: state.pinY,
    );
    FocusScope.of(GlobalState.context).unfocus();
    closeSheet();
    await firebase.writeToFirestore(
      root: "storage",
      path: state.id,
      data: {
        "x": state.pinX.toString(),
        "y": state.pinY.toString(),
      },
      update: true,
    );
  }

  Future<void> showDeleteDialog() async {
    await DialogHelper().show(
      title: "削除の確認",
      content: "登録されたデータセットを削除しますか？この操作は元に戻せません。",
      okButton: "削除",
      onOkClick: (context) => deleteDataset(context),
    );
  }

  Future<void> deleteDataset(BuildContext context) async {
    final deleteId = state.id;
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    floorMapNotifier.deletePin(id: deleteId);
    FocusScope.of(context).unfocus();
    closeSheet();
    Navigator.pop(context);
    await firebase.deleteFromStorage(firestoreId: deleteId);
  }

  Future<void> deleteImage(int index) async {
    final deleteRef = state.storageRefList?[index];
    await deleteRef?.delete();
    final newStorageRefList = [...?state.storageRefList];
    newStorageRefList.remove(deleteRef);
    state = state.copyWith(storageRefList: newStorageRefList);
  }
}
