import 'package:flutter/material.dart';

/// A Widget which draws the black sphere of an 8-Ball
@immutable
class TheSphere extends StatelessWidget {
  const TheSphere({
    super.key,
    required this.diameter,
    required this.lightSource,
    required this.child,
  });

  /// A widget to draw on the surface of the sphere (WindowOfOpportunity)
  final Widget child;

  /// The diameter of the sphere
  final double diameter;

  /// The position of the light source relative to the sphere
  final Offset lightSource;

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
