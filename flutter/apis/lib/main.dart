import 'package:apis/tabs/contact_screen.dart';
import 'package:apis/tabs/gita_screen.dart';
import 'package:apis/tabs/inventory_screen.dart';
import 'package:apis/tabs/wiki_screen.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'API Explorer',
      theme: CupertinoTheme.of(context),
      home: const ApiExplorerApp(),
    );
  }
}

@immutable
class ApiExplorerApp extends StatelessWidget {
  const ApiExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tabItems = _tabItems.map((e) {
      return BottomNavigationBarItem(label: e.label, icon: Icon(e.icon));
    });
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: tabItems.toList()),
      tabBuilder: (_, index) => CupertinoTabView(builder: (_) {
        return CupertinoPageScaffold(
          child: switch (index) {
            0 => const InventoryScreen(),
            1 => const ContactScreen(),
            2 => const GitaScreen(),
            3 => const WikiScreen(),
            _ => throw '[ERROR]: Invalid tab index: $index',
          },
        );
      }),
    );
  }
}

const _tabItems = [
  (label: 'Inventory', icon: CupertinoIcons.cart),
  (label: 'Contacts', icon: CupertinoIcons.person_2),
  (label: 'Bhagwad Gita', icon: CupertinoIcons.book_circle),
  (label: 'Wikipedia', icon: CupertinoIcons.book),
];
