import 'package:flutter/cupertino.dart';
import 'package:pet_store/models/pet.dart';
import 'package:pet_store/models/repo.dart';
import 'package:pet_store/widgets/pet_details.dart';
import 'package:pet_store/widgets/pet_item.dart';

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
    final repo = await Repo.query(
      .http(host, 'api/pets/search/$term'),
      Pet.fromJson,
    );
    setState(() => _items = term.isEmpty ? widget.items : repo.items);
  }

  Future<void> _onRefresh() async {
    final repo = await Repo.query(.http(host, 'api/pets'), Pet.fromJson);
    setState(() => _items = repo.items);
  }

  Future<void> _onTap([Pet? pet]) async {
    final page = CupertinoPageRoute(builder: (_) => PetDetails(pet: pet));
    await Navigator.of(context).push(page);
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverSafeArea(
        minimum: const .only(top: 16),
        sliver: CupertinoSliverNavigationBar.search(
          largeTitle: const Text('Pet Inventory'),
          searchField: CupertinoSearchTextField(
            onSubmitted: _onSearch,
            placeholder: 'Search inventory...',
          ),
        ),
      ),
      CupertinoSliverRefreshControl(onRefresh: _onRefresh),
      SliverPadding(
        padding: const .symmetric(vertical: 8, horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: CupertinoButton.tinted(
            onPressed: _onTap,
            sizeStyle: .small,
            child: const Text('Add New'),
          ),
        ),
      ),
      SliverList.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          final pet = _items.elementAt(index);
          return PetItem(onTap: () => _onTap(pet), pet: pet);
        },
      ),
    ],
  );
}
