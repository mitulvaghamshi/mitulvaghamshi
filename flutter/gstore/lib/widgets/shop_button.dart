import 'package:flutter/material.dart';
import 'package:gstore/models/app_scope.dart';

@immutable
class ShopButton extends StatelessWidget {
  const ShopButton({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final model = AppScope.of(context);
    if (model.cart.contains(id)) {
      return OutlinedButton(
        onPressed: () => model.removeFromCart(id),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
        ),
        child: const Text('Remove from cart'),
      );
    }
    return OutlinedButton(
      onPressed: () => model.addToCart(id),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green,
        side: const BorderSide(color: Colors.green),
      ),
      child: const Text('Add to cart'),
    );
  }
}
