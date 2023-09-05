import 'package:flutter/material.dart';
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
            ref.read(floorMapProvider.notifier).resetEditPin();
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
                      Container(
                        height: 120,
                      )
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
}