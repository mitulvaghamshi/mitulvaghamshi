import 'package:apis/api/repo.dart';
import 'package:apis/tabs/gita_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
mixin Gita on GitaScreen {
  static Future<Repo<Chapter>> get query =>
      Repo.asset('assets/gita.json', Chapter.fromJson);
}

@immutable
class Chapter {
  const Chapter({required this.id, required this.title, required this.verses});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'title': String title,
          'verses': List<dynamic> verses,
        }) {
      final list = List<Map<String, dynamic>>.from(verses);
      return Chapter(id: id, title: title, verses: list.map(Verse.fromJson));
    }
    throw '[Chapter]: Invalid Json data.';
  }

  final int id;
  final String title;
  final Iterable<Verse> verses;
}

@immutable
class Verse {
  const Verse({required this.isSpeaker, required this.content});

  factory Verse.fromJson(Map<String, dynamic> json) {
    if (json case {'speaker': bool speaker, 'content': String content}) {
      return Verse(isSpeaker: speaker, content: content);
    }
    throw '[Verse]: Invalid Json data.';
  }

  final bool isSpeaker;
  final String content;
}
