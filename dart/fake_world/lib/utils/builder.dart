part of '../fake_world.dart';

extension on FakeWorld {
  /// Create a warrior with custom or random abilities.
  void _buildWarrior(WarriorType type) {
    print('Create new $type with random abilities? (y/n): ');
    final input = ArgumentError.checkNotNull(stdin.readLineSync());

    if (input.toLowerCase() == 'y') {
      _warriors.add(switch (type) {
        .elf => Elf(name: Warrior.generateName),
        .hobbit => Hobbit(name: Warrior.generateName),
        .wizard => Wizard(name: Warrior.generateName),
        .fighter => Fighter(name: Warrior.generateName),
        .human => Human(name: Warrior.generateName),
        .any => throw ArgumentError.value(type, 'WarriorType'),
      });

      return;
    }

    print('\nEnter name: ');
    final name = ArgumentError.checkNotNull(stdin.readLineSync());

    print('Enter strength: ');
    final strength = _getInputInt;

    print('Enter dexterity: ');
    final dexterity = _getInputInt;

    print('Enter armour: ');
    final armour = _getInputInt;

    print('Enter moxie: ');
    final moxie = _getInputInt;

    print('Enter coins: ');
    final coins = _getInputInt;

    print('Enter health: ');
    final health = _getInputInt;

    late final Humanoid other;

    if (type case .elf) {
      print('\nSelect your enemy (Elf): ');
      other = _chooseWarrior(.elf);
    } else if (type case .fighter || .wizard || .human) {
      print('\nSelect your friend (Hobbit): ');
      other = _chooseWarrior(.hobbit);
    }

    _warriors.add(switch (type) {
      .hobbit => Hobbit(
        name: name,
        armour: armour,
        coins: coins,
        dexterity: dexterity,
        health: health,
        moxie: moxie,
        strength: strength,
      ),
      .elf => Elf(
        name: name,
        armour: armour,
        coins: coins,
        dexterity: dexterity,
        health: health,
        moxie: moxie,
        strength: strength,
        clan: _chooseClan(),
        friend: other as Hobbit,
      ),
      .fighter => Fighter(
        name: name,
        armour: armour,
        coins: coins,
        dexterity: dexterity,
        health: health,
        moxie: moxie,
        strength: strength,
        enemy: other as Elf,
      ),
      .wizard => Wizard(
        name: name,
        armour: armour,
        coins: coins,
        dexterity: dexterity,
        health: health,
        moxie: moxie,
        strength: strength,
        enemy: other as Elf,
        magicRating: _magicRating(),
      ),
      .human => Human(
        name: name,
        armour: armour,
        coins: coins,
        dexterity: dexterity,
        health: health,
        moxie: moxie,
        strength: strength,
        enemy: other as Elf,
      ),
      .any => throw ArgumentError.value(type, 'WarriorType'),
    });
  }
}
