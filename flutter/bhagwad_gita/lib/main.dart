import 'package:bhagwad_gita/app.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

@immutable
class const MainApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bhagwad Gita',
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: const BhagwadGitaApp(),
  );
}
