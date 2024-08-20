import 'package:bhagwad_gita/utils/repo.dart';
import 'package:bhagwad_gita/widgets/chapter_item.dart';
import 'package:bhagwad_gita/widgets/chapter_view.dart';
import 'package:flutter/material.dart';

@immutable
class const BhagwadGitaApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: Repo.query,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return const ChapterItem(
          onTap: null,
          chapter: .new(id: 0, title: 'Something went wrong!', items: []),
        );
      }

      final chapters = snapshot.requireData.items;
      return Scaffold(
        appBar: AppBar(title: const Text('Bhagwad Gita')),
        body: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            return ChapterItem(
              onTap: () async {
                final page = ChapterView(chapter: chapters.elementAt(index));
                final route = MaterialPageRoute<void>(builder: (_) => page);
                await Navigator.push(context, route);
              },
              chapter: chapters.elementAt(index),
            );
          },
        ),
      );
    },
  );
}
