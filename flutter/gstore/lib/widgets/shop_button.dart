import 'package:flutter/material.dart';
import 'package:gstore/utils/app_state.dart';

@immutable
class ShopButton extends StatelessWidget {
  const ShopButton({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    if (AppScope.of(context).cartItems.contains(id)) {
      return OutlinedButton(
        onPressed: () => AppWidget.of(context).removeFromCart(id),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
        ),
        child: const Text('Remove from cart'),
      );
    }
    return OutlinedButton(
      onPressed: () => AppWidget.of(context).addToCart(id),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black),
      ),
      child: const Text('Add to cart'),
    );
  }
}
