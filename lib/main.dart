import 'package:flutter/material.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorPalette.colorScheme,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
