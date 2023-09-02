import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final defaultPinSize = 20.0;

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
          editPin: const LocationPin(
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
    init();
  }

  void init() {
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
          _updateEditPin();
        } else {
          _updatePins(pinX: 4000.0, pinY: 5400.0);
        }
      },
    );
  }

  void _updatePins({required pinX, required pinY}) {
    // 拡大率から0.5刻みにピンの大きさを調整
    final diffScale = photoViewState.scale / photoViewState.defaultImageScale;
    final pinSize = defaultPinSize * (diffScale * 2).ceil() / 2;

    final (pinLeft, pinTop) = _calcPinCoordinate(
      pinX: pinX,
      pinY: pinY,
      pinSize: pinSize,
    );
    state = state.copyWith(
      locationPins: [
        LocationPin(
          id: 0,
          x: pinX,
          y: pinY,
          pinLeft: pinLeft,
          pinTop: pinTop,
          size: pinSize,
        ),
      ],
    );
  }

  void _updateEditPin() {
    final pinSize = _calcPinSize();
    final (pinLeft, pinTop) = _calcPinCoordinate(
      pinX: state.editPin.x,
      pinY: state.editPin.y,
      pinSize: _calcPinSize(),
    );

    state = state.copyWith(
      editPin: state.editPin.copyWith(
        pinLeft: pinLeft,
        pinTop: pinTop,
        size: pinSize,
      ),
    );
  }

  (double, double) _calcPinCoordinate({
    required pinX,
    required pinY,
    required pinSize,
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

  (double, double) convertToMapPosition({required pinLeft, required pinTop}) {
    // マップ画像上のピンの座標を計算
    final (overWidth, overHeight) = _calcOverSize();
    final mapPinLeft = pinLeft - photoViewState.dx + overWidth;
    final mapPinTop = pinTop - photoViewState.dy + overHeight;

    // ピンの絶対座標を計算
    final pinX = mapPinLeft / photoViewState.scale;
    final pinY = mapPinTop / photoViewState.scale;

    return (pinX, pinY);
  }

  void addEditPin({required x, required y}) {
    final pinSize = _calcPinSize();
    final pinLeft = x - pinSize / 2;
    final pinTop = y - pinSize / 2;
    final (pinX, pinY) = convertToMapPosition(pinLeft: pinLeft, pinTop: pinTop);

    state = state.copyWith(
      editPin: state.editPin.copyWith(
        x: pinX,
        y: pinY,
      ),
    );
    _updateEditPin();
  }

  void toggleEditMode(bool mode) {
    state = state.copyWith(
      isEditMode: mode,
      editPin: const LocationPin(
        id: 0,
        x: 0,
        y: 0,
        pinLeft: 0,
        pinTop: 0,
        size: 0,
      ),
    );
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
