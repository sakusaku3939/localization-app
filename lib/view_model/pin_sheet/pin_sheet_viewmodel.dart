import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/constant/global_state.dart';
import 'package:localization/model/firebase_api.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:localization/view_model/floor_map/pin/pin.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_state/pin_sheet_state.dart';

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

  PinSheetViewModel(this.ref)
      : super(const PinSheetState(
          isShow: false,
          id: "",
          pinX: 0,
          pinY: 0,
          storageRefList: null,
        ));

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
    final path = await firebase.getStoragePath(
      firestoreId: ref.read(floorMapProvider.notifier).state.editablePin.id,
    );

    await firebase.uploadToStorage(
      path: "$path/${DateTime.now().microsecondsSinceEpoch}.jpg",
      data: imageFile,
    );
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
    final id = await firebase.addToFirestore(
      root: "storage",
      data: {
        "x": state.pinX.toString(),
        "y": state.pinY.toString(),
      },
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

  void deleteDataset() {
    showDialog(
      context: GlobalState.context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "削除の確認",
            style: TextStyle(fontSize: 20),
          ),
          content: const Text("登録されたデータセットを削除しますか？この操作は元に戻せません。"),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
          actions: [
            TextButton(
              child: const Text("キャンセル"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("削除"),
              onPressed: () {
                final floorMapNotifier = ref.read(floorMapProvider.notifier);
                floorMapNotifier.deletePin(id: state.id);
                FocusScope.of(context).unfocus();
                closeSheet();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
