import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:localization/view_model/floor_map/location_pin/location_pin.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FloorMapView extends HookConsumerWidget {
  const FloorMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    floorMapNotifier.resolveImageProvider(context);

    return GestureDetector(
      onTapUp: (tapDetails) => onTapEditMode(ref, tapDetails),
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
                backgroundDecoration: const BoxDecoration(color: Colors.white),
              ),
              const LocationPins(),
            ],
          );
        },
      ),
    );
  }

  void onTapEditMode(WidgetRef ref, TapUpDetails tapDetails) {
    if (!ref.read(floorMapProvider).isEditMode) {
      return;
    }
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    final pinSize = floorMapNotifier.calculatePinSize();
    final pinLeft = tapDetails.localPosition.dx - pinSize / 2;
    final pinTop = tapDetails.localPosition.dy - pinSize / 2;

    final mapPosition = floorMapNotifier.convertToMapPosition(
      pinLeft: pinLeft,
      pinTop: pinTop,
    );
    floorMapNotifier.updateEditPin(
      LocationPin(
        id: 0,
        x: mapPosition[0],
        y: mapPosition[1],
        pinLeft: pinLeft,
        pinTop: pinTop,
        size: floorMapNotifier.calculatePinSize(),
      ),
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
          for (var location in ref.watch(floorMapProvider).locationPins)
            Positioned(
              left: location.pinLeft,
              top: location.pinTop,
              child: GestureDetector(
                onTap: () {
                  print("tapped pin");
                },
                child: Icon(
                  Icons.location_pin,
                  color: ColorPalette.red,
                  size: location.size,
                ),
              ),
            ),
        ],
      );
    } else {
      final location = ref.watch(floorMapProvider).editPin;
      return Positioned(
        left: location.pinLeft,
        top: location.pinTop,
        child: Icon(
          Icons.location_searching,
          color: ColorPalette.red,
          size: location.size,
        ),
      );
    }
  }
}
