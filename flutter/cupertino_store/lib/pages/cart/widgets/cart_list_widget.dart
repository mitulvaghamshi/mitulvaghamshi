import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/pages/cart/widgets/cart_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class CartListWidget extends StatelessWidget {
  const CartListWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<AppState>(
    builder: (context, model, child) => SliverList.builder(
      itemCount: model.certItems.length,
      itemBuilder: (_, index) => CartListItem(
        product: model.getProductBy(model.certItems.keys.elementAt(index)),
        quantity: model.certItems.values.elementAt(index),
      ),
    ),
  );
}
