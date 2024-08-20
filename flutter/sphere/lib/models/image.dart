import 'dart:ui' as ui;

import 'package:flutter/material.dart';

@immutable
class SphereImage {
  const SphereImage({this.image, this.radius, this.origin, this.offset});

  final ui.Image? image;
  final double? radius;
  final Offset? origin;
  final Offset? offset;
}
