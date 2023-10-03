import 'package:flutter/material.dart';
import 'package:localization/constant/global_context.dart';

class SafeAreaSize {
  static double get height {
    final logicalPixel = MediaQuery.of(globalContext).size.height;
    final appBarSize = AppBar().preferredSize.height;
    final padding = MediaQuery.of(globalContext).padding.top +
        MediaQuery.of(globalContext).padding.bottom;
    return logicalPixel - appBarSize - padding;
  }
}
