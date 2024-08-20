import 'package:cupertino_store/pages/cart/widgets/cart_footer_widget.dart';
import 'package:cupertino_store/pages/cart/widgets/cart_list_widget.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) => const CustomScrollView(
    slivers: [
      CupertinoSliverNavigationBar(largeTitle: Text('Shopping Cart')),
      CartListWidget(),
      SliverFillRemaining(
        hasScrollBody: false,
        fillOverscroll: true,
        child: Padding(
          padding: .fromLTRB(16, 16, 16, 50 + 16),
          child: CartFooterWidget(),
        ),
      ),
    ],
  );
}
