import 'package:flutter/material.dart';

@immutable
class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.shopping_cart, color: Colors.black),
      if (count > 0)
        CircleAvatar(
          radius: 8,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          child: Text(
            count.toString(),
            style: const TextStyle(fontSize: 10, fontWeight: .bold),
          ),
        ),
    ],
  );
}
