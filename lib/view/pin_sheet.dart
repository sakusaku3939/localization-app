import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';

class PinSheet extends HookConsumerWidget {
  const PinSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(pinSheetProvider).isShow) {
      final sheetNotifier = ref.read(pinSheetProvider.notifier);
      return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          // 一番下までドラッグされたらシートを閉じる
          if (notification.extent < 0.04) {
            sheetNotifier.showBottomSheet(false);
            ref.read(floorMapProvider.notifier).resetEditablePin();
          }
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: sheetNotifier.snaps.last,
          minChildSize: sheetNotifier.snaps.first,
          maxChildSize: sheetNotifier.snaps.last,
          snapSizes: sheetNotifier.snaps,
          controller: sheetNotifier.controller,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) {
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
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  // スクロール時のエフェクトをoffにする
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      _dragHandle(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              "データセット",
                              style: TextStyle(fontSize: 16),
                            ),
                            _datasetCarousel(),
                            const SizedBox(height: 16),
                            const Text(
                              "座標の調整",
                              style: TextStyle(fontSize: 16),
                            ),
                            _coordinateInputFields(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _dragHandle() {
    return Container(
      width: 32,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        color: ColorPalette.grey,
      ),
    );
  }

  Widget _datasetCarousel() {
    const size = 180.0;
    const margin = EdgeInsets.only(
      top: 12,
      right: 8,
      bottom: 12,
    );
    return SizedBox(
      height: 180 + 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              width: size,
              height: size,
              margin: margin,
              decoration: BoxDecoration(
                color: ColorPalette.lightGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(28),
                ),
                border: Border.all(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: ColorPalette.grey,
                size: 32,
              ),
            );
          } else {
            return Container(
              width: size,
              height: size,
              margin: margin,
              decoration: const BoxDecoration(
                color: ColorPalette.lightGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _coordinateInputFields() {
    textField(String label) => TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: ColorPalette.darkGrey,
              ),
            ),
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: textField("X")),
          const SizedBox(width: 8),
          Expanded(child: textField("Y")),
        ],
      ),
    );
  }
}
