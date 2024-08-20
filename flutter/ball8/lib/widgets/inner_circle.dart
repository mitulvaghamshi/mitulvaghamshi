import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A Widget which draws a shallow circlular indentation on the surface of
/// SphereOfDestiny, containing a Prediction
@immutable
class InnerCircle extends StatelessWidget {
  const InnerCircle({
    super.key,
    required this.lightSource,
    required this.child,
  });

  /// The position of the light source relative to the window
  final Offset lightSource;

  /// The Prediction itself
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    final portalShadowOffset = Offset.fromDirection(
      math.pi + lightSource.direction,
      innerShadowWidth,
    );
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        gradient: RadialGradient(
          center: Alignment(portalShadowOffset.dx, portalShadowOffset.dy),
          colors: const [Color(0x661F1F1F), Colors.black],
          stops: [1 - innerShadowWidth, 1],
        ),
      ),
      child: child,
    );
  }
}
