import 'dart:convert';

import 'package:bhagwad_gita/models/chapter.dart';
import 'package:bhagwad_gita/models/snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

@immutable
interface class Repo<T> {
  const Repo({required this.items});

  const Repo.empty() : items = const [];

  final Iterable<T> items;

  static Future<Repo<T>> asset<T>(
    String path,
    T Function(Object? json) fromJson,
  ) async {
    final content = await rootBundle.loadString(path);
    if (jsonDecode(content) case Iterable<dynamic> items) {
      return Repo<T>(items: items.map(fromJson));
    }
    throw FormatException('[$Repo]: Invalid JSON');
  }

  static Future<Repo<Chapter>> get query async {
    return .asset('assets/gita.json', Chapter.fromJson);
  }

  static Future<Repo<Snippet>> get gitaSnippetsEn async {
    return .asset('assets/gita_snippets_en.json', Snippet.fromJson);
  }

  static Future<Repo<Snippet>> get gitaSnippetsHi async {
    return .asset('assets/gita_snippets_hi.json', Snippet.fromJson);
  }
}
