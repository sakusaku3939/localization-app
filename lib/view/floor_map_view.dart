import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FloorMapView extends HookConsumerWidget {
  const FloorMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floorMapNotifier = ref.read(floorMapProvider.notifier);
    floorMapNotifier.resolveImageProvider(context);

    return GestureDetector(
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
                    initialScale: PhotoViewComputedScale.contained * 3.0,
                    minScale: PhotoViewComputedScale.contained * 1.5,
                    controller: ref.read(floorMapProvider).photoController,
                  );
                },
                itemCount: 1,
                backgroundDecoration: const BoxDecoration(color: Colors.white),
              ),
              for (var location in ref.watch(floorMapProvider).locationPins)
                Positioned(
                  left: location.pinLeft,
                  top: location.pinTop,
                  child: Icon(
                    Icons.location_pin,
                    color: ColorPalette.red,
                    size: location.size,
                  ),
                ),
            ],
          );
        },
      ),
      onTapDown: (tapDownDetails) {
        final offset = tapDownDetails.localPosition;
        print(ref
            .read(floorMapProvider.notifier)
            .convertToMapPosition(pinLeft: offset.dx, pinTop: offset.dy));
      },
    );
  }
}
