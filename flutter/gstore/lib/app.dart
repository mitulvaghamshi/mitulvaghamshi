import 'package:flutter/material.dart';
import 'package:gstore/utils/app_state.dart';
import 'package:gstore/utils/server.dart';
import 'package:gstore/widgets/cart_badge_icon.dart';
import 'package:gstore/widgets/product_tile.dart';
import 'package:gstore/widgets/search_field.dart';

@immutable
class GoogleStore extends StatefulWidget {
  const GoogleStore({super.key});

  @override
  GoogleStoreState createState() => GoogleStoreState();
}

class GoogleStoreState extends State<GoogleStore> {
  late final _controller = TextEditingController();
  late final _focusNode = FocusNode();
  bool _inSearch = false;

  void _toggleSearch() {
    setState(() => _inSearch = !_inSearch);
    AppWidget.of(context).setProductList(Server.getProductList());
    _controller.clear();
  }

  void _handleSearch() {
    _focusNode.unfocus();
    AppWidget.of(context)
        .setProductList(Server.getProductList(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final products = AppScope.of(context).products;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('assets/google-logo.png'),
          ),
          title: _inSearch
              ? SearchField(
                  focusNode: _focusNode,
                  controller: _controller,
                  onSubmit: _handleSearch,
                  onClose: _toggleSearch,
                )
              : const Text('Google Store'),
          actions: [
            if (!_inSearch)
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(Icons.search, color: Colors.black),
              ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: CartBadgeIcon(),
            ),
          ],
        ),
        SliverList.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => ProductTile(id: products.elementAt(index)),
        ),
      ]),
    );
  }
}
