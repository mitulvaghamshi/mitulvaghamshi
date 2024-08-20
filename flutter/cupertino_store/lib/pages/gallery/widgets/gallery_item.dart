import 'dart:math' as math;

import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/pages/gallery/widgets/gallery_content.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GalleryItem extends StatelessWidget {
  const GalleryItem({
    super.key,
    required this.pageIndex,
    required this.activeCard,
    required this.product,
  });

  final int pageIndex;
  final double activeCard;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final delta = pageIndex + 1 - activeCard;
    final width = MediaQuery.sizeOf(context).width;
    final leftPad = width - width / 2 * -delta * (delta > 0 ? 0 : 1.8);
    return Positioned.directional(
      textDirection: .rtl,
      start: math.max(0, leftPad),
      top: 32 * math.max(-delta, 0),
      bottom: 32.0 * math.max(-delta, 0),
      child: GalleryContent(product: product),
    );
  }
}
