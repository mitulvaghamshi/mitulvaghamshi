import 'package:flutter/material.dart';
import 'package:sphere/app.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(context) =>
      const MaterialApp(title: 'Flutter Sphere', home: SphereApp());
}
