part of '../fake_world.dart';

extension on FakeWorld {
  /// Get integer from stdin, repeat on invalid or negative value.
  int _getUserInput() {
    while (true) {
      if (int.tryParse(stdin.readLineSync() ?? "0") case int v when v > 0) {
        return v;
      }
    }
  }

  /// Get healing power for Wizard.
  int _magicRating() {
    print('Enter magic rating: ');
    return _getUserInput();
  }

  /// Choose a residence for Elf.
  String _selectClan() {
    print('\nSelect clan:\n1. City\n2. Forest\n');
    final input = RangeError.checkValueInInterval(_getUserInput(), 1, 2);
    return getResidence(preferCity: input == 1);
  }

  /// Choose a warrior if available or create new in some cases.
  Humanoid _selectWarrior(WarriorType type) {
    final friendable = switch (type) {
      .any => _warriors,
      .elf => _warriors.whereType<Elf>().toList(),
      .hobbit => _warriors.whereType<Hobbit>().toList(),
      .wizard => _warriors.whereType<Wizard>().toList(),
      _ => throw ArgumentError.value(type, 'WarriorType'),
    };
    if (friendable.isEmpty) {
      print('\nNo $type found, we will create one for you.');
      final warrior = switch (type) {
        .elf => Elf(name: Warrior.generateName),
        .hobbit => Hobbit(name: Warrior.generateName),
        .wizard => Wizard(name: Warrior.generateName),
        _ => throw ArgumentError.value(type, 'WarriorType'),
      };
      friendable.add(warrior);
      _warriors.add(warrior);
    }
    _display(friendable, showWarriorInfo: false);
    print('\nSelect $type: ');
    final input = RangeError.checkValueInInterval(_getUserInput(), 1, 5);
    return friendable[input - 1];
  }
}
