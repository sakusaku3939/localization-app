import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/constant/i208_map_size.dart';
import 'package:localization/constant/l10n.dart';
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
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            L10n.t.appBarTitle,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        actions: [
          _exportButton(ref),
          const SizedBox(width: 4),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const FloorMapView(),
          if (ref.watch(floorMapProvider).isAddMode &&
              !ref.watch(floorMapProvider).isEditState)
            Positioned(
              top: 4,
              child: Text(L10n.t.addPinGuide),
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
                      ? Text(L10n.t.close)
                      : Text(L10n.t.fabInAdd);
                },
              ),
              icon: Consumer(
                builder: (context, ref, _) {
                  return ref.watch(floorMapProvider).isAddMode
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit_location_alt);
                },
              ),
            )
          : null,
    );
  }
}

Widget _exportButton(WidgetRef ref) {
  return FilledButton.tonalIcon(
    icon: const Icon(
      Icons.camera_alt,
      color: Colors.white,
      size: 20,
    ),
    label: Text(
      L10n.t.localizationButton,
      style: const TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: kIsWeb ? 20 : 10, horizontal: 20),
      ),
    ),
    onPressed: () async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final result = await ImageUploader().uploadImage(image);
        if (result != null) {
          // シートに推定結果を表示
          final floorMapNotifier = ref.read(floorMapProvider.notifier);
          floorMapNotifier.setEditState(true);
          floorMapNotifier.addEditablePin(
            pinX: I208MapSize().convertToPinX(result.$1),
            pinY: I208MapSize().convertToPinY(result.$2),
            isPredict: true,
          );
        }
      }
    },
  );
}
