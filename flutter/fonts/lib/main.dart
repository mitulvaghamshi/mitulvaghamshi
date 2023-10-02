import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Fonts',
      home: const AssetFontsApp(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

@immutable
class AssetFontsApp extends StatelessWidget {
  const AssetFontsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [Text('Swipe to see more')],
      body: PageView.builder(
        itemCount: fonts.length,
        itemBuilder: (_, index) => FontItem(font: fonts[index]),
      ),
    );
  }
}

@immutable
class FontItem extends StatelessWidget {
  const FontItem({super.key, required this.font});

  final (String, String) font;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          font.$1,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        Text.rich(
          TextSpan(text: font.$1, children: const [
            WidgetSpan(child: Divider()),
            TextSpan(text: '\nA QUICK BROWN FOX JUMPS OVER THE LAZY DOG'),
            WidgetSpan(child: Divider()),
            TextSpan(text: '\nquick brown fox jumps over the lazy dog'),
            WidgetSpan(child: Divider()),
            TextSpan(text: '\n1234567890'),
          ]),
          style: TextStyle(fontFamily: font.$2, fontSize: 40),
        ),
      ],
    );
  }
}

const fonts = [
  ('Enjoy The Time', 'enjoy the time'),
  ('Enjoy The Time Hollow', 'enjoy the time hollow'),
  ('Enjoy The Time Inverse', 'enjoy the time inverse'),
  ('Eternal Love', 'eternal love'),
  ('Eternal Love Hollow', 'eternal love hollow'),
  ('Eternal Love Hollow Inverse', 'eternal love hollow inverse'),
  ('Eternal Love Inverse', 'eternal love inverse'),
  ('Frame Work', 'frame work'),
  ('Frame Work Hollow', 'frame work hollow'),
  ('Frame Work Hollow Inverse', 'frame work hollow inverse'),
  ('Frame Work Filled Inverse', 'frame work filled inverse'),
  ('Frankenstain Monster', 'frankenstain monster'),
  ('Frankenstain Monster Hollow', 'frankenstain monster hollow'),
  ('Gabrielle', 'gabrielle'),
  ('Gabrielle Hollow', 'gabrielle hollow'),
  ('Gabrielle Hollow Inverse', 'gabrielle hollow inverse'),
  ('Gabrielle Inverse', 'gabrielle inverse'),
  ('Game Player', 'game player'),
  ('Game Player Hollow', 'game player hollow'),
  ('Game Player Hollow Inverse', 'game player hollow inverse'),
  ('Game Player Inverse', 'game player inverse'),
  ('Nano', 'nano'),
  ('Nano Inverse', 'nano inverse'),
  ('Droid', 'droid'),
  ('Decorated', 'decorated'),
  ('Digital', 'digital'),
  ('Frame', 'frame'),
  ('Leafly', 'leafly'),
  ('Mandalas', 'mandalas'),
  ('Mountain Dew', 'mountain dew'),
  ('Origami', 'origami'),
  ('Precious', 'precious'),
  ('Sketch Rock Wall', 'sketch rock wall'),
];
