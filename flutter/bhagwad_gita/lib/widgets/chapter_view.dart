import 'package:bhagwad_gita/models/chapter.dart';
import 'package:flutter/material.dart';

@immutable
class ChapterView extends StatelessWidget {
  const ChapterView({required this.chapter, super.key});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(chapter.title),
      actions: [
        Padding(
          padding: const .all(16),
          child: Text('${chapter.items.length}'),
        ),
      ],
    ),
    body: ListView.builder(
      padding: const .all(16),
      itemCount: chapter.items.length,
      itemBuilder: (context, index) {
        final item = chapter.items.elementAt(index);
        final isSpeaker = item.startsWith('::');
        return Card.outlined(
          elevation: 8,
          clipBehavior: .hardEdge,
          margin: const .symmetric(vertical: 8),
          child: Padding(
            padding: .symmetric(horizontal: 8, vertical: isSpeaker ? 8 : 16),
            child: Text(
              isSpeaker ? item.substring(2) : item.replaceFirst(';', '\n'),
              textAlign: .center,
              style: const .new(fontSize: 18),
            ),
          ),
        );
      },
    ),
  );
}
