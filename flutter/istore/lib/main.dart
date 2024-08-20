import 'package:flutter/cupertino.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/tabs/product_gallery.dart';
import 'package:istore/tabs/product_list.dart';
import 'package:istore/tabs/shopping_cart.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => AppState(),
    child: const CupertinoApp(title: 'Cupertino Store', home: CupertinoStore()),
  );
}

@immutable
class CupertinoStore extends StatelessWidget {
  const CupertinoStore({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: const [
        BottomNavigationBarItem(
          label: 'Products',
          icon: Icon(CupertinoIcons.home),
        ),
        BottomNavigationBarItem(
          label: 'Gallery',
          icon: Icon(CupertinoIcons.rectangle_on_rectangle_angled),
        ),
        BottomNavigationBarItem(
          label: 'Cart',
          icon: Icon(CupertinoIcons.shopping_cart),
        ),
      ],
    ),
    tabBuilder: (_, index) => CupertinoTabView(
      builder: (_) => CupertinoPageScaffold(
        child: switch (index) {
          0 => const ProductList(),
          1 => const ProductsGallery(),
          2 => const ShoppingCart(),
          _ => ErrorWidget('Invelid Tab Index: $index'),
        },
      ),
    ),
  );
}
