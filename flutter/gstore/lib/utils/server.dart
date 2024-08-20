import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';

@immutable
mixin Server {
  static Product getProductBy(String id) => _products[id]!;

  static Iterable<String> getProductList([String filter = '']) {
    if (filter.isEmpty) return _products.keys;

    final items = <String>[];
    for (final product in _products.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        items.add(product.id);
      }
    }
    return items;
  }

  static const _products = <String, Product>{
    '0': Product(
      id: '0',
      title: 'Explore Pixel phones',
      img: 'assets/pixels.webp',
      info: TextSpan(children: [
        TextSpan(
          text: 'Capture the details.\n',
          style: TextStyle(color: Colors.blue),
        ),
        TextSpan(
          text: 'Capture your world.',
          style: TextStyle(color: Colors.black),
        ),
      ]),
    ),
    '1': Product(
      id: '1',
      title: 'Nest Audio',
      img: 'assets/nest.webp',
      info: TextSpan(children: [
        TextSpan(
          text: 'Amazing sound.\n',
          style: TextStyle(color: Colors.green),
        ),
        TextSpan(
          text: 'At your command.',
          style: TextStyle(color: Colors.black),
        ),
      ]),
    ),
    '2': Product(
      id: '2',
      title: 'Nest Audio Entertainment packages',
      img: 'assets/nest-audio-packages.webp',
      info: TextSpan(children: [
        TextSpan(
          text: 'Built for music.\n',
          style: TextStyle(color: Colors.orange),
        ),
        TextSpan(
          text: 'Made for you.',
          style: TextStyle(color: Colors.black),
        ),
      ]),
    ),
    '3': Product(
      id: '3',
      title: 'Nest Home Security packages',
      img: 'assets/nest-home-packages.webp',
      info: TextSpan(children: [
        TextSpan(
          text: 'Your home,\n',
          style: TextStyle(color: Colors.red),
        ),
        TextSpan(
          text: 'safe and sound.',
          style: TextStyle(color: Colors.black),
        ),
      ]),
    ),
  };
}
