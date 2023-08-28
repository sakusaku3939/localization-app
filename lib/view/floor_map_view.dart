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
    return Stack(
      children: [
        PhotoView(
          imageProvider:
              const AssetImage("assets/images/shonandai_floor_map.png"),
          backgroundDecoration: const BoxDecoration(color: Colors.white),
        ),
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: const AssetImage(
                "assets/images/shonandai_floor_map.png",
              ),
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
            child: const Icon(
              Icons.location_pin,
              color: ColorPalette.red,
            ),
          ),
      ],
    );
  }
}
