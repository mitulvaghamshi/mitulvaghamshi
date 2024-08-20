import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class const CartListItem({
  required final Product product,
  required final int quantity,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoListTile(
    leadingSize: 60,
    leading: ClipRRect(
      borderRadius: .circular(4),
      child: Image.asset(
        product.thumb,
        package: product.package,
        fit: .cover,
        width: 60,
        height: 60,
      ),
    ),
    title: Text(product.name),
    subtitle: Text(
      '${quantity > 1 ? '$quantity x ' : ''}'
      '${currencyFormatter.format(product.price)}',
      style: const .new(color: Color(0xFF848484)),
    ),
    additionalInfo: Text(currencyFormatter.format(quantity * product.price)),
    trailing: CupertinoButton(
      onPressed: () => context.read<AppState>().removeFromCart(product.id),
      sizeStyle: .small,
      child: const Icon(
        CupertinoIcons.minus_circle,
        color: CupertinoColors.destructiveRed,
      ),
    ),
  );
}
