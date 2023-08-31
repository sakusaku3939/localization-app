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
          photoController: PhotoViewController(),
        )) {
    init();
  }

  void init() {
    bool initialized = false;
    state.photoController.outputStateStream.listen(
      (event) {
        photoViewState = photoViewState.copyWith(
          dx: event.position.dx,
          dy: event.position.dy,
          scale: event.scale!,
          defaultImageScale:
              !initialized ? event.scale! : photoViewState.defaultImageScale,
        );
        if (!initialized) {
          initialized = true;
        }

        const pinX = 6000.0;
        const pinY = 5400.0;
        final pinData = _movePin(pinX: pinX, pinY: pinY);

        state = state.copyWith(locationPins: [
          LocationPin(
            id: 0,
            x: pinX,
            y: pinY,
            pinLeft: pinData[0],
            pinTop: pinData[1],
            size: pinData[2],
          ),
        ]);
      },
    );
  }

  List<double> _movePin({required pinX, required pinY}) {
    // 拡大率から0.5刻みにピンの大きさを調整
    final diffScale = photoViewState.scale / photoViewState.defaultImageScale;
    final pinSize = defaultPinSize * (diffScale * 2).ceil() / 2;

    // 拡大率を考慮した画像のサイズを計算
    final virtualImageWidth = photoViewState.width * photoViewState.scale;
    final virtualImageHeight = photoViewState.height * photoViewState.scale;

    // 画面からはみ出ているマップのサイズを計算
    final overWidth = (virtualImageWidth - screenWidth) / 2;
    final overHeight = (virtualImageHeight - screenHeight) / 2;

    // マップ画像上のピンの位置を計算
    final absolutePinLeft = pinX * photoViewState.scale - pinSize / 2;
    final absolutePinTop = pinY * photoViewState.scale - pinSize;

    // 画面上のピンの位置を計算
    final pinLeft = photoViewState.dx - overWidth + absolutePinLeft;
    final pinTop = photoViewState.dy - overHeight + absolutePinTop;

    return [pinLeft, pinTop, pinSize];
  }

  List<double> convertToMapPosition({required pinLeft, required pinTop}) {
    final virtualImageWidth = photoViewState.width * photoViewState.scale;
    final virtualImageHeight = photoViewState.height * photoViewState.scale;
    final overWidth = (virtualImageWidth - screenWidth) / 2;
    final overHeight = (virtualImageHeight - screenHeight) / 2;

    final absolutePinLeft = pinLeft - photoViewState.dx + overWidth;
    final absolutePinTop = pinTop - photoViewState.dy + overHeight;

    final pinX = absolutePinLeft / photoViewState.scale;
    final pinY = absolutePinTop / photoViewState.scale;

    return [pinX, pinY];
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
