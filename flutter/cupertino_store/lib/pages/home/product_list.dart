import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/pages/home/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final _model = context.read<AppState>();

  Iterable<Product> _products = const .empty();

  void _onSearch(String term) =>
      setState(() => _products = _model.search(term));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      CupertinoSliverNavigationBar.search(
        largeTitle: const Text('Cupertino Store'),
        searchField: CupertinoSearchTextField(
          onChanged: _onSearch,
          placeholder: 'Search products...',
        ),
      ),
      SliverList.separated(
        itemCount: _products.length,
        separatorBuilder: (_, index) =>
            const Divider(indent: 120, endIndent: 16),
        itemBuilder: (_, index) => ProductItem(
          onClick: _model.addToCart,
          product: _products.elementAt(index),
        ),
      ),
    ],
  );
}
