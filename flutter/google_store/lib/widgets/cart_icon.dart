import 'package:flutter/material.dart';

@immutable
class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Padding(
        padding: const .fromLTRB(0, 16, 16, 16),
        child: const Icon(Icons.shopping_cart),
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
