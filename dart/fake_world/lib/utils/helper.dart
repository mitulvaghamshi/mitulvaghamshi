part of '../fake_world.dart';

extension on FakeWorld {
  /// Get integer from stdin, repeat on invalid or negative value.
  int get _getInputInt {
    int result = 0;
    do {
      final input = stdin.readLineSync();
      if (input == null) continue;
      if (int.tryParse(input) case int value) {
        result = value;
      }
    } while (result <= 0);
    return result;
  }

  /// Get healing power for Wizard.
  int _magicRating() {
    print('Enter magic rating: ');
    return _getInputInt;
  }

  /// Choose a residence for Elf.
  String _chooseClan() {
    print('\nSelect clan:\n1. City\n2. Forest\n');
    final input = RangeError.checkValueInInterval(_getInputInt, 1, 2);
    return getResidence(preferCity: input == 1);
  }

  /// Choose a warrior if available or create new in some cases.
  Humanoid _chooseWarrior(WarriorType type) {
    late final List<Humanoid> items;

    if (type case .any) {
      items = _warriors;
    } else if (type case .hobbit || .elf || .wizard) {
      items = _warriors
          .where((w) => w is Hobbit || w is Elf || w is Wizard)
          .toList();
    } else {
      throw ArgumentError.value(type, 'WarriorType');
    }

    if (items.isEmpty) {
      print('\nNo $type found, we will create one for you.');

      final warrior = switch (type) {
        .elf => Elf(name: Warrior.generateName),
        .hobbit => Hobbit(name: Warrior.generateName),
        .wizard => Wizard(name: Warrior.generateName),
        _ => throw ArgumentError.value(type, 'WarriorType'),
      };

      items.add(warrior);
      _warriors.add(warrior);
    }

    _display(items, false);

    print('\nSelect $type: ');
    final input = RangeError.checkValueInInterval(_getInputInt, 1, 5);
    return items[input - 1];
  }
}
