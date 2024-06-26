import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/color_palette.dart';
import 'package:localization/constant/l10n.dart';
import 'package:localization/view/preview_image_view.dart';
import 'package:localization/view_model/pin_sheet/pin_sheet_viewmodel.dart';
import 'package:localization/view_model/floor_map/floor_map_viewmodel.dart';

class PinSheet extends HookConsumerWidget {
  const PinSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSheetShow = ref.watch(pinSheetProvider).isShow;
    if (isSheetShow) {
      final sheetNotifier = ref.read(pinSheetProvider.notifier);
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            // 一番下までドラッグされたらシートを閉じる
            if (notification.extent < 0.04 && isSheetShow) {
              sheetNotifier.showBottomSheet(false);
              ref.read(floorMapProvider.notifier).resetEditablePin();
            }
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: sheetNotifier.initialSnap,
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
                          child: _body(ref),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _body(WidgetRef ref) {
    if (!ref.read(pinSheetProvider).isPredict) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            L10n.t.dataset,
            style: const TextStyle(fontSize: 16),
          ),
          _datasetCarousel(ref, true),
          const SizedBox(height: 16),
          Text(
            L10n.t.adjustCoordinates,
            style: const TextStyle(fontSize: 16),
          ),
          _coordinateInputFields(ref, false),
          const SizedBox(height: 16),
          ref.read(floorMapProvider).isAddMode
              ? _addButton(ref)
              : _updateButtons(ref),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            L10n.t.estimatedCoordinates,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          _coordinateInputFields(ref, true),
          const SizedBox(height: 16),
          Text(
            L10n.t.detectionResult,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Image.network(ref.watch(pinSheetProvider).resultImageUrl.toString()),
        ],
      );
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

  Widget _datasetCarousel(WidgetRef ref, bool isTappable) {
    final storageRefList = ref.watch(pinSheetProvider).storageRefList;
    const size = 180.0;
    const margin = EdgeInsets.only(
      top: 12,
      right: 8,
      bottom: 12,
    );
    final imageUrls = <int, String>{};
    return SizedBox(
      height: 180 + 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (storageRefList?.length ?? 0) + 1,
        itemBuilder: (context, rawIndex) {
          final index = rawIndex - 1;
          if (rawIndex == 0) {
            // 画像アップロード用のボタン
            return GestureDetector(
              onTap: isTappable
                  ? ref.read(pinSheetProvider.notifier).uploadImage
                  : null,
              child: Container(
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
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                if (imageUrls.isNotEmpty && imageUrls[index] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewImageView(
                        index: index,
                        imageUrl: imageUrls[index]!,
                      ),
                    ),
                  );
                }
              },
              child: Hero(
                tag: index,
                child: Container(
                  width: size,
                  height: size,
                  margin: margin,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: FutureBuilder(
                      future: storageRefList?[index].getDownloadURL(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<String> snapshot,
                      ) {
                        if (snapshot.hasData && snapshot.data != null) {
                          // ネットワークから画像を表示
                          imageUrls[index] = snapshot.data!;
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.fill,
                          );
                        } else {
                          // 画像URLの取得中はローダーを表示
                          return const Padding(
                            padding: EdgeInsets.all(80),
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _coordinateInputFields(WidgetRef ref, bool readonly) {
    final sheetNotifier = ref.read(pinSheetProvider.notifier);
    textField(String label, int coordinate) => TextFormField(
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: coordinate.toString(),
              selection: TextSelection.collapsed(
                offset: coordinate.toString().length,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (String value) =>
              sheetNotifier.onInputFieldsChanged(label, value),
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
          readOnly: readonly,
        );
    return Focus(
      onFocusChange: sheetNotifier.onKeyboardFocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(child: textField("X", ref.watch(pinSheetProvider).mapX)),
            const SizedBox(width: 8),
            Expanded(child: textField("Y", ref.watch(pinSheetProvider).mapY)),
          ],
        ),
      ),
    );
  }

  Widget _addButton(WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.tonalIcon(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 16,
        ),
        label: Text(
          L10n.t.addDataset,
          style: const TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
        onPressed: () => ref.read(pinSheetProvider.notifier).addDataset(),
      ),
    );
  }

  Widget _updateButtons(WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 16,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorPalette.primary),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
          ),
          onPressed: ref.read(pinSheetProvider.notifier).showDeleteDialog,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: FilledButton.tonalIcon(
            icon: const Icon(
              Icons.update,
              color: Colors.white,
              size: 16,
            ),
            label: Text(
              L10n.t.updateDataset,
              style: const TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
            ),
            onPressed: ref.read(pinSheetProvider.notifier).updateDataset,
          ),
        ),
      ],
    );
  }
}
