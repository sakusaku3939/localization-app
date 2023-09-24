import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_sheet_state.freezed.dart';

@freezed
class PinSheetState with _$PinSheetState {
  const factory PinSheetState({
    required bool isShow,
    required int id,
    required int pinX,
    required int pinY,
    required List<Reference>? storageRefList,
  }) = _PinSheetState;
}
