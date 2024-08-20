import 'package:flutter/material.dart';
import 'package:gstore/models/app_scope.dart';

@immutable
class ShopButton extends StatelessWidget {
  const ShopButton({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    if (AppScope.of(context).cart.contains(id)) {
      return OutlinedButton(
        onPressed: () => AppScope.of(context).removeFromCart(id),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
        ),
        child: const Text('Remove from cart'),
      );
    }
    return OutlinedButton(
      onPressed: () => AppScope.of(context).addToCart(id),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green,
        side: const BorderSide(color: Colors.green),
      ),
      child: const Text('Add to cart'),
    );
  }
}
