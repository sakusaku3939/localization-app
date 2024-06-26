import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localization/constant/global_context.dart';
import 'package:localization/constant/l10n.dart';
import 'package:localization/view/helper/snackbar_helper.dart';

class ImageUploader {
  static final ImageUploader instance = ImageUploader._internal();

  ImageUploader._internal();

  factory ImageUploader() => instance;

  Future<(int, int, String)?> uploadImage(XFile image) async {
    const url = "http://133.27.171.97:5000";
    showLoader();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$url/upload"),
    );
    request.headers.addAll({
      "AccessToken": "62BA9128-BC63-4865-9F92-B332BB4D682C",
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await image.readAsBytes().then((value) {
          return value.cast();
        }),
        filename: image.path.toString() + image.name,
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      closeLoader();

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)[0];
        final double x = json["x"];
        final double y = json["y"];
        final resultImageUrl = url + json["result_url"];
        final time = json["time"].toStringAsFixed(2);

        SnackBarHelper().show(L10n.t.estimationCompleted(time, x, y));
        _log('Response from server: ${response.body}');
        return (x.round(), y.round(), resultImageUrl);
      } else {
        SnackBarHelper().show(L10n.t.failedUploadImage(response.body));
        _log('Failed to upload image: ${response.body}');
        return null;
      }
    } catch (e) {
      SnackBarHelper().show(L10n.t.failedUploadImage(e));
      _log('Failed to upload image: $e');
      closeLoader();
      return null;
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
