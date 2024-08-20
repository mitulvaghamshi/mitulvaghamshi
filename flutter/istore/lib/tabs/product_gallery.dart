import 'package:flutter/cupertino.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/widgets/gallery_widget.dart';
import 'package:provider/provider.dart';

@immutable
class ProductsGallery extends StatelessWidget {
  const ProductsGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<AppState>(context, listen: false).inventorySize;
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Products Gallery')),
      SliverToBoxAdapter(
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: GalleryWidget(count: count),
        ),
      ),
    ]);
  }
}
