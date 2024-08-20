import 'package:flutter/cupertino.dart';
import 'package:wiki_search/app.dart';

void main() => runApp(const MainApp());

class const MainApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const CupertinoApp(
    title: 'Wiki Serach',
    home: CupertinoPageScaffold(child: WikiApp()),
  );
}
