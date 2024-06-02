import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_sheet_state.freezed.dart';

@freezed
class PinSheetState with _$PinSheetState {
  const factory PinSheetState({
    required bool isShow,
    required bool isPredict,
    required String id,
    required int mapX,
    required int mapY,
    required List<Reference>? storageRefList,
    String? resultImageUrl,
  }) = _PinSheetState;
}
