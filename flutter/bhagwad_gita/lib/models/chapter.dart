import 'package:flutter/material.dart';

@immutable
class const Chapter({
  required final int id,
  required final String title,
  required final Iterable<String> items,
}) {
  factory fromJson(Object? json) {
    if (json case {
      'id': final int id,
      'title': final String title,
      'items': final Iterable<dynamic> items,
    }) {
      return .new(id: id, title: title, items: items.cast());
    }
    return const .new(id: 0, title: 'Something went wrong!', items: []);
  }
}
