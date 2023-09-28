import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewImageView extends HookConsumerWidget {
  const PreviewImageView(
      {super.key, required this.tag, required this.imageUrl});

  final Object tag;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.multi,
        child: Hero(
          tag: tag,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
