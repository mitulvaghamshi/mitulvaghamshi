import 'package:flutter/material.dart';
import 'package:flutter_sphere/utils/sphere_image.dart';

@immutable
class SpherePainter extends CustomPainter {
  const SpherePainter(this.image);

  final SphereImage? image;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) return;
    final paint = Paint();
    final rect = Rect.fromCircle(
      center: image!.offset!,
      radius: image!.radius! - 1,
    );
    final path = Path.combine(
      PathOperation.intersect,
      Path()..addOval(rect),
      Path()..addRect(Offset.zero & size),
    );
    canvas.clipPath(path);
    canvas.drawImage(image!.image!, image!.offset! - image!.origin!, paint);
    final gradient = RadialGradient(
      stops: const [0.1, 0.85, 1.0],
      colors: [
        Colors.transparent,
        Colors.black.withValues(alpha: 0.35),
        Colors.black.withValues(alpha: 0.5),
      ],
    );
    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }
}
