import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_view_state.freezed.dart';

part 'photo_view_state.g.dart';

@freezed
class PhotoViewState with _$PhotoViewState {
  const factory PhotoViewState({
    required double dx,
    required double dy,
    required double width,
    required double height,
    required double scale,
    required double defaultImageScale,
  }) = _PhotoViewState;

  factory PhotoViewState.fromJson(Map<String, Object?> json) =>
      _$PhotoViewStateFromJson(json);
}
