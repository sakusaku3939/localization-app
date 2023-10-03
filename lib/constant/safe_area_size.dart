import 'package:flutter/material.dart';
import 'package:localization/constant/global_state.dart';

class SafeAreaSize {
  static double get height {
    final logicalPixel = MediaQuery.of(GlobalState.context).size.height;
    final appBarSize = AppBar().preferredSize.height;
    final padding = MediaQuery.of(GlobalState.context).padding.top +
        MediaQuery.of(GlobalState.context).padding.bottom;
    return logicalPixel - appBarSize - padding;
  }
}
