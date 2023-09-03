import 'package:flutter/material.dart';

class ColorPalette {
  static ColorScheme colorScheme = const ColorScheme.light(
    primary: primary,
    secondary: secondary,
    onPrimary: lightestGrey,
    surface: lightestGrey,
  );
  static const Color primary = Color(0xff546E7A);
  static const Color secondary = Color(0xff546E7A);
  static const Color lightestGrey = Color(0xffFAFAFA);
  static const Color grey = Color(0xff9E9E9E);
  static const Color red = Color(0xffD32F2F);
}
