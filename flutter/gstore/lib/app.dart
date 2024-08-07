import 'package:flutter/material.dart';
import 'package:gstore/models/app_scope.dart';
import 'package:gstore/widgets/cart_icon.dart';
import 'package:gstore/widgets/product_tile.dart';
import 'package:gstore/widgets/search_field.dart';

@immutable
class GoogleStore extends StatelessWidget {
  const GoogleStore({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: state,
        builder: (context, child) => CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset('assets/google-logo.webp'),
            ),
            title: state.isSearchActive
                ? SearchField(
                    onSubmit: (filter) => state.getProducts(filter),
                    onClose: state.toggleSearch,
                  )
                : const Text('Google Store'),
            actions: [
              if (!state.isSearchActive)
                IconButton(
                  onPressed: state.toggleSearch,
                  icon: const Icon(Icons.search, color: Colors.black),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CartIcon(count: state.cart.length),
              ),
            ],
          ),
          SliverList.builder(
            itemCount: state.products.length,
            itemBuilder: (_, index) => ProductTile(
              product: state.getProductBy(index),
            ),
          ),
        ]),
      ),
    );
  }
}
