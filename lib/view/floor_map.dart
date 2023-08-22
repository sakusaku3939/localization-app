import 'package:flutter/material.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FloorMap extends StatelessWidget {
  const FloorMap({super.key});

  @override
  Widget build(BuildContext context) {
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
              imageProvider: const AssetImage("assets/images/shonandai_floor_map.png"),
              initialScale: PhotoViewComputedScale.contained * 3.0,
              minScale: PhotoViewComputedScale.contained * 1.5,
            );
          },
          itemCount: 1,
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        ),
        const Positioned(
          child: Icon(
            Icons.location_pin,
            color: ColorPalette.red,
          ),
        ),
      ],
    );
  }
}
