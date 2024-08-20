import 'package:apis/models/inventory.dart';
import 'package:apis/widgets/inventory_form.dart';
import 'package:apis/widgets/page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _currency = NumberFormat.simpleCurrency();

@immutable
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      future: Inventory.query,
      builder: (items) => InventoryApp(items: items),
    );
  }
}

@immutable
class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key, required this.items});

  final Iterable<Pet> items;

  @override
  State<InventoryApp> createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  late Iterable<Pet> _items = widget.items;

  Future<void> _onSearch(String term) async {
    final items = term.isEmpty //
        ? widget.items
        : (await Inventory.search(term)).items;
    setState(() => _items = items);
  }

  Future<void> _onRefresh() async {
    final items = (await Inventory.query).items;
    setState(() => _items = items);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: const Text('Pet Inventory'),
        trailing: CupertinoButton(
          onPressed: () async => await Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => const InventoryForm()),
          ),
          sizeStyle: CupertinoButtonSize.small,
          child: const Text('Add New'),
        ),
      ),
      CupertinoSliverRefreshControl(onRefresh: _onRefresh),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CupertinoSearchTextField(
            onSubmitted: _onSearch,
            placeholder: 'Search inventory...',
          ),
        ),
      ),
      SliverSafeArea(
        sliver: SliverList.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) => _PetListItem(
            pet: _items.elementAt(index),
          ),
        ),
      ),
    ]);
  }
}

@immutable
class _PetListItem extends StatelessWidget {
  const _PetListItem({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leadingSize: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(child: Text(pet.animal[0])),
      title: Text(pet.animal),
      subtitle: Text(pet.desc),
      additionalInfo: Text(_currency.format(pet.price)),
      trailing: const CupertinoListTileChevron(),
      onTap: () async => await Navigator.of(context).push(CupertinoPageRoute(
        builder: (_) => InventoryForm(pet: pet),
      )),
    );
  }
}
