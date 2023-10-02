import 'package:apis/gita/gita.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ChapterReader extends StatelessWidget {
  const ChapterReader({super.key, required this.chapter});

  final Gita chapter;

  @override
  Widget build(BuildContext context) {
    final verses = chapter.verses;
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text(chapter.title),
        trailing: Text(chapter.verseCount.toString()),
      ),
      SliverSafeArea(
        minimum: const EdgeInsets.all(8),
        sliver: SliverList.builder(
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final verse = verses.elementAt(index);
            if (verse.isSpeaker) {
              return _ListItem(
                text: verse.content,
                color: const Color(0xffdaffdc),
              );
            }
            return _ListItem(
              text: verse.content.replaceAll(';', '\n'),
              color: const Color(0xffe0e7ff),
            );
          },
        ),
      ),
    ]);
  }
}

@immutable
class _ListItem extends StatelessWidget {
  const _ListItem({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ColoredBox(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Color(0xff303030)),
          ),
        ),
      ),
    );
  }
}
