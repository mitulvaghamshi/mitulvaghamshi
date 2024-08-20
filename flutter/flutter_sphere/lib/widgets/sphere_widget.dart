import 'dart:async' show Completer, Future;
import 'dart:math' as math;
import 'dart:typed_data' show Uint32List;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_sphere/utils/sphere_image.dart';
import 'package:flutter_sphere/utils/surface.dart';
import 'package:flutter_sphere/widgets/sphere_painter.dart';

@immutable
class SphereWidget extends StatefulWidget {
  const SphereWidget({
    required this.surface,
    required this.radius,
    super.key,
    this.latitude = 0,
    this.longitude = 0,
    this.alignment = .center,
  });

  final Surface surface;
  final double radius;
  final double latitude;
  final double longitude;
  final Alignment alignment;

  @override
  State<SphereWidget> createState() => _SphereWidgetState();
}

class _SphereWidgetState extends State<SphereWidget>
    with SingleTickerProviderStateMixin {
  double zoom = 0;

  late double surfaceWidth;
  late double surfaceHeight;
  late Uint32List? surfaceData;

  late double _lastZoom;
  late double _lastRotationX;
  late double _lastRotationZ;
  late Offset _lastFocalPoint;

  late double rotationX = widget.latitude * math.pi / 180;
  late double rotationZ = widget.longitude * math.pi / 180;

  late AnimationController rotationZCtrl;
  late Animation<double> rotationZAnimation;

  void _rotationListener() =>
      setState(() => rotationZ = rotationZAnimation.value);

  @override
  void initState() {
    super.initState();
    rotationZCtrl = AnimationController(vsync: this)
      ..addListener(_rotationListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ignore: discarded_futures update leter.
    _loadSurface().then((value) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        surfaceWidth = value.$1;
        surfaceHeight = value.$2;
        surfaceData = value.$3;
      });
    });
  }

  @override
  void dispose() {
    rotationZCtrl.removeListener(_rotationListener);
    rotationZCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onScaleStart: _onScaleStart,
    onScaleEnd: _onScaleEnd,
    onScaleUpdate: (details) => setState(() => _onScaleUpdate(details)),
    child: LayoutBuilder(
      builder: (_, constraints) => FutureBuilder(
        future: _buildSphere(constraints.maxWidth, constraints.maxHeight),
        builder: (_, snapshot) => CustomPaint(
          painter: SpherePainter(snapshot.data),
          size: Size(constraints.maxWidth, constraints.maxHeight),
        ),
      ),
    ),
  );
}

extension on _SphereWidgetState {
  double get _radius => widget.radius * math.pow(2, zoom);

  void _onScaleStart(ScaleStartDetails details) {
    _lastZoom = zoom;
    _lastRotationX = rotationX;
    _lastRotationZ = rotationZ;
    _lastFocalPoint = details.focalPoint;
    rotationZCtrl.stop();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    zoom = _lastZoom + math.log(details.scale) / math.ln2;
    final offset = details.focalPoint - _lastFocalPoint;
    rotationX = _lastRotationX + offset.dy / _radius;
    rotationZ = _lastRotationZ - offset.dx / _radius;
  }

  Future<void> _onScaleEnd(ScaleEndDetails details) async {
    const a = -300;
    final v = details.velocity.pixelsPerSecond.dx * 0.3;
    final t = (v / a).abs() * 1000;
    final s = (v.sign * 0.5 * v * v / a) / _radius;
    rotationZCtrl.duration = Duration(milliseconds: t.toInt());
    rotationZAnimation = Tween(
      begin: rotationZ,
      end: rotationZ + s,
    ).animate(CurveTween(curve: Curves.decelerate).animate(rotationZCtrl));
    rotationZCtrl.value = 0;
    await rotationZCtrl.forward();
  }

  Future<(double, double, Uint32List)> _loadSurface() async {
    final data = await DefaultAssetBundle.of(context).load(widget.surface.path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;
    final pixels = await image.toByteData();
    return (
      image.width.toDouble(),
      image.height.toDouble(),
      pixels!.buffer.asUint32List(),
    );
  }

  Future<SphereImage?> _buildSphere(double maxWidth, double maxHeight) async {
    if (surfaceData == null) {
      return null;
    }
    final r = _radius.roundToDouble();
    final minX = math.max(-r, (-1 - widget.alignment.x) * maxWidth / 2);
    final minY = math.max(-r, (-1 + widget.alignment.y) * maxHeight / 2);
    final maxX = math.min(r, (1 - widget.alignment.x) * maxWidth / 2);
    final maxY = math.min(r, (1 + widget.alignment.y) * maxHeight / 2);
    final width = maxX - minX;
    final height = maxY - minY;
    if (width <= 0 || height <= 0) {
      return null;
    }
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
          var x1 = x;
          var y1 = y;
          var z1 = z;
          double x2;
          double y2;
          double z2;
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

    void decoder(ui.Image image) {
      final sphereImage = SphereImage(
        image: image,
        radius: r,
        origin: Offset(-minX, -minY),
        offset: Offset(
          (widget.alignment.x + 1) * maxWidth / 2,
          (widget.alignment.y + 1) * maxHeight / 2,
        ),
      );
      completer.complete(sphereImage);
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
