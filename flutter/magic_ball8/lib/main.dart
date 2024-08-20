import 'package:flutter/material.dart';
import 'package:magic_ball8/app.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Magic Ball 8',
    home: MagicBall8App(),
  );
}
