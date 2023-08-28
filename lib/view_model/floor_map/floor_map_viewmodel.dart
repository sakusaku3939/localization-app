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

  FloorMapViewModel(this.ref)
      : super(FloorMapState(
          locationPins: [],
          photoController: PhotoViewController(),
        )) {
    init();
  }

  void init() {
    state.photoController.outputStateStream.listen(
      (event) {
        // はみ出した長さ
        const overW = 0;
        const overH = 0;

        // マップ画像を基準にしたピンの位置、サイズ
        const pinX = 120.0;
        const pinY = 200.0;
        const pinW = 24;
        const pinH = 24;

        final pinLeft = event.position.dx - overW + pinX - pinW / 2;
        final pinTop = event.position.dy - overH + pinY - pinH;

        state = state.copyWith(locationPins: [
          LocationPin(id: 0, x: pinX, y: pinY, pinLeft: pinLeft, pinTop: pinTop),
        ]);
      },
    );
  }
}
