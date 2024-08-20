import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/server/server.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.onClick});

  final Product product;
  final ValueChanged<int> onClick;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    leadingSize: 100,
    leading: ClipRRect(
      borderRadius: .circular(8),
      child: Image.asset(
        product.thumb,
        package: product.package,
        fit: .cover,
        width: 100,
        height: 100,
      ),
    ),
    title: Text(product.name, style: const .new(fontSize: 18)),
    subtitle: Text(
      format.format(product.price),
      style: const .new(fontWeight: .w300, color: Color(0xFF848484)),
    ),
    trailing: CupertinoButton(
      onPressed: () => onClick(product.id),
      child: const Icon(CupertinoIcons.add_circled),
    ),
  );
}
