import 'package:apis/common/tab_page_builder.dart';
import 'package:apis/contact/contact.dart';
import 'package:apis/gita/gita.dart';
import 'package:apis/mars/mars.dart';
import 'package:apis/property/property.dart';
import 'package:apis/wiki/wiki_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ApiRequestApp extends StatelessWidget {
  const ApiRequestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _tabItems.map((e) {
          return BottomNavigationBarItem(label: e.label, icon: Icon(e.icon));
        }).toList(),
      ),
      tabBuilder: (_, index) => CupertinoTabView(builder: (_) {
        return CupertinoPageScaffold(
          child: switch (index) {
            0 => TabPageBuilder(
                path: Contact.path,
                factory: Contact.factory,
                builder: Contact.builder,
              ),
            1 => TabPageBuilder(
                path: Property.path,
                factory: Property.factory,
                builder: Property.builder,
              ),
            2 => TabPageBuilder(
                path: Mars.path,
                factory: Mars.factory,
                builder: Mars.builder,
              ),
            3 => TabPageBuilder(
                path: Gita.path,
                factory: Gita.factory,
                builder: Gita.builder,
              ),
            4 => const WikiScreen(),
            _ => throw '[ERROR]: Invalid tab index: $index',
          },
        );
      }),
    );
  }
}

const _tabItems = [
  (label: 'Contacts', icon: CupertinoIcons.person_2),
  (label: 'Mars Property', icon: CupertinoIcons.location_solid),
  (label: 'Mars Photos', icon: CupertinoIcons.photo),
  (label: 'Bhagwad Gita', icon: CupertinoIcons.book_circle),
  (label: 'Wikipedia', icon: CupertinoIcons.book),
];
