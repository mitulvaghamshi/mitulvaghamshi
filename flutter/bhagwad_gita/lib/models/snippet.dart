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
      'id': final int id,
      'title': final String title,
      'chapter': final int chapter,
      'verses': final String verses,
      'sanskrit': final String sanskrit,
      'transliteration': final String transliteration,
      'verseTranslations': final Iterable<dynamic> verseTranslations,
      'commentary': final String commentary,
      'reflection': final String reflection,
      'shortReflection': final String shortReflection,
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
