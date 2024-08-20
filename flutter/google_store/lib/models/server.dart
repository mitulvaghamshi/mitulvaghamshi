import 'package:flutter/material.dart';
import 'package:google_store/models/product.dart';

@immutable
mixin Server {
  static Product getProductBy({required String key}) =>
      ArgumentError.checkNotNull(_products[key], 'ProductKey:$key');

  static Iterable<String> getProducts([String filter = '']) {
    if (filter.isEmpty) {
      return _products.keys;
    }
    final items = _products.entries.where(
      (p) => p.value.title.toLowerCase().contains(filter.toLowerCase()),
    );
    return items.map((p) => p.key);
  }

  static const _products = {
    '1': Product(
      id: 1,
      title: 'Explore Pixel phones',
      image: 'assets/pixels.webp',
      line1: ('Capture the details.\n', Colors.blue),
      line2: ('Capture your world.', Colors.black),
    ),
    '2': Product(
      id: 2,
      title: 'Nest Audio',
      image: 'assets/nest.webp',
      line1: ('Amazing sound.\n', Colors.green),
      line2: ('At your command.', Colors.black),
    ),
    '3': Product(
      id: 3,
      title: 'Nest Audio Entertainment packages',
      image: 'assets/nest-audio-packages.webp',
      line1: ('Built for music.\n', Colors.orange),
      line2: ('Made for you.', Colors.black),
    ),
    '4': Product(
      id: 4,
      title: 'Nest Home Security packages',
      image: 'assets/nest-home-packages.webp',
      line1: ('Your home,\n', Colors.red),
      line2: ('safe and sound.', Colors.black),
    ),
  };
}
