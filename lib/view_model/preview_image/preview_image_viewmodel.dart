import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/constant/global_context.dart';
import 'package:localization/view/helper/dialog_helper.dart';
import 'package:localization/view/helper/snackbar_helper.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';
import 'package:uuid/uuid.dart';

final previewImageProvider =
    StateNotifierProvider.autoDispose<PreviewImageViewModel, int>(
  (ref) => PreviewImageViewModel(ref),
);

class PreviewImageViewModel extends StateNotifier<int> {
  final Ref ref;

  PreviewImageViewModel(this.ref) : super(0);

  Future<void> downloadImage(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      final directory = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS,
      );
      final file = File("$directory/${const Uuid().v4()}.jpg");
      await file.create();
      await file.writeAsBytes(res.bodyBytes);
      SnackBarHelper().show("画像をダウンロードしました");
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      SnackBarHelper().show("エラー: $e");
    }
  }

  Future<void> deleteImage(int index) async {
    await DialogHelper().show(
      title: "削除の確認",
      content: "画像を削除しますか？この操作は元に戻せません。",
      okButton: "削除",
      onOkClick: () {
        Navigator.of(globalContext)
          ..pop()
          ..pop();
        ref.read(pinSheetProvider.notifier).deleteImage(index);
      },
    );
  }
}
