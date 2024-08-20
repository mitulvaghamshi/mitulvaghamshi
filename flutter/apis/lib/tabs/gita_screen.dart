import 'package:apis/models/gita.dart';
import 'package:apis/widgets/page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class GitaScreen extends StatelessWidget {
  const GitaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      future: Gita.query,
      builder: (chapters) => CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('Bhagwad Gita')),
        SliverSafeArea(
          minimum: const EdgeInsets.all(16),
          sliver: SliverList.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) => _ChapterListItem(
              chapter: chapters.elementAt(index),
            ),
          ),
        ),
      ]),
    );
  }
}

@immutable
class _ChapterListItem extends StatelessWidget {
  const _ChapterListItem({required this.chapter});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final count = chapter.verses.where((verse) => !verse.isSpeaker).length;
    return CupertinoListTile(
      leadingSize: 50,
      leadingToTitle: 4,
      padding: const EdgeInsets.all(4),
      leading: CircleAvatar(child: Text(chapter.id.toString())),
      title: Text(chapter.title),
      additionalInfo: Text(count.toString()),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
        builder: (_) => _ChapterScreen(chapter: chapter, count: count),
      )),
    );
  }
}

@immutable
class _ChapterScreen extends StatelessWidget {
  const _ChapterScreen({required this.chapter, required this.count});

  final Chapter chapter;
  final int count;

  @override
  Widget build(BuildContext context) {
    final verses = chapter.verses;
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(chapter.title),
          trailing: Text(count.toString()),
        ),
        SliverSafeArea(
          minimum: const EdgeInsets.all(16),
          sliver: SliverList.builder(
            itemCount: verses.length,
            itemBuilder: (_, index) => _VerseListItem(
              verse: verses.elementAt(index),
            ),
          ),
        ),
      ]),
    );
  }
}

@immutable
class _VerseListItem extends StatelessWidget {
  const _VerseListItem({required this.verse});

  final Verse verse;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: verse.isSpeaker //
          ? const Color(0xFFC2FFC4)
          : const Color(0xFFB298FF),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          verse.isSpeaker ? verse.content : verse.content.replaceAll(';', '\n'),
          style: const TextStyle(fontSize: 18, color: Color(0xff303030)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
