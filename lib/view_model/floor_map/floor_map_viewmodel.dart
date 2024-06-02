import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/constant/global_context.dart';
import 'package:localization/constant/l10n.dart';
import 'package:localization/model/firebase_api.dart';
import 'package:localization/view_model/floor_map/pin/pin.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';
import 'package:localization/view_model/floor_map/floor_map_state/floor_map_state.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:localization/view_model/floor_map/photo_view_state/photo_view_state.dart';
import 'package:photo_view/photo_view.dart';

final floorMapProvider =
    StateNotifierProvider.autoDispose<FloorMapViewModel, FloorMapState>(
  (ref) => FloorMapViewModel(ref),
);

class FloorMapViewModel extends StateNotifier<FloorMapState> {
  final Ref ref;
  final image = Image.asset(
    L10n.localeName == "ja"
        ? "assets/images/i208_map.png"
        : "assets/images/i208_map_en.png",
  ).image;
  final defaultPinSize = kIsWeb ? 28.0 : 20.0;
  final firebase = FirebaseApi();

  List<Pin> pins = [];
  PhotoViewState photoViewState = const PhotoViewState(
    dx: 0,
    dy: 0,
    width: 0,
    height: 0,
    scale: 0,
    defaultImageScale: 0,
  );
  double screenWidth = 0;
  double screenHeight = 0;
  bool _mapInitialized = false;

  FloorMapViewModel(this.ref)
      : super(FloorMapState(
          locationPins: [],
          editablePin: const LocationPin(
            id: "",
            x: 0,
            y: 0,
            pinLeft: 0,
            pinTop: 0,
            size: 0,
          ),
          photoController: PhotoViewController(),
          isEditState: false,
          isAddMode: false,
        )) {
    _init();
  }

  Future<void> _init() async {
    _mapInitialized = false;
    pins = await firebase.fetchPins(root: "i208");
    state.photoController.outputStateStream.listen(initMap);
  }

  void initMap(PhotoViewControllerValue event) {
    if (!_mapInitialized && event.scale != null) {
      photoViewState = photoViewState.copyWith(defaultImageScale: event.scale!);
      _mapInitialized = true;
    }

    // マップの移動方向、拡大率をStateに保存
    photoViewState = photoViewState.copyWith(
      dx: event.position.dx,
      dy: event.position.dy,
      scale: event.scale ?? photoViewState.scale,
    );

    // ピンの座標をマップ拡大に合わせて更新
    update();
  }

  void update() {
    if (state.isEditState) {
      _updateEditablePin();
    } else {
      _updatePins();
    }
  }

  Future<void> _updatePins() async {
    final pinSize = calcPinSize();
    final locations = <LocationPin>[];

    for (var pin in pins) {
      final (pinLeft, pinTop) = _calcPinCoordinate(
        pinX: pin.x,
        pinY: pin.y,
        pinSize: pinSize,
      );
      locations.add(
        LocationPin(
          id: pin.id,
          x: pin.x,
          y: pin.y,
          pinLeft: pinLeft,
          pinTop: pinTop,
          size: pinSize,
        ),
      );
    }

    state = state.copyWith(locationPins: locations);
  }

  (double, double) _calcPinCoordinate({
    required int pinX,
    required int pinY,
    required double pinSize,
  }) {
    // マップ画像上のピンの座標を計算
    final mapPinLeft = pinX * photoViewState.scale - pinSize / 2;
    final mapPinTop = pinY * photoViewState.scale - pinSize;

    // 画面上のピンの座標を計算
    final (overWidth, overHeight) = _calcOverSize();
    final pinLeft = photoViewState.dx - overWidth + mapPinLeft;
    final pinTop = photoViewState.dy - overHeight + mapPinTop;

    return (pinLeft, pinTop);
  }

  (double, double) _calcOverSize() {
    // 拡大率を考慮した画像のサイズを計算
    final virtualImageWidth = photoViewState.width * photoViewState.scale;
    final virtualImageHeight = photoViewState.height * photoViewState.scale;

    // 画面からはみ出ているマップのサイズを計算
    final overWidth = (virtualImageWidth - screenWidth) / 2;
    final overHeight = (virtualImageHeight - screenHeight) / 2;

    return (overWidth, overHeight);
  }

  double calcPinSize() {
    final diffScale = photoViewState.scale / photoViewState.defaultImageScale;
    final pinSize = defaultPinSize * diffScale;
    return pinSize;
  }

  (int, int) convertToMapPosition({
    required double pinLeft,
    required double pinTop,
  }) {
    // マップ画像上のピンの座標を計算
    final (overWidth, overHeight) = _calcOverSize();
    final mapPinLeft = pinLeft - photoViewState.dx + overWidth;
    final mapPinTop = pinTop - photoViewState.dy + overHeight;

    // ピンの絶対座標を計算
    final pinX = (mapPinLeft / photoViewState.scale).round();
    final pinY = (mapPinTop / photoViewState.scale).round();

    return (pinX, pinY);
  }

  void addEditablePin({
    String? id,
    required int pinX,
    required int pinY,
    bool isPredict = false,
  }) {
    state = state.copyWith(
      editablePin: state.editablePin.copyWith(
        id: id ?? state.editablePin.id,
        x: pinX,
        y: pinY,
      ),
    );
    _updateEditablePin();
    ref.read(pinSheetProvider.notifier).showBottomSheet(
          true,
          pin: state.editablePin,
          isPredict: isPredict,
        );
  }

  void _updateEditablePin() {
    // ピンが非表示の時は更新しない
    if (state.editablePin.x == 0 && state.editablePin.y == 0) {
      return;
    }
    final pinSize = calcPinSize();
    final (pinLeft, pinTop) = _calcPinCoordinate(
      pinX: state.editablePin.x,
      pinY: state.editablePin.y,
      pinSize: pinSize,
    );

    state = state.copyWith(
      editablePin: state.editablePin.copyWith(
        pinLeft: pinLeft,
        pinTop: pinTop,
        size: pinSize,
      ),
    );
  }

  void resetEditablePin() {
    state = state.copyWith(
      editablePin: const LocationPin(
        id: "",
        x: 0,
        y: 0,
        pinLeft: 0,
        pinTop: 0,
        size: 0,
      ),
    );
  }

  void setEditState(bool s) {
    state = state.copyWith(isEditState: s);
    update();
  }

  void setAddMode(bool mode) {
    state = state.copyWith(isAddMode: mode);
    resetEditablePin();
    update();
  }

  void updatePin({required String id, required int pinX, required int pinY}) {
    pins = pins
        .map((e) => e.id == id
            ? e.copyWith(
                x: pinX,
                y: pinY,
              )
            : e)
        .toList();
    update();
  }

  void deletePin({required String id}) {
    pins.removeWhere((e) => e.id == id);
    update();
  }

  void resolveImageProvider() {
    ImageStream stream =
        image.resolve(createLocalImageConfiguration(globalContext));
    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      photoViewState = photoViewState.copyWith(
        width: info.image.width.toDouble(),
        height: info.image.height.toDouble(),
      );
    }));
  }
}
