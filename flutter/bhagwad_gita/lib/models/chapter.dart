import 'package:flutter/material.dart';

@immutable
class Chapter {
  const Chapter({required this.id, required this.title, required this.items});

  factory Chapter.fromJson(Object? json) {
    if (json case {
      'id': int id,
      'title': String title,
      'items': Iterable<dynamic> items,
    }) {
      return .new(id: id, title: title, items: items.cast());
    }

    throw FormatException('[$Chapter]: Invalid JSON, $json');
  }

  final int id;
  final String title;
  final Iterable<String> items;
}
