import 'package:flutter/cupertino.dart';
import 'package:wiki_search/app.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoApp(
    title: 'Wiki Serach',
    home: CupertinoPageScaffold(child: WikiApp()),
  );
}
