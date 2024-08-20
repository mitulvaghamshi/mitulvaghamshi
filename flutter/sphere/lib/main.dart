import 'package:flutter/material.dart';
import 'package:sphere/app.dart';

void main() => runApp(const MyApp());

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      title: 'Flutter Sphere',
      home: SphereApp(),
    );
  }
}
