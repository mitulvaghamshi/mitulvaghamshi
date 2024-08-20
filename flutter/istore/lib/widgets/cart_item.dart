import 'package:istore/models/app_state.dart';
import 'package:istore/models/product.dart';
import 'package:istore/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@immutable
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.index,
    required this.product,
    required this.lastItem,
    required this.quantity,
    required this.formatter,
  });

  factory CartItem.from({
    required final int index,
    required final NumberFormat format,
    required final AppState model,
  }) {
    return CartItem(
      index: index,
      product: model.getProductBy(
        model.certItems.keys.elementAt(index - 5),
      ),
      quantity: model.certItems.values.elementAt(index - 5),
      lastItem: index - 5 == model.certItems.length - 1,
      formatter: format,
    );
  }

  final Product product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(children: [
        CupertinoButton(
          onPressed: () => Provider.of<AppState>(
            context,
            listen: false,
          ).removeFromCart(product.id),
          child: const Icon(
            CupertinoIcons.minus_circle,
            color: CupertinoColors.destructiveRed,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            product.itemAsset,
            package: product.package,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name, style: Styles.productItemName),
                    Text(
                      formatter.format(quantity * product.price),
                      style: Styles.productItemName,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${quantity > 1 ? '$quantity x ' : ''}'
                  '${formatter.format(product.price)}',
                  style: Styles.productItemPrice,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
