import 'package:apis/mars/mars_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Mars {
  const Mars({required this.id, required this.imageUrl});

  final String id;
  final String imageUrl;

  static String path = 'assets/marsphotos.json';

  static Mars Function(Map<String, dynamic> json) factory = Mars.fromJson;

  static Widget Function(Iterable<Mars> items) builder = MarsScreen.builder;

  factory Mars.fromJson(final Map<String, dynamic> json) {
    if (json case {'id': final String id, 'img_src': final String src}) {
      return Mars(id: id, imageUrl: src);
    }
    throw '[MarsPhoto]: Invalid Json data.';
  }
}
