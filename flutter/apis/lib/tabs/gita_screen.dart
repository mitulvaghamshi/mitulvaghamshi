import 'package:apis/models/gita.dart';
import 'package:apis/widgets/page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class GitaScreen extends StatelessWidget {
  const GitaScreen({super.key});

  @override
  Widget build(BuildContext context) => PageBuilder(
    future: Gita.query,
    builder: (chapters) => CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('Bhagwad Gita')),
        SliverSafeArea(
          minimum: const .all(16),
          sliver: SliverList.builder(
            itemCount: chapters.length,
            itemBuilder: (_, index) =>
                _ChapterListItem(chapter: chapters.elementAt(index)),
          ),
        ),
      ],
    ),
  );
}

@immutable
class _ChapterListItem extends StatelessWidget {
  const _ChapterListItem({required this.chapter});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    onTap: () async {
      final page = _ChapterScreen(chapter: chapter);
      final route = CupertinoPageRoute(builder: (_) => page);
      await Navigator.of(context).push(route);
    },
    leadingSize: 50,
    leadingToTitle: 4,
    padding: const .all(4),
    title: Text(chapter.title),
    trailing: const CupertinoListTileChevron(),
    leading: CircleAvatar(child: Text(chapter.id.toString())),
    additionalInfo: Text(chapter.actualVerseCount.toString()),
  );
}

@immutable
class _ChapterScreen extends StatelessWidget {
  const _ChapterScreen({required this.chapter});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(chapter.title),
          trailing: Text(chapter.actualVerseCount.toString()),
        ),
        SliverSafeArea(
          minimum: const .all(16),
          sliver: SliverList.builder(
            itemCount: chapter.verses.length,
            itemBuilder: (_, index) =>
                _VerseListItem(verse: chapter.verses.elementAt(index)),
          ),
        ),
      ],
    ),
  );
}

@immutable
class _VerseListItem extends StatelessWidget {
  const _VerseListItem({required this.verse});

  final Verse verse;

  @override
  Widget build(BuildContext context) => Card(
    color: verse.isSpeaker ? const Color(0xFFC2FFC4) : const Color(0xFFB298FF),
    child: Padding(
      padding: const .symmetric(vertical: 8),
      child: Text(
        verse.isSpeaker ? verse.content : verse.content.replaceAll(';', '\n'),
        style: const TextStyle(fontSize: 18, color: Color(0xff303030)),
        textAlign: .center,
      ),
    ),
  );
}
