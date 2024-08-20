import 'package:cupertino_store/server/server.dart';
import 'package:flutter/foundation.dart' hide Category;

@immutable
class const Product({
  required final int id,
  required final int price,
  required final String name,
  required final bool isFeatured,
  required final Category category,
});

extension ExProduct on Product {
  String get package => 'shrine_images';
  String get thumb => '$id-0.jpg';
  String get asset => '3.0x/$thumb';
}
