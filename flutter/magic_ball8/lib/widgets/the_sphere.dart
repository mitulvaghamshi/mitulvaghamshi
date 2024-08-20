import 'package:flutter/material.dart';

/// A Widget which draws the black sphere of an 8-Ball
@immutable
class const TheSphere({
  // The diameter of the sphere
  required final double diameter,
  // The position of the light source relative to the sphere
  required final Offset lightSource,
  // A widget to draw on the surface of the sphere (WindowOfOpportunity)
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: diameter,
    height: diameter,
    alignment: .center,
    decoration: BoxDecoration(
      shape: .circle,
      gradient: RadialGradient(
        center: Alignment(lightSource.dx, lightSource.dy),
        colors: const [Colors.grey, Colors.black],
      ),
    ),
    child: child,
  );
}
