import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/models/product.dart';
import 'package:provider/provider.dart';

@immutable
class ProductsGallery extends StatelessWidget {
  const ProductsGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<AppState>(context, listen: false).inventorySize;
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Products Gallery')),
      SliverSafeArea(
        minimum: EdgeInsets.all(16),
        sliver: SliverToBoxAdapter(child: _GalleryWidget(count: count)),
      )
    ]);
  }
}

@immutable
class _GalleryWidget extends StatelessWidget {
  _GalleryWidget({required this.count});

  final int count;

  late final currentCard = ValueNotifier(count - 1.0);
  late final controller = PageController(initialPage: count - 1)
    ..addListener(_onPageChange);

  void _onPageChange() => currentCard.value = controller.page!;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context, listen: false);
    return Stack(children: [
      ValueListenableBuilder(
        valueListenable: currentCard,
        builder: (context, value, child) => AspectRatio(
          aspectRatio: 12 / 18 * 1.2,
          child: LayoutBuilder(
            builder: (_, constraints) => Stack(
              children: List.generate(count, (index) {
                return _GalleryItem(
                  product: model.getProductBy(index),
                  index: index,
                  currentCard: value,
                  constraints: constraints,
                );
              }),
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          reverse: true,
          itemCount: count,
          controller: controller,
          itemBuilder: (_, __) => const SizedBox(),
        ),
      ),
    ]);
  }
}

@immutable
class _GalleryItem extends StatelessWidget {
  const _GalleryItem({
    required this.product,
    required this.index,
    required this.currentCard,
    required this.constraints,
  });

  final Product product;
  final int index;
  final double currentCard;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final cardRatio = 12 / 18;
    final cardLeft = constraints.maxWidth - constraints.maxHeight * cardRatio;
    final delta = index + 1 - currentCard;
    final leftPad = cardLeft - cardLeft / 2 * -delta * (delta > 0 ? 20 : 1);
    return Positioned.directional(
      textDirection: TextDirection.rtl,
      start: math.max(0, leftPad),
      top: 32 * math.max(-delta, 0),
      bottom: 32 * math.max(-delta, 0),
      child: AspectRatio(
        aspectRatio: cardRatio,
        child: _GalleryContent(product: product),
      ),
    );
  }
}

@immutable
class _GalleryContent extends StatelessWidget {
  const _GalleryContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(fit: StackFit.expand, children: [
        Image.asset(product.asset, package: product.package, fit: BoxFit.cover),
        Positioned(
          left: 16,
          bottom: 16,
          child: Card.filled(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(product.name, style: TextStyle(fontSize: 22)),
            ),
          ),
        )
      ]),
    );
  }
}
