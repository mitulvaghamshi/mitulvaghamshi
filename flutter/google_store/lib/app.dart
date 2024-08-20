import 'package:flutter/material.dart';
import 'package:google_store/states/app_scope.dart';
import 'package:google_store/widgets/cart_icon.dart';
import 'package:google_store/widgets/product_tile.dart';
import 'package:google_store/widgets/search_field.dart';

@immutable
class GoogleStoreApp extends StatelessWidget {
  const GoogleStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AppScope.of(context);
    return AnimatedBuilder(
      animation: model,
      child: Padding(
        padding: const .all(16),
        child: Image.asset('assets/google-logo.webp'),
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: child,
          centerTitle: true,
          title: AnimatedSwitcher(
            duration: .new(milliseconds: 100),
            child: model.isSearchActive
                ? SearchField(
                    onSubmit: model.loadProducts,
                    onClose: model.toggleSearch,
                  )
                : const Text('Google Store'),
          ),
          actions: [
            if (!model.isSearchActive)
              IconButton(
                onPressed: model.toggleSearch,
                icon: const Icon(Icons.search, color: Colors.black),
              ),
            CartIcon(count: model.cart.length),
          ],
        ),
        body: ListView.separated(
          itemCount: model.products.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (_, index) {
            final key = model.products.elementAt(index);
            final product = model.getProductBy(id: key);
            return ProductTile(product: product);
          },
        ),
      ),
    );
  }
}
