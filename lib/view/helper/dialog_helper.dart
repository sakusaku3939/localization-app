import 'package:flutter/material.dart';
import 'package:localization/constant/global_context.dart';

class DialogHelper {
  static final DialogHelper instance = DialogHelper._internal();

  DialogHelper._internal();

  factory DialogHelper() => instance;

  Future<void> show({
    required String title,
    required String content,
    required String okButton,
    required void Function() onOkClick,
  }) async {
    await showDialog(
      context: globalContext,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          content: Text(content),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
          actions: [
            TextButton(
              child: const Text("キャンセル"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              onPressed: onOkClick,
              child: Text(okButton),
            ),
          ],
        );
      },
    );
  }

  Future<void> showOkDialog({
    required String title,
    required String content,
    required String okButton,
    void Function()? onOkClick,
  }) async {
    await showDialog(
      context: globalContext,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          content: Text(content),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
          actions: [
            TextButton(
              onPressed: onOkClick ?? () => Navigator.pop(context),
              child: Text(okButton),
            ),
          ],
        );
      },
    );
  }

  void showLoader() {
    showGeneralDialog(
      context: globalContext,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 250),
      barrierColor: Colors.transparent,
      pageBuilder: (
        BuildContext context,
        Animation animation,
        Animation secondaryAnimation,
      ) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void closeLoader() {
    Navigator.pop(globalContext);
  }
}
