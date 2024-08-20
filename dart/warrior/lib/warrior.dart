import 'dart:io';

import 'package:warrior/utils/utils.dart';
import 'package:warrior/warrior/elf.dart';
import 'package:warrior/warrior/fighter.dart';
import 'package:warrior/warrior/hobbit.dart';
import 'package:warrior/warrior/human.dart';
import 'package:warrior/warrior/humanoid.dart';
import 'package:warrior/warrior/wizard.dart';

class FakeWorld {
  final _warriors = <Humanoid>[];
}

extension Utils on FakeWorld {
  void startWar() {
    print(_gameMenu);
    void _ = switch (_stdNextInt) {
      1 => _createWarrior(),
      2 => _createAttack(),
      3 => _stealMoney(),
      4 => _healWarrior(),
      5 => _changeFriend(),
      6 => _display(_warriors, true),
      _ => exit(0),
    };
  }
}

extension on FakeWorld {
  /// Create new warrior.
  /// By default all the warrior allowed to attack and defend
  /// and some of them are also have unique capabilities.
  void _createWarrior() {
    print(_warriorMenu);
    final input = _stdNextInt;
    RangeError.checkValueInInterval(input, 1, 5);
    _buildWarrior(.values[input - 1]);
    _display(_warriors, true);
  }

  /// Create an attack between two warrior.
  /// Defender will lose health, while attacker doesn't gain anything.
  void _createAttack() {
    final attacker = _chooseWarrior(.any);
    final opponent = _chooseWarrior(.any);
    attacker.attack(opponent);
    print(opponent);
  }

  /// Hobbits can steal money from others.
  /// warrior will gain some coins, while other loses.
  void _stealMoney() {
    final hobbit = _chooseWarrior(.hobbit) as Hobbit;
    final other = _chooseWarrior(.any);
    hobbit.stealFrom(other);
    print('$hobbit\n$other');
  }

  /// Wizards are capable of healing other warrior.
  /// Dead warrior can become alive by the healing.
  /// warrior will gain some health, while Wizard lose some of healing power.
  void _healWarrior() {
    final wizard = _chooseWarrior(.wizard) as Wizard;
    final other = _chooseWarrior(.any);
    wizard.heal(other);
    print('$wizard\n$other');
  }

  /// Elf can change its friend.
  /// Elf only allowed to choose Hobbit as a friend.
  void _changeFriend() {
    final elf = _chooseWarrior(.elf) as Elf;
    final hobbit = _chooseWarrior(.hobbit) as Hobbit;
    elf.becomeFriendOf(hobbit);
    print(elf);
  }

  /// Display all warrior and its available capabilities.
  void _display(List<Humanoid> warriors, bool detailed) {
    final content = StringBuffer();
    for (var (index, warrior) in warriors.indexed) {
      content.write('${index + 1}. ');
      if (detailed) {
        content.write(warrior);
        continue;
      }
      content.write(warrior.name);
      content.write(' [');
      content.write(warrior.isAlive ? 'ALIVE' : 'DEAD');
      content.write(' ');
      content.write(warrior.runtimeType);
      content.write(' ]\n');
    }
    print(content);
  }
}

extension on FakeWorld {
  int get _stdNextInt {
    final input = ArgumentError.checkNotNull(stdin.readLineSync());
    final value = ArgumentError.checkNotNull(int.tryParse(input));
    return RangeError.checkNotNegative(value);
  }

  /// Get healing power for Wizard.
  int _magicRating() {
    print('Enter magic rating: ');
    return _stdNextInt;
  }

  /// Choose a residence for Elf.
  String _chooseClan() {
    print('\nSelect clan:\n1. City\n2. Forest\n');
    final choice = _stdNextInt;
    RangeError.checkValueInInterval(choice, 1, 2);
    return getResidence(choice == 1);
  }

  /// Choose a warrior if available or create new in some cases.
  Humanoid _chooseWarrior(WarriorType type) {
    final items = switch (type) {
      .any => _warriors,
      .hobbit || .elf || .wizard =>
        _warriors.where((w) => w is Hobbit || w is Elf || w is Wizard).toList(),
      // _warriors.whereType<Hobbit>().whereType<Elf>().whereType<Wizard>(),
      _ => throw ArgumentError.value(type, 'WarriorType'),
    };
    if (items.isEmpty) {
      print('\nNo $type found, we will create one for you.');
      final warrior = switch (type) {
        .elf => Elf(name: Warrior.name),
        .hobbit => Hobbit(name: Warrior.name),
        .wizard => Wizard(name: Warrior.name),
        _ => throw ArgumentError.value(type, 'WarriorType'),
      };
      items.add(warrior);
      _warriors.add(warrior);
    }
    _display(items, false);
    print('\nSelect $type: ');
    final input = _stdNextInt;
    RangeError.checkValueInInterval(input, 1, 5);
    return items[input - 1];
  }
}

extension on FakeWorld {
  /// Create a warrior with custom or random abilities.
  void _buildWarrior(WarriorType type) {
    print('Create new $type with random abilities? (y/n): ');
    final input = ArgumentError.checkNotNull(stdin.readLineSync());
    if (input.toLowerCase() == 'y') {
      _warriors.add(switch (type) {
        .elf => Elf(name: Warrior.name),
        .hobbit => Hobbit(name: Warrior.name),
        .wizard => Wizard(name: Warrior.name),
        .fighter => Fighter(name: Warrior.name),
        .human => Human(name: Warrior.name),
        .any => throw ArgumentError.value(type, 'WarriorType'),
      });
      return;
    }

    print('\nEnter name: ');
    final name = ArgumentError.checkNotNull(stdin.readLineSync());

    print('Enter strength: ');
    final strength = _stdNextInt;

    print('Enter dexterity: ');
    final dexterity = _stdNextInt;

    print('Enter armour: ');
    final armour = _stdNextInt;

    print('Enter moxie: ');
    final moxie = _stdNextInt;

    print('Enter coins: ');
    final coins = _stdNextInt;

    print('Enter health: ');
    final health = _stdNextInt;

    Humanoid? other;

    switch (type) {
      case .hobbit || .any:
        break;
      case .elf:
        print('\nSelect your Elf enemy: ');
        other = _chooseWarrior(.elf);
        break;
      case .fighter || .wizard || .human:
        print('\nSelect your Hobbit friend: ');
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

const _gameMenu = '''
----------------------
1. Create new warrior
2. Start a fight
3. Steal money
4. Heal warrior
5. Change friend
6. View warrior List
7. Exit!
----------------------
Enter your choice: ''';

const _warriorMenu = '''
All warrior - can attack and defend
--------------------------------------------
1. Hobbits - can steal money
2. Elves   - can have a patron or be a rival
3. Fighter - can double attack
4. Wizard  - can heal
5. Human   - easy life
--------------------------------------------
Select warrior type: ''';
