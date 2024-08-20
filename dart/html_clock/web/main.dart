import 'dart:async';
import 'dart:js_interop';
import 'dart:math' as math;

import 'package:web/web.dart' as web;

void main() {
  final root = ArgumentError.checkNotNull(
    web.document.querySelector('#output') as web.HTMLDivElement?,
    'HtmlRootElement_#output',
  );

  drawClock(root);
}

/* source: https://www.w3schools.com/graphics/canvas_clock.asp */

typedef Ctx2D = web.CanvasRenderingContext2D;

void drawClock(web.HTMLElement root) {
  final size = math.min(web.window.innerWidth, web.window.innerHeight) - 40;
  final radius = size / 2 * 0.9;

  final canvas = web.HTMLCanvasElement()
    ..width = size
    ..height = size
    ..style.backgroundColor = '#333';

  final ctx = ArgumentError.checkNotNull(
    canvas.getContext('2d') as Ctx2D?,
    'Canvas_Context2D',
  );

  ctx.translate(size / 2, size / 2);
  root.appendChild(canvas);

  Timer.periodic(const .new(seconds: 1), (_) => _drawClock(ctx, radius));
}

void _drawClock(Ctx2D ctx, double radius) {
  ctx.arc(0, 0, radius, 0, math.pi * 2);
  ctx.fillStyle = 'white'.toJS;
  ctx.fill();

  _drawFace(ctx, radius);
  _drawDigits(ctx, radius);
  _drawTime(ctx, radius);
}

void _drawFace(Ctx2D ctx, double radius) {
  final grad = ctx.createRadialGradient(
    0,
    0,
    radius * 0.95,
    0,
    0,
    radius * 1.05,
  );
  grad.addColorStop(0, '#333');
  grad.addColorStop(0.5, 'white');
  grad.addColorStop(1, '#333');

  ctx.beginPath();
  ctx.arc(0, 0, radius, 0, math.pi * 2);
  ctx.fillStyle = 'white'.toJS;
  ctx.fill();

  ctx.strokeStyle = grad;
  ctx.lineWidth = radius * 0.1;
  ctx.stroke();

  ctx.beginPath();
  ctx.arc(0, 0, radius * 0.1, 0, math.pi * 2);
  ctx.fillStyle = '#333'.toJS;
  ctx.fill();
}

void _drawDigits(Ctx2D ctx, double radius) {
  ctx.font = '${radius * 0.15}px georgia';
  ctx.textBaseline = 'middle';
  ctx.textAlign = 'center';

  for (var digit = 1; digit <= 12; digit++) {
    final angle = digit * math.pi / 6;
    ctx.rotate(angle);
    ctx.translate(0, -radius * 0.85);
    ctx.rotate(-angle);
    ctx.fillText(digit.toString(), 0, 0);
    ctx.rotate(angle);
    ctx.translate(0, radius * 0.85);
    ctx.rotate(-angle);
  }
}

void _drawTime(Ctx2D ctx, double radius) {
  final now = DateTime.now();

  var hour = now.hour.toDouble();
  var minute = now.minute.toDouble();
  var second = now.second.toDouble();

  // Hour
  hour = hour % 12;
  hour =
      (hour * math.pi / 6) +
      (minute * math.pi / (6 * 60)) +
      (second * math.pi / (360 * 60));
  _drawHand(ctx, hour, radius * 0.5, radius * 0.07);

  // Minute
  minute = (minute * math.pi / 30) + (second * math.pi / (30 * 60));
  _drawHand(ctx, minute, radius * 0.8, radius * 0.07);

  // Second
  second = second * math.pi / 30;
  _drawHand(ctx, second, radius * 0.9, radius * 0.02);
}

void _drawHand(Ctx2D ctx, double position, double length, double width) {
  ctx.lineWidth = width;
  ctx.lineCap = 'round';
  ctx.beginPath();
  ctx.moveTo(0, 0);
  ctx.rotate(position);
  ctx.lineTo(0, -length);
  ctx.stroke();
  ctx.rotate(-position);
}
