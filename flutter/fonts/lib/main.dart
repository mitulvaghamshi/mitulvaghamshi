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
class FontsApp extends StatefulWidget {
  const FontsApp({super.key});

  @override
  State<FontsApp> createState() => _FontsAppState();
}

class _FontsAppState extends State<FontsApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _currentIndex = value),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.swipe), label: 'Page'),
        ],
      ),
      body: switch (_currentIndex) {
        0 => ListView.separated(
            itemCount: fonts.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (_, index) => FontListItem(fontName: fonts[index]),
          ),
        1 => PageView.builder(
            itemCount: fonts.length,
            itemBuilder: (_, index) => FontPageItem(fontName: fonts[index]),
          ),
        _ => throw ErrorWidget('Invalid Index'),
      },
    );
  }
}

@immutable
class FontListItem extends StatelessWidget {
  const FontListItem({super.key, required this.fontName});

  final String fontName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fontName),
      leading: CircleAvatar(child: Text(fontName[0].toUpperCase())),
      subtitle: DefaultTextStyle.merge(
        style: TextStyle(fontFamily: fontName),
        child: Text(
          'A Quick BROWN FOX jumps over the lazyyy Dog +123.',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}

@immutable
class FontPageItem extends StatelessWidget {
  const FontPageItem({super.key, required this.fontName});

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
  'decorated',
  'digital',
  'droid',
  'enjoy the time hollow',
  'enjoy the time inverse',
  'enjoy the time',
  'eternal love hollow inverse',
  'eternal love hollow',
  'eternal love inverse',
  'eternal love',
  'font-011',
  'frame work filled inverse',
  'frame work hollow inverse',
  'frame work hollow',
  'frame work',
  'frame',
  'frankenstain monster hollow',
  'frankenstain monster',
  'gabrielle hollow inverse',
  'gabrielle hollow',
  'gabrielle inverse',
  'gabrielle',
  'game player hollow inverse',
  'game player hollow',
  'game player inverse',
  'game player',
  'leafly',
  'mandalas',
  'mountain dew',
  'nano inverse',
  'nano',
  'origami',
  'precious',
  'sketch rock wall',
];
