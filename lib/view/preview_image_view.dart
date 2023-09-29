import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewImageView extends HookConsumerWidget {
  const PreviewImageView(
      {super.key, required this.tag, required this.imageUrl});

  final Object tag;
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
            tag: tag,
            child: Stack(
              children: [
                _appbar(context),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Image.network(imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _bottomBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.download,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
