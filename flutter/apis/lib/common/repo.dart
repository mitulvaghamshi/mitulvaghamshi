import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
interface class Repo<T> {
  const Repo({required this.items});

  final Iterable<T> items;

  static Future<Repo<T>> get<T>(
    final String path,
    final T Function(Map<String, dynamic> json) factory,
  ) async {
    if (!kDebugMode) throw UnimplementedError();
    assert(path != '', '[Repo]: Invalid Json path.');
    final data = await rootBundle.loadString(path);
    final list = List<Map<String, dynamic>>.from(jsonDecode(data));
    return Repo<T>(items: list.map(factory));
  }
}
