import 'dart:convert';
import 'dart:math' as math;

import 'package:ball8/widgets/bottom_shadow.dart';
import 'package:ball8/widgets/inner_circle.dart';
import 'package:ball8/widgets/inner_triangle.dart';
import 'package:ball8/widgets/the_sphere.dart';
import 'package:flutter/material.dart';

@immutable
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    lowerBound: 0,
    upperBound: 1,
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
  Offset tapPosition = Offset.zero;
  double wobble = 0;

  void _start(position, size) {
    controller.forward();
    _update(position, size);
  }

  void _end() {
    wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    prediction = _predictions[rand.nextInt(_predictions.length)];
    controller.reverse();
  }

  void _update(position, size) {
    var tapPosition = Offset(
      (2 * position.dx / size.width) - 1,
      (2 * position.dy / size.height) - 1,
    );
    if (tapPosition.distance > 0.8) {
      tapPosition = Offset.fromDirection(tapPosition.direction, 0.8);
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
    final size = Size.square(View.of(context).physicalSize.shortestSide);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.bottomCenter,
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
                    origin: size.center(Offset.zero),
                    transform: Matrix4.identity()
                      ..translate(position.dx * size.width / 2,
                          position.dy * size.height / 2)
                      ..rotateZ(position.direction)
                      ..rotateY(position.distance * math.pi / 2)
                      ..rotateZ(-position.direction)
                      ..scale(0.5 - 0.15 * position.distance),
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
final _predictions = String.fromCharCodes(base64Decode(_values)).split('|');
const _values = 'R29vZ2xlfEFwcGxlfE1pY3Jvc29mdHxBbWF6b258U3'
    'BhY2VYfFRlc2xhfE5hc2F8TmV0ZmxpeHxNZXRhCg==';
