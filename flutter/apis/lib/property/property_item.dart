import 'package:apis/common/image_widget.dart';
import 'package:apis/property/property.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PropertyItem extends StatelessWidget {
  const PropertyItem({super.key, required this.property});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leadingSize: 50,
      title: Text('\$${property.price}'),
      subtitle: Text(property.payment),
      leading: ImageWidget(url: property.imgSrc, size: 50),
      padding: const EdgeInsets.symmetric(vertical: 8),
      additionalInfo: Text(property.type.toUpperCase()),
    );
  }
}
