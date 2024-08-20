import 'dart:convert';

import 'package:bhagwad_gita/models/chapter.dart';
import 'package:bhagwad_gita/models/snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

@immutable
interface class const Repo<T>({required final Iterable<T> items}) {
  factory empty() => const .new(items: []);

  static Future<Repo<T>> asset<T>(
    String path,
    T Function(Object? json) fromJson,
  ) async {
    final result = await jsonDecode(await rootBundle.loadString(path));
    if (result case final Iterable<dynamic> items) {
      return Repo<T>(items: items.map(fromJson));
    }
    debugPrint('[${Repo<T>}]: ${StackTrace.current}');
    return Repo(items: const .empty());
  }

  static Future<Repo<Chapter>> get query async {
    return .asset('assets/gita.json', Chapter.fromJson);
  }

  static Future<Repo<Snippet>> get gitaEnglish async {
    return .asset('assets/gita_snippets_en.json', Snippet.fromJson);
  }

  static Future<Repo<Snippet>> get gitaHindi async {
    return .asset('assets/gita_snippets_hi.json', Snippet.fromJson);
  }
}
