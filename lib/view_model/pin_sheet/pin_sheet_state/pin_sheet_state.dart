import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_sheet_state.freezed.dart';

@freezed
class PinSheetState with _$PinSheetState {
  const factory PinSheetState({
    required bool isShow,
  }) = _PinSheetState;
}
