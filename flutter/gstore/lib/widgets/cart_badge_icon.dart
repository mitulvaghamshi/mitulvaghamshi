import 'package:flutter/material.dart';
import 'package:gstore/utils/app_state.dart';

@immutable
class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsInCart = AppScope.of(context).cartItems;
    return Row(children: [
      const Icon(Icons.shopping_cart, color: Colors.black),
      if (itemsInCart.isNotEmpty)
        CircleAvatar(
          radius: 8,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFFF3F3F),
          child: Text(
            itemsInCart.length.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
    ]);
  }
}
