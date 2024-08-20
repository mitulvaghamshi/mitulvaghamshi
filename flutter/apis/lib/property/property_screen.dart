import 'package:apis/property/property.dart';
import 'package:apis/property/property_item.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PropertyScreen extends StatelessWidget {
  const PropertyScreen.builder(this.properties, {super.key});

  final Iterable<Property> properties;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(
        largeTitle: Text('Property on Mars'),
      ),
      SliverSafeArea(
        minimum: const EdgeInsets.all(16),
        sliver: SliverList.builder(
          itemCount: properties.length,
          itemBuilder: (context, index) => PropertyItem(
            property: properties.elementAt(index),
          ),
        ),
      ),
    ]);
  }
}
