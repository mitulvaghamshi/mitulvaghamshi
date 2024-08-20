import 'package:flutter/material.dart';

@immutable
class const Snippet({
  required final int id,
  required final String title,
  required final int chapter,
  required final String verses,
  required final String sanskrit,
  required final String transliteration,
  required final Iterable<String> verseTranslations,
  required final String commentary,
  required final String reflection,
  required final String shortReflection,
}) {
  factory fromJson(Object? json) {
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
    throw FormatException('[$Snippet]: ${StackTrace.current}');
  }
}
