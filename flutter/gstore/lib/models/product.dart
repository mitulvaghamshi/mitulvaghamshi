import 'package:flutter/material.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.img,
    required this.title,
    required this.info,
  });

  final int id;
  final String img;
  final String title;
  final TextSpan info;
}
