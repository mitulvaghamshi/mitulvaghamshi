import 'package:apis/gita/gita_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Gita {
  const Gita({
    required this.id,
    required this.title,
    required this.verses,
  });

  factory Gita.fromJson(final Map<String, dynamic> json) {
    if (json
        case {
          'id': final int id,
          'title': final String title,
          'verses': final List<dynamic> verses,
        }) {
      final list = List<Map<String, dynamic>>.from(verses);
      return Gita(
        id: id,
        title: title,
        verses: list.map(Verse.fromJson),
      );
    }
    throw '[GitaChapter]: Invalid Json data.';
  }

  final int id;
  final String title;
  final Iterable<Verse> verses;

  static String path = 'assets/gita.json';

  static Gita Function(Map<String, dynamic> json) factory = Gita.fromJson;

  static Widget Function(Iterable<Gita> items) builder = GitaScreen.builder;

  int get verseCount => verses.where((final verse) => !verse.isSpeaker).length;
}

@immutable
class Verse {
  const Verse({required this.isSpeaker, required this.content});

  factory Verse.fromJson(final Map<String, dynamic> json) {
    if (json
        case {
          'speaker': final bool speaker,
          'content': final String content,
        }) {
      return Verse(isSpeaker: speaker, content: content);
    }
    throw '[Verse]: Invalid Json data.';
  }

  final bool isSpeaker;
  final String content;
}
