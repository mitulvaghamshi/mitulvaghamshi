import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';

@immutable
class Server {
  static Product getProductBy(final String id) => dummyData[id]!;

  static Iterable<String> getProductList([String? filter]) {
    if (filter == null) return dummyData.keys;
    final ids = <String>[];
    for (var product in dummyData.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        ids.add(product.id);
      }
    }
    return ids;
  }
}

const dummyData = {
  '0': Product(
    id: '0',
    title: 'Explore Pixel phones',
    pictureURL: 'assets/pixels.png',
    description: TextSpan(children: [
      TextSpan(
        text: 'Capture the details.\n',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: 'Capture your world.',
        style: TextStyle(color: Colors.blue),
      ),
    ]),
  ),
  '1': Product(
    id: '1',
    title: 'Nest Audio',
    pictureURL: 'assets/nest.png',
    description: TextSpan(children: [
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
    pictureURL: 'assets/nest-audio-packages.png',
    description: TextSpan(children: [
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
    pictureURL: 'assets/nest-home-packages.png',
    description: TextSpan(children: [
      TextSpan(
        text: 'Your home,\n',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: 'safe and sound.',
        style: TextStyle(color: Colors.red),
      ),
    ]),
  ),
};
