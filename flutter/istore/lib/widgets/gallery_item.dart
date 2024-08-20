import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/models/product.dart';
import 'package:provider/provider.dart';

@immutable
class GalleryItem extends StatelessWidget {
  const GalleryItem({
    super.key,
    required this.index,
    required this.currentCard,
    required this.constraints,
  });

  final int index;
  final double currentCard;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<AppState>(context, listen: false) //
        .getProductBy(index);
    final cardLeft = constraints.maxWidth - constraints.maxHeight * 12.0 / 18.0;
    final delta = index + 1 - currentCard;
    return Positioned.directional(
      textDirection: TextDirection.rtl,
      start: max(0.0, cardLeft - cardLeft / 2 * -delta * (delta > 0 ? 20 : 1)),
      top: 32 * max(-delta, 0),
      bottom: 32 * max(-delta, 0),
      child: AspectRatio(
        aspectRatio: 12.0 / 18.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(
              product.galleryAsset,
              package: product.package,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints.expand(height: 40),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                ),
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
