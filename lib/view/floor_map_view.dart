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
                backgroundDecoration: const BoxDecoration(color: Colors.white),
              ),
              const LocationPins(),
              DraggableScrollableSheet(
                initialChildSize: 0.12,
                minChildSize: 0,
                maxChildSize: 0.5,
                snapSizes: const [0.12],
                snap: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 32,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            color: ColorPalette.grey,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(title: Text('Item $index'));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void onTapInEditMode(WidgetRef ref, TapUpDetails tapDetails) {
    if (!ref.read(floorMapProvider).isEditMode) {
      return;
    }
    ref.read(floorMapProvider.notifier).addEditPin(
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
          Icons.pin_drop,
          color: ColorPalette.red,
          size: location.size,
        ),
      );
    }
  }
}
