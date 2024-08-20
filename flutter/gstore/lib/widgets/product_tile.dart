import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';
import 'package:gstore/widgets/shop_button.dart';

@immutable
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(20),
    child: Column(
      mainAxisAlignment: .center,
      children: [
        Padding(padding: const .all(20), child: Text(product.title)),
        Text.rich(
          product.info,
          textAlign: .center,
          style: const TextStyle(fontSize: 20, fontWeight: .bold),
        ),
        Padding(
          padding: const .all(20),
          child: ShopButton(id: product.id.toString()),
        ),
        Image.asset(product.img),
      ],
    ),
  );
}
