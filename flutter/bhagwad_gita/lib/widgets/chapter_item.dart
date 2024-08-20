import 'package:bhagwad_gita/models/chapter.dart';
import 'package:flutter/material.dart';

@immutable
class ChapterItem extends StatelessWidget {
  const ChapterItem({super.key, required this.onTap, required this.chapter});

  final VoidCallback onTap;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    contentPadding: const .symmetric(vertical: 8, horizontal: 16),
    leading: CircleAvatar(child: Text('${chapter.id}')),
    title: Text(chapter.title, style: const .new(fontSize: 18)),
    trailing: Text('${chapter.items.length}', style: const .new(fontSize: 16)),
  );
}
