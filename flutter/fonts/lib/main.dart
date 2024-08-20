import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Fonts', home: FontsApp());
  }
}

@immutable
class FontsApp extends StatelessWidget {
  const FontsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: fonts.length,
        itemBuilder: (_, index) => FontItem(fontName: fonts[index]),
      ),
    );
  }
}

@immutable
class FontsApp1 extends StatelessWidget {
  const FontsApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: fonts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return Card.outlined(
            child: FontItem(fontName: fonts[index]),
          );
        },
      ),
    );
  }
}

@immutable
class FontItem extends StatelessWidget {
  const FontItem({super.key, required this.fontName});

  final String fontName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Text(fontName),
        const Divider(),
        DefaultTextStyle.merge(
          style: TextStyle(fontFamily: fontName, fontSize: 40),
          child: const Column(children: [
            Text('A QUICK BROWN FOX JUMPS OVER THE LAZY DOG'),
            Divider(),
            Text('a quick brown fox jumps over the lazy dog'),
            Divider(),
            Text('+1 234 561 7890'),
          ]),
        ),
      ]),
    );
  }
}

const fonts = [
  'Decorated',
  'Digital',
  'Droid',
  'Enjoy The Time Hollow',
  'Enjoy The Time Inverse',
  'Enjoy The Time',
  'Eternal Love Hollow Inverse',
  'Eternal Love Hollow',
  'Eternal Love Inverse',
  'Eternal Love',
  'Font-011',
  'Frame Work Filled Inverse',
  'Frame Work Hollow Inverse',
  'Frame Work Hollow',
  'Frame Work',
  'Frame',
  'Frankenstain Monster Hollow',
  'Frankenstain Monster',
  'Gabrielle Hollow Inverse',
  'Gabrielle Hollow',
  'Gabrielle Inverse',
  'Gabrielle',
  'Game Player Hollow Inverse',
  'Game Player Hollow',
  'Game Player Inverse',
  'Game Player',
  'Leafly',
  'Mandalas',
  'Mountain Dew',
  'Nano Inverse',
  'Nano',
  'Origami',
  'Precious',
  'Sketch Rock Wall',
];
