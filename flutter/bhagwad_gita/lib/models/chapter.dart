import 'package:flutter/material.dart';

@immutable
class Chapter {
  const Chapter({required this.id, required this.title, required this.items});

  factory Chapter.fromJson(Object? json) {
    if (json case {
      'id': final int id,
      'title': final String title,
      'items': final Iterable<dynamic> items,
    }) {
      return .new(id: id, title: title, items: items.cast());
    }
    return const .new(id: 0, title: 'Something went wrong!', items: []);
  }

  final int id;
  final String title;
  final Iterable<String> items;
}
