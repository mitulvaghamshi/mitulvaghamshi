import 'package:flutter/material.dart';
import 'package:flutter_sphere/app.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: 'Flutter Sphere',
    debugShowCheckedModeBanner: false,
    home: SphereApp(),
  );
}
