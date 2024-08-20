import 'dart:io';

import 'package:fake_world/utils/utils.dart';
import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/fighter.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';
import 'package:fake_world/warrior/wizard.dart';

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

interface class FakeWorld {
  final List<Humanoid> _warriors = [];
}

extension Utils on FakeWorld {
  void startWar() {
    print(_gameMenu);
    void _ = switch (_inputInt) {
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
    var input = _inputInt;
    RangeError.checkValueInInterval(input, 1, 5);
    _buildWarrior(WarriorType.values[input - 1]);
    _display(_warriors, true);
  }

  /// Create an attack between two warrior.
  /// Defender will lose health, while attacker doesn't gain anything.
  void _createAttack() {
    var attacker = _chooseWarrior(WarriorType.any);
    var opponent = _chooseWarrior(WarriorType.any);
    attacker.attack(opponent);
    print(opponent);
  }

  /// Hobbits can steal money from others.
  /// warrior will gain some coins, while other loses.
  void _stealMoney() {
    var hobbit = _chooseWarrior(WarriorType.hobbit) as Hobbit;
    var other = _chooseWarrior(WarriorType.any);
    hobbit.stealFrom(other);
    print('$hobbit\n$other');
  }

  /// Wizards are capable of healing other warrior.
  /// Dead warrior can become alive by the healing.
  /// warrior will gain some health, while Wizard lose some of healing power.
  void _healWarrior() {
    var wizard = _chooseWarrior(WarriorType.wizard) as Wizard;
    var other = _chooseWarrior(WarriorType.any);
    wizard.heal(other);
    print('$wizard\n$other');
  }

  /// Elf can change its friend.
  /// Elf only allowed to choose Hobbit as a friend.
  void _changeFriend() {
    var elf = _chooseWarrior(WarriorType.elf) as Elf;
    var hobbit = _chooseWarrior(WarriorType.hobbit) as Hobbit;
    elf.becomeFriendOf(hobbit);
    print(elf);
  }

  /// Display all warrior and its available capabilities.
  void _display(List<Humanoid> warriors, bool detailed) {
    var content = StringBuffer();
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
  int get _inputInt {
    var input = ArgumentError.checkNotNull(stdin.readLineSync());
    var value = ArgumentError.checkNotNull(int.tryParse(input));
    return RangeError.checkNotNegative(value);
  }

  /// Get healing power for Wizard.
  int _magicRating() {
    print('Enter magic rating: ');
    return _inputInt;
  }

  /// Choose a residence for Elf.
  String _chooseClan() {
    print('\nSelect clan:\n1. City\n2. Forest\n');
    var choice = _inputInt;
    RangeError.checkValueInInterval(choice, 1, 2);
    return getResidence(choice == 1);
  }

  /// Choose a warrior if available or create new in some cases.
  Humanoid _chooseWarrior(WarriorType type) {
    var items = switch (type) {
      WarriorType.any => _warriors,
      WarriorType.hobbit ||
      WarriorType.elf ||
      WarriorType.wizard =>
        _warriors.where((w) => w is Hobbit || w is Elf || w is Wizard).toList(),
      _ => throw ArgumentError.value(type, 'WarriorType'),
    };
    if (items.isEmpty) {
      print('\nNo $type found, we will create one for you.');
      var warrior = switch (type) {
        WarriorType.elf => Elf(name: Warrior.name),
        WarriorType.hobbit => Hobbit(name: Warrior.name),
        WarriorType.wizard => Wizard(name: Warrior.name),
        _ => throw ArgumentError.value(type, 'WarriorType'),
      };
      items.add(warrior);
      _warriors.add(warrior);
    }
    _display(items, false);
    print('\nSelect $type: ');
    var input = _inputInt;
    RangeError.checkValueInInterval(input, 1, 5);
    return items[input - 1];
  }
}

extension on FakeWorld {
  /// Create a warrior with custom or random abilities.
  void _buildWarrior(WarriorType type) {
    print('Create new $type with random abilities? (y/n): ');
    var input = ArgumentError.checkNotNull(stdin.readLineSync());
    if (input.toLowerCase() == 'y') {
      _warriors.add(switch (type) {
        WarriorType.elf => Elf(name: Warrior.name),
        WarriorType.hobbit => Hobbit(name: Warrior.name),
        WarriorType.wizard => Wizard(name: Warrior.name),
        WarriorType.fighter => Fighter(name: Warrior.name),
        WarriorType.human => Human(name: Warrior.name),
        WarriorType.any => throw ArgumentError.value(type, 'WarriorType'),
      });
      return;
    }

    print('\nEnter name: ');
    final name = ArgumentError.checkNotNull(stdin.readLineSync());

    print('Enter strength: ');
    final strength = _inputInt;

    print('Enter dexterity: ');
    final dexterity = _inputInt;

    print('Enter armour: ');
    final armour = _inputInt;

    print('Enter moxie: ');
    final moxie = _inputInt;

    print('Enter coins: ');
    final coins = _inputInt;

    print('Enter health: ');
    final health = _inputInt;

    Humanoid? other;
    switch (type) {
      case WarriorType.hobbit || WarriorType.any:
        break;
      case WarriorType.elf:
        print('\nSelect your Elf enemy: ');
        other = _chooseWarrior(WarriorType.elf);
        break;
      case WarriorType.fighter || WarriorType.wizard || WarriorType.human:
        print('\nSelect your Hobbit friend: ');
        other = _chooseWarrior(WarriorType.hobbit);
    }

    _warriors.add(switch (type) {
      WarriorType.hobbit => Hobbit(
          name: name,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
        ),
      WarriorType.elf => Elf(
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
      WarriorType.fighter => Fighter(
          name: name,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
          enemy: other as Elf,
        ),
      WarriorType.wizard => Wizard(
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
      WarriorType.human => Human(
          name: name,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
          enemy: other as Elf,
        ),
      WarriorType.any => throw ArgumentError.value(type, 'WarriorType'),
    });
  }
}
