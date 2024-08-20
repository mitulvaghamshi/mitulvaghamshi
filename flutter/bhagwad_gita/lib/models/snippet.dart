import 'package:flutter/material.dart';

@immutable
class Snippet {
  const Snippet({
    required this.id,
    required this.title,
    required this.chapter,
    required this.verses,
    required this.sanskrit,
    required this.transliteration,
    required this.verseTranslations,
    required this.commentary,
    required this.reflection,
    required this.shortReflection,
  });

  factory Snippet.fromJson(Object? json) {
    if (json case {
      'id': int id,
      'title': String title,
      'chapter': int chapter,
      'verses': String verses,
      'sanskrit': String sanskrit,
      'transliteration': String transliteration,
      'verseTranslations': Iterable<dynamic> verseTranslations,
      'commentary': String commentary,
      'reflection': String reflection,
      'shortReflection': String shortReflection,
    }) {
      return .new(
        id: id,
        title: title,
        chapter: chapter,
        verses: verses,
        sanskrit: sanskrit,
        transliteration: transliteration,
        verseTranslations: verseTranslations.cast(),
        commentary: commentary,
        reflection: reflection,
        shortReflection: shortReflection,
      );
    }

    throw FormatException('[$Snippet]: Invalid JSON, $json');
  }

  final int id;
  final String title;
  final int chapter;
  final String verses;
  final String sanskrit;
  final String transliteration;
  final Iterable<String> verseTranslations;
  final String commentary;
  final String reflection;
  final String shortReflection;
}
