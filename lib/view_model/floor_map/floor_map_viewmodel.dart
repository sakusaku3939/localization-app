import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final image = Image.asset("assets/images/shonandai_floor_map.png").image;
  final defaultPinSize = 16.0;

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

  FloorMapViewModel(this.ref)
      : super(FloorMapState(
          locationPins: [],
          editablePin: const LocationPin(
            id: 0,
            x: 0,
            y: 0,
            pinLeft: 0,
            pinTop: 0,
            size: 0,
          ),
          photoController: PhotoViewController(),
          isEditMode: false,
        )) {
    _init();
  }

  void _init() {
    bool initialized = false;
    state.photoController.outputStateStream.listen(
      (event) {
        if (!initialized) {
          photoViewState =
              photoViewState.copyWith(defaultImageScale: event.scale!);
          initialized = true;
        }

        // マップの移動方向、拡大率をStateに保存
        photoViewState = photoViewState.copyWith(
          dx: event.position.dx,
          dy: event.position.dy,
          scale: event.scale!,
        );

        // ピンの座標をマップ拡大に合わせて更新
        if (state.isEditMode) {
          _updateEditablePin();
        } else {
          _updatePins();
        }
      },
    );
  }

  void _updatePins() {
    // 拡大率から0.5刻みにピンの大きさを調整
    final diffScale = photoViewState.scale / photoViewState.defaultImageScale;
    final pinSize = defaultPinSize * (diffScale * 2).ceil() / 2;

    const pinX = [4000.0, 5000.0];
    const pinY = [5400.0, 5200.0];
    final locations = <LocationPin>[];

    for (int i = 0; i < 2; i++) {
      final (pinLeft, pinTop) = _calcPinCoordinate(
        pinX: pinX[i],
        pinY: pinY[i],
        pinSize: pinSize,
      );
      locations.add(
        LocationPin(
          id: 0,
          x: pinX[i],
          y: pinY[i],
          pinLeft: pinLeft,
          pinTop: pinTop,
          size: pinSize,
        ),
      );
    }
    state = state.copyWith(locationPins: locations);
  }

  (double, double) _calcPinCoordinate({
    required double pinX,
    required double pinY,
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

  double _calcPinSize() {
    final diffScale = photoViewState.scale / photoViewState.defaultImageScale;
    final pinSize = defaultPinSize * diffScale;
    return pinSize;
  }

  (double, double) convertToMapPosition({
    required double pinLeft,
    required double pinTop,
  }) {
    // マップ画像上のピンの座標を計算
    final (overWidth, overHeight) = _calcOverSize();
    final mapPinLeft = pinLeft - photoViewState.dx + overWidth;
    final mapPinTop = pinTop - photoViewState.dy + overHeight;

    // ピンの絶対座標を計算
    final pinX = mapPinLeft / photoViewState.scale;
    final pinY = mapPinTop / photoViewState.scale;

    return (pinX, pinY);
  }

  void addEditablePin({required double x, required double y}) {
    // マップ上にピンを配置
    final adjust = _calcPinSize() / 10;
    final (pinX, pinY) = convertToMapPosition(
      pinLeft: x,
      pinTop: y + adjust,
    );
    state = state.copyWith(
      editablePin: state.editablePin.copyWith(
        x: pinX,
        y: pinY,
      ),
    );
    _updateEditablePin();

    // シートの位置に合わせてマップを移動
    final sheetNotifier = ref.read(pinSheetProvider.notifier);
    final topMargin = sheetNotifier.isSheetSizeMiddle
        ? screenHeight * (1 - sheetNotifier.snaps[1]) / 2
        : screenHeight * (1 - sheetNotifier.snaps[2]) / 2;

    state.photoController.updateMultiple(
      position: Offset(
        state.photoController.position.dx,
        state.photoController.position.dy - (y + adjust) + topMargin + 20,
      ),
    );
    ref.read(pinSheetProvider.notifier).showBottomSheet(true);
  }

  void _updateEditablePin() {
    // ピンが非表示の時は更新しない
    if (state.editablePin.x == 0 && state.editablePin.y == 0) {
      return;
    }
    final pinSize = _calcPinSize();
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
        id: 0,
        x: 0,
        y: 0,
        pinLeft: 0,
        pinTop: 0,
        size: 0,
      ),
    );
  }

  void setEditMode(bool mode) {
    state = state.copyWith(isEditMode: mode);
    resetEditablePin();
    if (!mode) {
      _updatePins();
    }
  }

  void resolveImageProvider(BuildContext context) {
    ImageStream stream = image.resolve(createLocalImageConfiguration(context));
    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      photoViewState = photoViewState.copyWith(
        width: info.image.width.toDouble(),
        height: info.image.height.toDouble(),
      );
    }));
  }
}
