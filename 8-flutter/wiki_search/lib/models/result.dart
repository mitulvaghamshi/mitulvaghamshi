import 'package:flutter/cupertino.dart';

@immutable
class const Result({
  required final String title,
  required final int size,
  required final int wordcount,
  required final DateTime timestamp,
  required final String snippet,
}) {
  factory fromJson(Object? json) {
    if (json case {
      'title': final String title,
      'size': final int size,
      'wordcount': final int wordcount,
      'timestamp': final String timestamp,
      'snippet': final String snippet,
    }) {
      return .new(
        title: title,
        size: size,
        wordcount: wordcount,
        timestamp: .parse(timestamp),
        snippet: snippet,
      );
    }
    throw Exception('[$Result]: ${StackTrace.current}');
  }

  factory error({required String code, required String info}) => .new(
    title: code,
    size: 0,
    wordcount: info.length,
    timestamp: .now(),
    snippet: info,
  );
}

extension Utils on Result {
  String get label => '$title${size > 0 ? ' ($sizeToMemory)' : ''}';
  String get sizeToMemory => size / 1024 < 1024
      ? '${(size / 1024).toStringAsFixed(2)} KB'
      : '${(size / 1024 / 1024).toStringAsFixed(2)} MB';
}
