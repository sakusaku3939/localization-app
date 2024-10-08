import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/constant/l10n.dart';
import 'package:localization/view_model/preview_image/preview_image_viewmodel.dart';

class PreviewImageView extends HookConsumerWidget {
  const PreviewImageView({
    super.key,
    required this.index,
    required this.imageUrl,
  });

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: DismissiblePage(
          onDismissed: () {
            Navigator.of(context).pop();
          },
          direction: DismissiblePageDismissDirection.multi,
          child: Hero(
            tag: index,
            child: Stack(
              children: [
                _appbar(ref),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Image.network(imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: _bottomBar(ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appbar(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: IconButton(
        onPressed: () => Navigator.of(ref.context).pop(),
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _bottomBar(WidgetRef ref) {
    final previewImageNotifier = ref.read(previewImageProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomBarButton(
            Icons.download,
            L10n.t.save,
            () => previewImageNotifier.downloadImage(imageUrl),
          ),
          _bottomBarButton(
            Icons.delete_outline,
            L10n.t.delete,
            () => previewImageNotifier.deleteImage(index),
          ),
        ],
      ),
    );
  }

  Widget _bottomBarButton(IconData icon, String text, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
