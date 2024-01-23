import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/model/image_uploader.dart';
import 'package:localization/view/floor_map_view.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "ι208研究室 フロアマップ",
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          _exportButton(),
          const SizedBox(width: 4),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const FloorMapView(),
          if (!ref.watch(floorMapProvider).isAddMode &&
              !ref.watch(floorMapProvider).isEditMode)
            const Positioned(
              top: 4,
              child: Text("編集したいピンを選択"),
            ),
        ],
      ),
      floatingActionButton: !ref.watch(pinSheetProvider).isShow
          ? FloatingActionButton.extended(
              onPressed: () {
                ref
                    .read(floorMapProvider.notifier)
                    .setAddMode(!ref.read(floorMapProvider).isAddMode);
              },
              label: Consumer(
                builder: (context, ref, _) {
                  return ref.watch(floorMapProvider).isAddMode
                      ? const Text("ピンを選択")
                      : const Text("閉じる");
                },
              ),
              icon: Consumer(
                builder: (context, ref, _) {
                  return ref.watch(floorMapProvider).isAddMode
                      ? const Icon(Icons.edit_location_alt)
                      : const Icon(Icons.close);
                },
              ),
            )
          : null,
    );
  }
}

Widget _exportButton() {
  return FilledButton.tonalIcon(
    icon: const Icon(
      Icons.camera_alt,
      color: Colors.white,
      size: 20,
    ),
    label: const Text(
      "位置推定",
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    ),
    onPressed: () async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        await ImageUploader().uploadImage(image);
      }
    },
  );
}
