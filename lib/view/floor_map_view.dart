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
    if (!ref.read(floorMapProvider).isEditMode) {
      return;
    }
    ref.read(floorMapProvider.notifier).addEditablePin(
          x: tapDetails.localPosition.dx,
          y: tapDetails.localPosition.dy,
        );
  }
}

class LocationPins extends HookConsumerWidget {
  const LocationPins({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(floorMapProvider).isEditMode) {
      return Stack(
        children: [
          for (var pin in ref.watch(floorMapProvider).locationPins)
            Positioned(
              left: pin.pinLeft,
              top: pin.pinTop,
              child: GestureDetector(
                onTap: () {
                  ref.read(pinSheetProvider.notifier).showBottomSheet(
                        true,
                        pin: pin,
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
    } else {
      final pin = ref.watch(floorMapProvider).editablePin;
      return Positioned(
        left: pin.pinLeft,
        top: pin.pinTop,
        child: Icon(
          Icons.pin_drop,
          color: ColorPalette.red,
          size: pin.size,
        ),
      );
    }
  }
}
