import 'package:bhagwad_gita/app.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bhagwad Gita',
    home: BhagwadGitaApp(),
  );
}
