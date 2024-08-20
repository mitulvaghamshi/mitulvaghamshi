import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/pages/gallery/widgets/gallery_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class ProductsGallery extends StatelessWidget {
  const ProductsGallery({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Products Gallery')),
      SliverPadding(
        padding: const .symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: GalleryWidget(count: context.read<AppState>().inventorySize),
        ),
      ),
    ],
  );
}
