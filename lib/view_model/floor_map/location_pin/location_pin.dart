import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_pin.freezed.dart';

part 'location_pin.g.dart';

@freezed
class LocationPin with _$LocationPin {
  const factory LocationPin({
    required int id,
    required double x,
    required double y,
    required double pinLeft,
    required double pinTop,
  }) = _LocationPin;

  factory LocationPin.fromJson(Map<String, Object?> json) =>
      _$LocationPinFromJson(json);
}
