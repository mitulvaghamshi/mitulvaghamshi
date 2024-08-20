import 'package:apis/models/inventory.dart';
import 'package:flutter/cupertino.dart';

@immutable
class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key, this.pet});

  final Pet? pet;

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  late Pet _pet = widget.pet ?? const .empty();

  late final _animalCtrl = TextEditingController(text: _pet.animal);
  late final _descCtrl = TextEditingController(text: _pet.desc);
  late final _ageCtrl = TextEditingController(text: _pet.age.toString());
  late final _priceCtrl = TextEditingController(text: _pet.price.toString());

  @override
  void dispose() {
    _animalCtrl.dispose();
    _descCtrl.dispose();
    _ageCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(_pet.animal),
          trailing: CupertinoButton(
            onPressed: _onClearOrDelete,
            sizeStyle: .small,
            child: Text(
              _pet.id == -1 ? 'Clear' : 'Delete',
              style: const TextStyle(color: CupertinoColors.destructiveRed),
            ),
          ),
        ),
        SliverSafeArea(
          sliver: SliverList.list(
            children: [
              CupertinoFormSection.insetGrouped(
                header: const Text(
                  'Update Pet details and click Submit to save,'
                  ' or click Cancel to abort.',
                ),
                children: [
                  CupertinoTextFormFieldRow(
                    controller: _animalCtrl,
                    placeholder: 'Enter name',
                    prefix: const Icon(CupertinoIcons.person),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _descCtrl,
                    placeholder: 'Enter description',
                    prefix: const Icon(CupertinoIcons.line_horizontal_3),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _ageCtrl,
                    placeholder: 'Enter age',
                    prefix: const Icon(CupertinoIcons.stopwatch),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _priceCtrl,
                    placeholder: 'Enter price',
                    prefix: const Icon(CupertinoIcons.money_dollar),
                  ),
                ],
              ),
              Padding(
                padding: const .symmetric(horizontal: 20),
                child: CupertinoButton.filled(
                  onPressed: _onSave,
                  child: const Text('Save changes'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

extension on _InventoryFormState {
  Future<void> _onSave() async {
    if (_animalCtrl.text.isEmpty || _descCtrl.text.isEmpty) return;
    _pet = _pet.copyWith(
      animal: _animalCtrl.text,
      desc: _descCtrl.text,
      age: .tryParse(_ageCtrl.text),
      price: .tryParse(_priceCtrl.text),
    );
    if (_pet.id == -1) {
      await Inventory.insert(_pet);
    } else {
      await Inventory.update(_pet);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _onClearOrDelete() async {
    if (_pet.id != -1) {
      await Inventory.delete(_pet);
      if (mounted) Navigator.pop(context);
    }
    _animalCtrl.clear();
    _descCtrl.clear();
    _ageCtrl.clear();
    _priceCtrl.clear();
  }
}
