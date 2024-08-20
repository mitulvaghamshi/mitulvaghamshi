import 'package:flutter/material.dart';
import 'package:google_store/states/app_scope.dart';

@immutable
class ShopButton extends StatelessWidget {
  const ShopButton({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final model = AppScope.of(context);
    if (model.cart.contains(id)) {
      return OutlinedButton(
        onPressed: () => model.removeFromCart(id),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const .new(color: Colors.red),
        ),
        child: const Text('Remove from cart'),
      );
    }
    return OutlinedButton(
      onPressed: () => model.addToCart(id),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green,
        side: const .new(color: Colors.green),
      ),
      child: const Text('Add to cart'),
    );
  }
}
