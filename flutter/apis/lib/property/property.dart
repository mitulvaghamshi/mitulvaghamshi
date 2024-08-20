import 'dart:math' as math show Random;

import 'package:apis/property/property_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Property {
  const Property({
    required this.id,
    required this.type,
    required this.price,
    required this.imgSrc,
    required this.payment,
  });

  final String id;
  final String type;
  final int price;
  final String imgSrc;
  final String payment;

  static String path = 'assets/realestate.json';

  static Property Function(Map<String, dynamic> json) factory =
      Property.fromJson;

  static Widget Function(Iterable<Property> items) builder =
      PropertyScreen.builder;

  factory Property.fromJson(final Map<String, dynamic> json) {
    if (json
        case {
          'price': final int price,
          'id': final String id,
          'type': final String type,
          'img_src': final String src,
        }) {
      final deposit = math.Random().nextInt(30);
      return Property(
        id: id,
        type: type,
        price: price,
        imgSrc: src,
        payment: '$deposit% deposit and, ${100 - deposit}% over 10 years.',
      );
    }
    throw '[Property]: Invalid Json data.';
  }
}
