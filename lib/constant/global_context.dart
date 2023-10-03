import 'package:flutter/material.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

BuildContext get globalContext =>
    globalNavigatorKey.currentState!.overlay!.context;
