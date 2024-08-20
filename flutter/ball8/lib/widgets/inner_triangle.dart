import 'package:flutter/material.dart';

/// A class that draws an 8-Ball predictive blue triangle containing text
@immutable
class InnerTriangle extends StatelessWidget {
  const InnerTriangle({super.key, required this.text});

  /// The text of the current prediction
  final String text;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _TrianglePainter(),
    child: Container(
      alignment: .center,
      child: Text(
        text,
        textAlign: .center,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: .bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

@immutable
class _TrianglePainter extends CustomPainter {
  final _gradient = const LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..strokeWidth = 5
      ..style = .stroke
      ..shader = _gradient.createShader(Offset.zero & size);
    final path = Path()
      ..moveTo(w * 0.2, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.1, w * 0.8, h * 0.3)
      ..quadraticBezierTo(w * 0.85, h * 0.6, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.15, h * 0.6, w * 0.2, h * 0.3)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
