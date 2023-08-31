import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:photo_view/photo_view.dart';

part 'floor_map_state.freezed.dart';

@freezed
class FloorMapState with _$FloorMapState {
  const factory FloorMapState({
    required List<LocationPin> locationPins,
    required PhotoViewController photoController,
    required bool isEditMode,
  }) = _FloorMapState;
}
