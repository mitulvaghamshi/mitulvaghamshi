import 'package:flutter/material.dart';

@immutable
class CartIcon extends StatelessWidget {
  const CartIcon({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Padding(
        padding: .fromLTRB(0, 16, 16, 16),
        child: Icon(Icons.shopping_cart),
      ),
      if (count > 0)
        Positioned.directional(
          top: 8,
          end: 8,
          textDirection: .ltr,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Text(
              count.toString(),
              style: const TextStyle(fontSize: 10, fontWeight: .bold),
            ),
          ),
        ),
    ],
  );
}
