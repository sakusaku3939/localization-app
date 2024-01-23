import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localization/constant/global_context.dart';
import 'package:localization/view/helper/dialog_helper.dart';
import 'package:localization/view/helper/snackbar_helper.dart';

class ImageUploader {
  static final ImageUploader instance = ImageUploader._internal();

  ImageUploader._internal();

  factory ImageUploader() => instance;

  Future uploadImage(XFile image) async {
    showLoader();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.10.0.85:5000/upload'),
    );
    const token = "326E5FFC-D86C-4AD9-AB7D-C887C937F21B";
    request.headers.addAll({"AccessToken": token});
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await image.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: image.path.toString() + image.name,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    closeLoader();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)[0];
      final x = json["x"].toStringAsFixed(4);
      final y = json["y"].toStringAsFixed(4);
      final time = json["time"].toStringAsFixed(2);
      DialogHelper().showOkDialog(
        title: "推定結果",
        content: "X: $x、Y: $y\nかかった時間: $time秒",
        okButton: "閉じる",
      );
      _log('Response from server: ${response.body}');
    } else {
      SnackBarHelper().show("画像のアップロードに失敗しました： ${response.body}");
      _log('Failed to upload image: ${response.body}');
    }
  }

  void showLoader() {
    showGeneralDialog(
      context: globalContext,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, Animation animation, Animation secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void closeLoader() => Navigator.pop(globalContext);

  void _log(dynamic t) {
    if (kDebugMode) {
      print(t);
    }
  }
}
