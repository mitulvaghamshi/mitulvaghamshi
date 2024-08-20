import 'package:flutter/material.dart';
import 'package:google_store/models/product.dart';
import 'package:google_store/widgets/shop_button.dart';

@immutable
class const ProductTile({required final Product product, super.key})
    extends StatelessWidget {
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
            style: const .new(fontSize: 18, fontWeight: .bold),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: product.line1.$1,
                style: .new(color: product.line1.$2),
              ),
              TextSpan(
                text: product.line2.$1,
                style: .new(color: product.line2.$2),
              ),
            ],
          ),
          textAlign: .center,
          style: const .new(fontSize: 20, fontWeight: .bold),
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
