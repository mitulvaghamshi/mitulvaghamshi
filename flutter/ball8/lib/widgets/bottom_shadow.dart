import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A Widget which draws the shadow of a circlular object
@immutable
class BottomShadow extends StatelessWidget {
  const BottomShadow({super.key, required this.diameter});

  /// The diameter of the circular object being shadowed
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Transform(
      origin: Offset(0, diameter),
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}
