import 'package:flutter/material.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.image,
    required this.title,
    required this.line1,
    required this.line2,
  });

  final int id;
  final String image;
  final String title;
  final (String, Color) line1;
  final (String, Color) line2;
}
