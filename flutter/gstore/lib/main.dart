import 'package:flutter/material.dart';
import 'package:gstore/models/app_scope.dart';
import 'package:gstore/models/app_state.dart';
import 'package:gstore/widgets/cart_icon.dart';
import 'package:gstore/widgets/product_tile.dart';
import 'package:gstore/widgets/search_field.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Store',
      home: AppScope(data: AppState(), child: const GoogleStore()),
    );
  }
}

@immutable
class GoogleStore extends StatelessWidget {
  const GoogleStore({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AppScope.of(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: model,
        builder: (_, child) => CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset('assets/google-logo.webp'),
            ),
            title: model.isSearchActive
                ? SearchField(
                    onSubmit: model.loadProducts,
                    onClose: model.toggleSearch,
                  )
                : const Text('Google Store'),
            actions: [
              if (!model.isSearchActive)
                IconButton(
                  onPressed: model.toggleSearch,
                  icon: const Icon(Icons.search, color: Colors.black),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CartIcon(count: model.cart.length),
              ),
            ],
          ),
          SliverList.separated(
            itemCount: model.products.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (_, index) => ProductTile(
              product: model.getProductBy(index),
            ),
          ),
        ]),
      ),
    );
  }
}
