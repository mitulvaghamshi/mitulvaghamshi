import 'package:apis/gita/chapter_reader.dart';
import 'package:apis/gita/gita.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class GitaScreen extends StatelessWidget {
  const GitaScreen.builder(this.chapters, {super.key});

  final Iterable<Gita> chapters;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(
        largeTitle: Text('Bhagwad Gita'),
      ),
      SliverSafeArea(
        minimum: const EdgeInsets.all(16),
        sliver: SliverList.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters.elementAt(index);
            return CupertinoListTile(
              leadingSize: 40,
              padding: const EdgeInsets.symmetric(vertical: 8),
              leading: CircleAvatar(child: Text(chapter.id.toString())),
              title: Text(chapter.title),
              additionalInfo: Text(chapter.verseCount.toString()),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) {
                  return ChapterReader(chapter: chapter);
                }),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
