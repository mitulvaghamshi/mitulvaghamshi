import 'package:flutter/material.dart';

@immutable
class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.shopping_cart, color: Colors.black);
    if (count == 0) return icon;
    return Row(children: [
      icon,
      CircleAvatar(
        radius: 8,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFFF3F3F),
        child: Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    ]);
  }
}
