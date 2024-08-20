import 'package:flutter/cupertino.dart';
import 'package:pet_store/models/pet.dart';
import 'package:pet_store/models/repo.dart';

@immutable
class PetDetails extends StatefulWidget {
  const PetDetails({super.key, this.pet});

  final Pet? pet;

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  late Pet _pet = widget.pet ?? const .empty();

  late final _animalCtrl = TextEditingController(text: _pet.name);
  late final _descCtrl = TextEditingController(text: _pet.info);
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
        CupertinoSliverNavigationBar(largeTitle: Text(_pet.name)),
        SliverList.list(
          children: [
            CupertinoFormSection.insetGrouped(
              header: const Text(
                'Update Pet details and click Submit to save, '
                'or click Cancel to discard changes.',
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                CupertinoButton.tinted(
                  onPressed: _onClearOrDelete,
                  sizeStyle: .small,
                  child: Text(
                    _pet.id == -1 ? 'Clear' : 'Delete',
                    style: const TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                ),
                CupertinoButton.tinted(
                  onPressed: _onSave,
                  sizeStyle: .small,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

extension on _PetDetailsState {
  Future<void> _onSave() async {
    if (_animalCtrl.text.isEmpty || _descCtrl.text.isEmpty) {
      return;
    }

    _pet = _pet.copyWith(
      name: _animalCtrl.text,
      info: _descCtrl.text,
      age: .tryParse(_ageCtrl.text),
      price: .tryParse(_priceCtrl.text),
    );

    if (_pet.id == -1) {
      await Repo.insert(.http(host, 'api/pets'), _pet);
    } else {
      await Repo.update(.http(host, 'api/pets/${_pet.id}'), _pet);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _onClearOrDelete() async {
    if (_pet.id == -1) {
      _animalCtrl.clear();
      _descCtrl.clear();
      _ageCtrl.clear();
      _priceCtrl.clear();
    } else {
      await Repo.delete(.http(host, 'api/pets/${_pet.id}'));

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
