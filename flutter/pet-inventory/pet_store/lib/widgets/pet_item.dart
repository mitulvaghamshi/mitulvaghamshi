import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_store/models/pet.dart';

final _currencyFormater = NumberFormat.simpleCurrency();

@immutable
class PetItem extends StatelessWidget {
  const PetItem({super.key, required this.pet, required this.onTap});

  final Pet pet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CupertinoListTile.notched(
    onTap: onTap,
    leading: CircleAvatar(child: Text(pet.name[0])),
    title: Text(pet.name),
    subtitle: Text(pet.info),
    additionalInfo: Text(_currencyFormater.format(pet.price)),
    trailing: const CupertinoListTileChevron(),
  );
}
