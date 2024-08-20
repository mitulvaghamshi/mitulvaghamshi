import 'package:flutter/cupertino.dart';

@immutable
class Result {
  const Result({
    required this.title,
    required this.size,
    required this.wordcount,
    required this.timestamp,
    required this.snippet,
  });

  factory Result.error({required String code, required String info}) => .new(
    title: code,
    size: 0,
    wordcount: info.length,
    timestamp: .now(),
    snippet: info,
  );

  factory Result.fromJson(Object? json) {
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

    throw const FormatException('[Result]: Invalid JSON data');
  }

  final String title;
  final int size;
  final int wordcount;
  final DateTime timestamp;
  final String snippet;
}

extension Utils on Result {
  String get label => '$title${size > 0 ? ' ($sizeToMemory)' : ''}';
  String get sizeToMemory => size / 1024 < 1024
      ? '${(size / 1024).toStringAsFixed(2)} KB'
      : '${(size / 1024 / 1024).toStringAsFixed(2)} MB';
}
