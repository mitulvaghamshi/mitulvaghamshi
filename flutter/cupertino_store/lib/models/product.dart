import 'package:cupertino_store/utils/category.dart';
import 'package:flutter/foundation.dart' hide Category;

@immutable
class Product {
  const Product({
    required this.id,
    required this.price,
    required this.name,
    required this.isFeatured,
    required this.category,
  });

  final int id;
  final int price;
  final String name;
  final bool isFeatured;
  final Category category;
}

extension ExProduct on Product {
  String get package => 'shrine_images';
  String get thumb => '$id-0.jpg';
  String get asset => '3.0x/$thumb';
}
