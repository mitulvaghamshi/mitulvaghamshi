import 'package:flutter/material.dart';
import 'package:google_store/models/product.dart';
import 'package:google_store/widgets/shop_button.dart';

@immutable
class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(20),
    child: Column(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: const .all(20),
          child: Text(
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: .bold),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: product.line1.$1,
                style: TextStyle(color: product.line1.$2),
              ),
              TextSpan(
                text: product.line2.$1,
                style: TextStyle(color: product.line2.$2),
              ),
            ],
          ),
          textAlign: .center,
          style: const TextStyle(fontSize: 20, fontWeight: .bold),
        ),
        Padding(
          padding: const .all(20),
          child: ShopButton(id: product.id.toString()),
        ),
        Image.asset(product.image),
      ],
    ),
  );
}
