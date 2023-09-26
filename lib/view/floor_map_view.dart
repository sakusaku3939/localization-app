import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'pin_sheet.dart';

class FloorMapView extends HookConsumerWidget {
  const FloorMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    floorMapNotifier.resolveImageProvider(context);

    return WillPopScope(
      onWillPop: () async {
        ref.read(pinSheetProvider.notifier).popSheet();
        return false;
      },
      child: GestureDetector(
        onTapUp: (tapDetails) => onTapInEditMode(ref, tapDetails),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            floorMapNotifier.screenWidth = constraints.maxWidth;
            floorMapNotifier.screenHeight = constraints.maxHeight;
            return Stack(
              children: [
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: floorMapNotifier.image,
                      initialScale: PhotoViewComputedScale.contained * 2.0,
                      minScale: PhotoViewComputedScale.contained * 1.0,
                      controller: ref.read(floorMapProvider).photoController,
                    );
                  },
                  itemCount: 1,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                ),
                const LocationPins(),
                const PinSheet(),
              ],
            );
          },
        ),
      ),
    );
  }

  void onTapInEditMode(WidgetRef ref, TapUpDetails tapDetails) {
    if (ref.read(floorMapProvider).isEditMode ||
        ref.read(floorMapProvider).isAddMode) {
      // マップ上にピンを配置
      final floorMapNotifier = ref.read(floorMapProvider.notifier);
      final sheetAdjust = floorMapNotifier.calcPinSize() / 10;
      final (pinX, pinY) = floorMapNotifier.convertToMapPosition(
        pinLeft: tapDetails.localPosition.dx,
        pinTop: tapDetails.localPosition.dy + sheetAdjust,
      );
      floorMapNotifier.addEditablePin(pinX: pinX, pinY: pinY);
    }
  }
}

class LocationPins extends HookConsumerWidget {
  const LocationPins({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floorMap = ref.watch(floorMapProvider);
    if (floorMap.isEditMode || floorMap.isAddMode) {
      return Positioned(
        left: floorMap.editablePin.pinLeft,
        top: floorMap.editablePin.pinTop,
        child: Icon(
          Icons.pin_drop,
          color: ColorPalette.red,
          size: floorMap.editablePin.size,
        ),
      );
    } else {
      return Stack(
        children: [
          for (var pin in floorMap.locationPins)
            Positioned(
              left: pin.pinLeft,
              top: pin.pinTop,
              child: GestureDetector(
                onTap: () {
                  final floorMapNotifier = ref.read(floorMapProvider.notifier);
                  floorMapNotifier.setEditMode(true);
                  floorMapNotifier.addEditablePin(
                    id: pin.id,
                    pinX: pin.x,
                    pinY: pin.y,
                  );
                },
                child: Icon(
                  Icons.location_pin,
                  color: ColorPalette.red,
                  size: pin.size,
                ),
              ),
            ),
        ],
      );
    }
  }
}
