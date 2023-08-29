import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/view_model/floor_map/floor_map_state/floor_map_state.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:photo_view/photo_view.dart';

final floorMapProvider =
    StateNotifierProvider.autoDispose<FloorMapViewModel, FloorMapState>(
  (ref) => FloorMapViewModel(ref),
);

class FloorMapViewModel extends StateNotifier<FloorMapState> {
  final Ref ref;
  final image = Image.asset("assets/images/shonandai_floor_map.png").image;

  double imageWidth = 0;
  double imageHeight = 0;
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
    double defaultImageScale = 0.0;
    state.photoController.outputStateStream.listen(
      (event) {
        if (!initialized) {
          defaultImageScale = event.scale!;
          initialized = true;
        }
        const pinX = 6000.0;
        const pinY = 5400.0;
        const defaultPinSize = 20.0;

        // 拡大率を考慮した画像のサイズ
        final virtualImageWidth = imageWidth * event.scale!;
        final virtualImageHeight = imageHeight * event.scale!;

        // 画面からはみ出したマップサイズを計算
        final overWidth = (virtualImageWidth - screenWidth) / 2;
        final overHeight = (virtualImageHeight - screenHeight) / 2;

        // 拡大率からピンの大きさを調整
        final diffScale = event.scale! / defaultImageScale;
        final pinSize = defaultPinSize * diffScale.ceil();

        // マップ画像上のピンの位置を計算
        final absolutePinX = pinX * event.scale! - pinSize / 2;
        final absolutePinY = pinY * event.scale! - pinSize;

        // 画面上のピンの位置を計算
        final pinLeft = event.position.dx - overWidth + absolutePinX;
        final pinTop = event.position.dy - overHeight + absolutePinY;

        state = state.copyWith(locationPins: [
          LocationPin(
            id: 0,
            x: pinX,
            y: pinY,
            pinLeft: pinLeft,
            pinTop: pinTop,
            size: pinSize,
          ),
        ]);
      },
    );
  }

  void resolveImageProvider(BuildContext context) {
    ImageStream stream = image.resolve(createLocalImageConfiguration(context));
    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      imageWidth = info.image.width.toDouble();
      imageHeight = info.image.height.toDouble();
    }));
  }
}
