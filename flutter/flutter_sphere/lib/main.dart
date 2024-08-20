import 'package:flutter/material.dart';
import 'package:flutter_sphere/app.dart';

void main() => runApp(const MainApp());

@immutable
class const MainApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Sphere',
    home: SphereApp(),
  );
}
