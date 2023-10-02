import 'package:istore/models/product.dart';
import 'package:istore/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.lastItem,
    required this.onAdd,
  });

  final Product product;
  final bool lastItem;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            product.itemAsset,
            package: product.package,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: Styles.productItemName),
                Text('\$${product.price}', style: Styles.productItemPrice),
              ],
            ),
          ),
        ),
        CupertinoButton(
          onPressed: onAdd,
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ]),
    );

    if (lastItem) return row;

    return Column(children: [
      row,
      const Divider(
        height: 16,
        indent: 100,
        endIndent: 16,
        color: Styles.productDivider,
      ),
    ]);
  }
}
