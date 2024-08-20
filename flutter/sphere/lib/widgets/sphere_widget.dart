import 'dart:async' show Completer, Future;
import 'dart:math' as math;
import 'dart:typed_data' show Uint32List;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sphere/models/image.dart';
import 'package:sphere/models/surface.dart';
import 'package:sphere/widgets/sphere_painter.dart';

@immutable
class SphereWidget extends StatefulWidget {
  const SphereWidget({
    super.key,
    this.radius,
    this.surface,
    this.latitude = 0,
    this.longitude = 0,
    this.alignment = Alignment.center,
  });

  final double? radius;
  final Surface? surface;
  final double latitude;
  final double longitude;
  final Alignment alignment;

  @override
  SphereWidgetState createState() => SphereWidgetState();
}

class SphereWidgetState extends State<SphereWidget>
    with SingleTickerProviderStateMixin {
  Uint32List? surfaceData;
  double zoom = 0;
  late double _lastZoom;
  late double surfaceWidth;
  late double surfaceHeight;
  late double _lastRotationX;
  late double _lastRotationZ;
  late Offset _lastFocalPoint;
  late double rotationX = widget.latitude * math.pi / 180;
  late double rotationZ = widget.longitude * math.pi / 180;
  late Animation<double> rotationZAnimation;
  late AnimationController? rotationZController =
      AnimationController(vsync: this)..addListener(_rotationListener);

  void _rotationListener() =>
      setState(() => rotationZ = rotationZAnimation.value);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSurface().then((value) {
      if (context.mounted) {
        setState(() {
          surfaceWidth = value.$1;
          surfaceHeight = value.$2;
          surfaceData = value.$3;
        });
      }
    });
  }

  @override
  void dispose() {
    rotationZController?.removeListener(_rotationListener);
    rotationZController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleEnd: _onScaleEnd,
      onScaleUpdate: (details) => setState(() => _onScaleUpdate(details)),
      child: LayoutBuilder(builder: (_, constraints) {
        return FutureBuilder(
          future: _buildSphere(constraints.maxWidth, constraints.maxHeight),
          builder: (_, snapshot) => CustomPaint(
            painter: SpherePainter(snapshot.data),
            size: Size(constraints.maxWidth, constraints.maxHeight),
          ),
        );
      }),
    );
  }
}

extension on SphereWidgetState {
  double get _radius => widget.radius! * math.pow(2, zoom);

  void _onScaleStart(details) {
    _lastZoom = zoom;
    _lastRotationX = rotationX;
    _lastRotationZ = rotationZ;
    _lastFocalPoint = details.focalPoint;
    rotationZController!.stop();
  }

  void _onScaleUpdate(details) {
    zoom = _lastZoom + math.log(details.scale) / math.ln2;
    final offset = details.focalPoint - _lastFocalPoint;
    rotationX = _lastRotationX + offset.dy / _radius;
    rotationZ = _lastRotationZ - offset.dx / _radius;
  }

  void _onScaleEnd(details) {
    const a = -300;
    final v = details.velocity.pixelsPerSecond.dx * 0.3;
    final t = (v / a).abs() * 1000;
    final s = (v.sign * 0.5 * v * v / a) / _radius;
    rotationZController!.duration = Duration(milliseconds: t.toInt());
    rotationZAnimation = Tween(begin: rotationZ, end: rotationZ + s).animate(
        CurveTween(curve: Curves.decelerate).animate(rotationZController!));
    rotationZController!
      ..value = 0
      ..forward();
  }

  Future<(double, double, Uint32List)> _loadSurface() async {
    final data = await rootBundle.load(widget.surface!.path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;
    final pixels = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return (
      image.width.toDouble(),
      image.height.toDouble(),
      pixels!.buffer.asUint32List(),
    );
  }

  Future<SphereImage>? _buildSphere(double maxWidth, double maxHeight) {
    if (surfaceData == null) return null;
    final r = _radius.roundToDouble();
    final minX = math.max(-r, (-1 - widget.alignment.x) * maxWidth / 2);
    final minY = math.max(-r, (-1 + widget.alignment.y) * maxHeight / 2);
    final maxX = math.min(r, (1 - widget.alignment.x) * maxWidth / 2);
    final maxY = math.min(r, (1 + widget.alignment.y) * maxHeight / 2);
    final width = maxX - minX;
    final height = maxY - minY;
    if (width <= 0 || height <= 0) return null;
    final sphere = Uint32List(width.toInt() * height.toInt());

    var angle = math.pi / 2 - rotationX;
    final sinx = math.sin(angle);
    final cosx = math.cos(angle);
    // angle = 0;
    // final siny = math.sin(angle);
    // final cosy = math.cos(angle);
    angle = rotationZ + math.pi / 2;
    final sinz = math.sin(angle);
    final cosz = math.cos(angle);

    final surfaceXRate = (surfaceWidth - 1) / (2.0 * math.pi);
    final surfaceYRate = (surfaceHeight - 1) / (math.pi);

    for (var y = minY; y < maxY; y++) {
      final sphereY = (height - y + minY - 1).toInt() * width;
      for (var x = minX; x < maxX; x++) {
        var z = r * r - x * x - y * y;
        if (z > 0) {
          z = math.sqrt(z);
          var x1 = x, y1 = y, z1 = z;
          double x2, y2, z2;
          //rotate around the X axis
          y2 = y1 * cosx - z1 * sinx;
          z2 = y1 * sinx + z1 * cosx;
          y1 = y2;
          z1 = z2;
          //rotate around the Y axis
          // x2 = x1 * cosy + z1 * siny;
          // z2 = -x1 * siny + z1 * cosy;
          // x1 = x2;
          // z1 = z2;
          //rotate around the Z axis
          x2 = x1 * cosz - y1 * sinz;
          y2 = x1 * sinz + y1 * cosz;
          x1 = x2;
          y1 = y2;
          final lat = math.asin(z1 / r);
          final lng = math.atan2(y1, x1);
          final x0 = (lng + math.pi) * surfaceXRate;
          final y0 = (math.pi / 2 - lat) * surfaceYRate;
          final color = surfaceData![(y0.toInt() * surfaceWidth + x0).toInt()];
          sphere[(sphereY + x - minX).toInt()] = color;
        }
      }
    }

    final completer = Completer<SphereImage>();

    void decoder(image) {
      completer.complete(SphereImage(
        image: image,
        radius: r,
        origin: Offset(-minX, -minY),
        offset: Offset(
          (widget.alignment.x + 1) * maxWidth / 2,
          (widget.alignment.y + 1) * maxHeight / 2,
        ),
      ));
    }

    ui.decodeImageFromPixels(
      sphere.buffer.asUint8List(),
      width.toInt(),
      height.toInt(),
      ui.PixelFormat.rgba8888,
      decoder,
    );

    return completer.future;
  }
}
