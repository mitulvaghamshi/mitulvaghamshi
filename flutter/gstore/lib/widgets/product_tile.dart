import 'package:flutter/material.dart';
import 'package:gstore/utils/server.dart';
import 'package:gstore/widgets/shop_button.dart';

@immutable
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final product = Server.getProductBy(id);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ColoredBox(
        color: const Color(0xfff8f8f8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(product.title),
          ),
          Text.rich(
            product.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ShopButton(id: id),
          ),
          Image.asset(product.pictureURL),
        ]),
      ),
    );
  }
}
