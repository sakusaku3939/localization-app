import 'package:flutter/material.dart';
import 'package:localization/view/floor_map.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "湘南台駅 地下1階",
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          _exportButton(),
          const SizedBox(width: 4),
        ],
      ),
      body: const FloorMap(),
    );
  }
}

Widget _exportButton() {
  return FilledButton.tonalIcon(
    icon: const Icon(
      Icons.file_download,
      color: Colors.white,
    ),
    label: const Text(
      "Export",
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    ),
    onPressed: () {},
  );
}
