import 'package:bhagwad_gita/utils/repo.dart';
import 'package:bhagwad_gita/widgets/chapter_item.dart';
import 'package:bhagwad_gita/widgets/chapter_view.dart';
import 'package:flutter/material.dart';

@immutable
class BhagwadGitaApp extends StatelessWidget {
  const BhagwadGitaApp({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: Repo.query,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return ChapterItem(
          onTap: () {},
          chapter: const .new(id: 0, title: 'Something went wrong!', items: []),
        );
      }
      final chapters = snapshot.requireData.items;
      return Scaffold(
        appBar: AppBar(title: const Text('Bhagwad Gita')),
        body: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters.elementAt(index);
            return ChapterItem(
              onTap: () async {
                final page = ChapterView(chapter: chapter);
                final route = MaterialPageRoute(builder: (_) => page);
                await Navigator.push(context, route);
              },
              chapter: chapter,
            );
          },
        ),
      );
    },
  );
}
