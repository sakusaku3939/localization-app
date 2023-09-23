import 'package:flutter/material.dart';
import 'package:localization/helper/current.dart';

class SnackBarHelper {
  static final SnackBarHelper instance = SnackBarHelper._internal();

  SnackBarHelper._internal();

  factory SnackBarHelper() => instance;

  void show(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(Current.context).showSnackBar(snackBar);
  }
}
