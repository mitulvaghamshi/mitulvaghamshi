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
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: BottomNavigationBar(
      onTap: (value) => setState(() => _currentIndex = value),
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.swipe), label: 'Page'),
      ],
    ),
    body: switch (_currentIndex) {
      0 => ListView.separated(
        itemCount: fonts.length,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (context, index) =>
            _FontListItem(index: index, name: fonts[index]),
      ),
      1 => PageView.builder(
        itemCount: fonts.length,
        itemBuilder: (context, index) =>
            _FontPageItem(index: index, name: fonts[index]),
      ),
      _ => throw RangeError.index(_currentIndex, 2, '$_currentIndex'),
    },
  );
}

@immutable
class _FontListItem extends StatelessWidget {
  const _FontListItem({required this.index, required this.name});
  final int index;
  final String name;
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(name),
    leading: CircleAvatar(child: Text('${index + 1}')),
    subtitle: DefaultTextStyle.merge(
      style: TextStyle(fontFamily: name),
      child: const Text(
        'A Quick BROWN FOX jumps over the lazyyy Dog +123.',
        style: TextStyle(fontSize: 26),
      ),
    ),
  );
}

@immutable
class _FontPageItem extends StatelessWidget {
  const _FontPageItem({required this.index, required this.name});
  final int index;
  final String name;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const .all(16),
    child: Column(
      children: [
        Text(name),
        const Divider(),
        DefaultTextStyle.merge(
          style: TextStyle(fontFamily: name, fontSize: 40),
          child: const Column(
            children: [
              Text('A QUICK BROWN FOX JUMPS OVER THE LAZY DOG'),
              Divider(),
              Text('a quick brown fox jumps over the lazy dog'),
              Divider(),
              Text('+1 (234) 561-7890'),
            ],
          ),
        ),
      ],
    ),
  );
}

const fonts = [
  'Enjoy The Time Hollow',
  'Enjoy The Time Inverse',
  'Enjoy The Time',
  'Eternal Love Hollow Inverse',
  'Eternal Love Hollow',
  'Eternal Love Inverse',
  'eternal love',
  'Font-011',
  'Frame Work Filled Inverse',
  'Frame Work Hollow Inverse',
  'Frame Work Hollow',
  'frame work',
  'Frankenstain Monster Hollow',
  'frankenstain monster',
  'Gabrielle Hollow Inverse',
  'Gabrielle Hollow',
  'Gabrielle Inverse',
  'gabrielle',
  'Game Player Hollow Inverse',
  'Game Player Hollow',
  'Game Player Inverse',
  'game player',
  'Nano Inverse',
  'nano',
  'decorated',
  'digital',
  'droid',
  'frame',
  'leafly',
  'mandalas',
  'mountain dew',
  'origami',
  'precious',
  'sketch rock wall',
];
