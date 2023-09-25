import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_pin.freezed.dart';

part 'location_pin.g.dart';

@freezed
class LocationPin with _$LocationPin {
  const factory LocationPin({
    required String id,
    required int x,
    required int y,
    required double pinLeft,
    required double pinTop,
    required double size,
  }) = _LocationPin;

  factory LocationPin.fromJson(Map<String, Object?> json) =>
      _$LocationPinFromJson(json);
}
