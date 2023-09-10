import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin.freezed.dart';

part 'pin.g.dart';

@freezed
class Pin with _$Pin {
  const factory Pin({
    required int id,
    required int x,
    required int y,
  }) = _Pin;

  factory Pin.fromJson(Map<String, Object?> json) =>
      _$PinFromJson(json);
}
