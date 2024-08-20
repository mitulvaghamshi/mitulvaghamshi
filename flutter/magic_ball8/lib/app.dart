import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:magic_ball8/widgets/bottom_shadow.dart';
import 'package:magic_ball8/widgets/inner_circle.dart';
import 'package:magic_ball8/widgets/inner_triangle.dart';
import 'package:magic_ball8/widgets/the_sphere.dart';

@immutable
class const MagicBall8App({super.key}) extends StatefulWidget {
  @override
  State<MagicBall8App> createState() => _MagicBall8AppState();
}

class _MagicBall8AppState extends State<MagicBall8App>
    with SingleTickerProviderStateMixin {
  late final _animCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 1500),
  )..addListener(() => setState(() {}));

  late final _animation = CurvedAnimation(
    parent: _animCtrl,
    curve: Curves.easeInOut,
    reverseCurve: Curves.elasticIn,
  );

  final _rnd = math.Random();
  static const _restPosition = Offset(0, -0.15);
  static const _lightSource = Offset(0, -0.75);

  String _prediction = 'The\nMAGIC\nBall';
  Offset _tapPosition = .zero;
  double _wobble = 0;

  Future<void> _start(Offset position, Size size) async {
    await _animCtrl.forward();
    _update(position, size);
  }

  Future<void> _end() async {
    _wobble = _rnd.nextDouble() * (_wobble.isNegative ? 0.5 : -0.5);
    _prediction = _predictions[_rnd.nextInt(_predictions.length)];
    await _animCtrl.reverse();
  }

  void _update(Offset position, Size size) {
    Offset tapPosition = .new(
      (2 * position.dx / size.width) - 1,
      (2 * position.dy / size.height) - 1,
    );
    if (tapPosition.distance > 0.8) {
      tapPosition = .fromDirection(tapPosition.direction, 0.8);
    }
    setState(() => _tapPosition = tapPosition);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = Offset.lerp(
      _restPosition,
      _tapPosition,
      _animation.value,
    )!;
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
                  lightSource: _lightSource,
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
                      lightSource: _lightSource - position,
                      child: Opacity(
                        opacity: 1 - _animCtrl.value,
                        child: Transform.rotate(
                          angle: _wobble,
                          child: InnerTriangle(text: _prediction),
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
