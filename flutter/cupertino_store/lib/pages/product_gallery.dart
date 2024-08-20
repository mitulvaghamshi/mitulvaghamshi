import 'dart:math' as math;

import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _cardRatio = 12 / 18;

@immutable
class ProductsGallery extends StatelessWidget {
  const ProductsGallery({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Products Gallery')),
      SliverPadding(
        padding: .symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: _GalleryWidget(count: context.read<AppState>().inventorySize),
        ),
      ),
    ],
  );
}

@immutable
class _GalleryWidget extends StatefulWidget {
  const _GalleryWidget({required this.count});

  final int count;

  @override
  State<_GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<_GalleryWidget> {
  late final _activeCard = ValueNotifier(widget.count - 1.0);
  late final _pageCtrl = PageController(initialPage: widget.count - 1)
    ..addListener(_onPageChanged);

  void _onPageChanged() => _activeCard.value = _pageCtrl.page!;

  @override
  void dispose() {
    _pageCtrl.removeListener(_onPageChanged);
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      AspectRatio(
        aspectRatio: _cardRatio,
        child: ValueListenableBuilder(
          valueListenable: _activeCard,
          builder: (context, value, child) => Stack(
            children: .generate(widget.count, (index) {
              return _GalleryItem(index: index, activeCard: value);
            }),
          ),
        ),
      ),
      Positioned.fill(
        child: PageView.builder(
          reverse: true,
          itemCount: widget.count,
          controller: _pageCtrl,
          itemBuilder: (_, _) => const SizedBox(),
        ),
      ),
    ],
  );
}

@immutable
class _GalleryItem extends StatelessWidget {
  const _GalleryItem({required this.index, required this.activeCard});

  final int index;
  final double activeCard;

  @override
  Widget build(BuildContext context) {
    final delta = index + 1 - activeCard;
    final width = MediaQuery.sizeOf(context).width;
    final leftPad = width - width / 2 * -delta * (delta > 0 ? 0 : 1.8);

    return Positioned.directional(
      textDirection: .rtl,
      start: math.max(0, leftPad),
      top: 32 * math.max(-delta, 0),
      bottom: 32.0 * math.max(-delta, 0),
      child: _GalleryContent(index: index),
    );
  }
}

@immutable
class _GalleryContent extends StatelessWidget {
  const _GalleryContent({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final product = context.read<AppState>().getProductBy(index);
    return AspectRatio(
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
}
