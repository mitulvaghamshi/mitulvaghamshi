import 'package:cupertino_store/models/product.dart';
import 'package:flutter/material.dart';

const _cardRatio = 12 / 18;

@immutable
class GalleryContent extends StatelessWidget {
  const GalleryContent({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: _cardRatio,
    child: ClipRRect(
      borderRadius: .circular(16),
      child: Stack(
        fit: .expand,
        children: [
          Image.asset(product.asset, package: product.package, fit: .cover),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Card.outlined(
              child: Padding(
                padding: const .symmetric(vertical: 4, horizontal: 8),
                child: Text(product.name, textAlign: .center),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
