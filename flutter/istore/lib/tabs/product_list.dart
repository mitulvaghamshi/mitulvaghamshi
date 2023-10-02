import 'package:istore/models/app_state.dart';
import 'package:istore/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller = TextEditingController()
    ..addListener(() => setState(() => _term = _controller.text));
  String _term = '';

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context, listen: false);
    final products = model.search(_term);
    return CustomScrollView(semanticChildCount: products.length, slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Cupertino Store')),
      SliverSafeArea(sliver: SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoTextField(
                focusNode: _focusNode,
                controller: _controller,
                placeholder: 'Search products...',
                clearButtonMode: OverlayVisibilityMode.always,
              ),
            );
          }
          if (index - 1 < products.length) {
            final product = products.elementAt(index - 1);
            return ProductItem(
              product: product,
              lastItem: index == products.length,
              onAdd: () => model.addToCart(product.id),
            );
          }
          return null;
        }),
      )),
    ]);
  }
}
