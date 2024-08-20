import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:magic_ball8/widgets/bottom_shadow.dart';
import 'package:magic_ball8/widgets/inner_circle.dart';
import 'package:magic_ball8/widgets/inner_triangle.dart';
import 'package:magic_ball8/widgets/the_sphere.dart';

@immutable
class MagicBall8App extends StatefulWidget {
  const MagicBall8App({super.key});

  @override
  State<MagicBall8App> createState() => _MagicBall8AppState();
}

class _MagicBall8AppState extends State<MagicBall8App>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 1500),
  )..addListener(() => setState(() {}));

  late final animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
    reverseCurve: Curves.elasticIn,
  );

  final rand = math.Random();
  static const restPosition = Offset(0, -0.15);
  static const lightSource = Offset(0, -0.75);

  String prediction = 'The\nMAGIC\nBall';
  Offset tapPosition = .zero;
  double wobble = 0;

  Future<void> _start(Offset position, Size size) async {
    await controller.forward();
    _update(position, size);
  }

  Future<void> _end() async {
    wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    prediction = _predictions[rand.nextInt(_predictions.length)];
    await controller.reverse();
  }

  void _update(Offset position, Size size) {
    Offset tapPosition = .new(
      (2 * position.dx / size.width) - 1,
      (2 * position.dy / size.height) - 1,
    );
    if (tapPosition.distance > 0.8) {
      tapPosition = .fromDirection(tapPosition.direction, 0.8);
    }
    setState(() => this.tapPosition = tapPosition);
  }

  @override
  void dispose() {
    controller.dispose();
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = Offset.lerp(restPosition, tapPosition, animation.value)!;
    final size = Size.square(MediaQuery.sizeOf(context).shortestSide);
    return Scaffold(
      body: Container(
        alignment: .center,
        padding: const .all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: .bottomCenter,
            children: [
              BottomShadow(diameter: size.shortestSide),
              GestureDetector(
                onPanStart: (details) => _start(details.localPosition, size),
                onPanUpdate: (details) => _update(details.localPosition, size),
                onPanEnd: (_) => _end(),
                child: TheSphere(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: Transform(
                    origin: size.center(position),
                    transform: .identity()
                      ..translateByDouble(
                        position.dx * size.width / 2,
                        position.dy * size.height / 2,
                        0,
                        1,
                      )
                      ..rotateZ(position.direction)
                      ..rotateY(position.distance * math.pi / 2.5)
                      ..rotateZ(-position.direction)
                      ..scaleByDouble(
                        0.5 - 0.15 * position.distance,
                        0.5 - 0.15 * position.distance,
                        1,
                        1,
                      ),
                    child: InnerCircle(
                      lightSource: lightSource - position,
                      child: Opacity(
                        opacity: 1 - controller.value,
                        child: Transform.rotate(
                          angle: wobble,
                          child: InnerTriangle(text: prediction),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ball predictions (obfuscated)
final _predictions = String.fromCharCodes(base64.decode(_data)).split('|');

const _data =
    'R29vZ2xlfEFwcGxlfE1pY3Jvc29mdHxBbWF6b258U3'
    'BhY2VYfFRlc2xhfE5hc2F8TmV0ZmxpeHxNZXRhCg==';
