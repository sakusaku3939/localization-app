import 'package:flutter/material.dart';

class GlobalState {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;
}
