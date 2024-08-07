import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';
import 'package:gstore/widgets/shop_button.dart';

@immutable
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(product.title),
        ),
        Text.rich(
          product.info,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ShopButton(id: product.id),
        ),
        Image.asset(product.img),
      ]),
    );
  }
}
