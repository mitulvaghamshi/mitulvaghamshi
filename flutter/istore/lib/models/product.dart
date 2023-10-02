import 'package:istore/utils/category.dart';
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

  @override
  String toString() =>
      '$name {id:$id, price:$price, category:$category, isFeatured:$isFeatured}';
}

extension ExProduct on Product {
  String get itemAsset => '$id-0.jpg';
  String get galleryAsset => '3.0x/$id-0.jpg';
  String get package => 'shrine_images';
}
