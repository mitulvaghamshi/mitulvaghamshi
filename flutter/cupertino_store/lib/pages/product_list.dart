import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@immutable
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final _model = Provider.of<AppState>(context, listen: false);
  late final _focusNode = FocusNode();
  final _format = NumberFormat.simpleCurrency();

  Iterable<Product> _products = const Iterable.empty();

  void _onSearch(String term) =>
      setState(() => _products = _model.search(term));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onSearch('');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Cupertino Store')),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .all(16),
          child: CupertinoSearchTextField(
            onChanged: _onSearch,
            focusNode: _focusNode,
            placeholder: 'Search products...',
          ),
        ),
      ),
      SliverList.separated(
        itemCount: _products.length,
        separatorBuilder: (_, index) =>
            const Divider(indent: 120, endIndent: 16),
        itemBuilder: (_, index) => _ProductItem(
          product: _products.elementAt(index),
          format: _format,
          onClick: _model.addToCart,
        ),
      ),
    ],
  );
}

@immutable
class _ProductItem extends StatelessWidget {
  const _ProductItem({
    required this.product,
    required this.format,
    required this.onClick,
  });

  final Product product;
  final NumberFormat format;
  final ValueChanged<int> onClick;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    leadingSize: 100,
    leading: ClipRRect(
      borderRadius: .circular(4),
      child: Image.asset(
        product.thumb,
        package: product.package,
        fit: .cover,
        width: 100,
        height: 100,
      ),
    ),
    title: Text(product.name, style: Styles.productItemName),
    subtitle: Text(
      format.format(product.price),
      style: Styles.productPriceStyle,
    ),
    trailing: CupertinoButton(
      onPressed: () => onClick(product.id),
      child: const Icon(CupertinoIcons.add_circled),
    ),
  );
}
