import 'package:freezed_annotation/freezed_annotation.dart';

part 'geolocation_state.freezed.dart';

part 'geolocation_state.g.dart';

@freezed
class GeolocationState with _$GeolocationState {
  const factory GeolocationState({
    required double longitude,
    required double latitude,
    required double accuracy,
    required double heading,
    required double headingAccuracy,
  }) = _GeolocationState;

  factory GeolocationState.fromJson(Map<String, Object?> json) =>
      _$GeolocationStateFromJson(json);
}
