import 'dart:io';

import 'package:fake_world/utils/utils.dart';
import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/fighter.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';
import 'package:fake_world/warrior/wizard.dart';

class FakeWorld with FakeWorldMenu {
  final warriors = <Humanoid>[];

  void startWar() {
    print(FakeWorldMenu.gameMenu);

    int? input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > 7) {
      print('[ERROR]: Invalid input: choose between (1-7)\n');
    }
    if (input == 6) _display(warriors, true);
    if (input == 7) exit(0);

    final actions = [
      _createWarrior,
      _createAttack,
      _stealMoney,
      _healWarrior,
      _changeFriend,
    ];

    actions[input! - 1]();
  }
}

extension ExActionFakeWorld on FakeWorld {
  /// Create new warrior.
  /// by default all the warrior allowed to attack and defend
  /// and some of them are also have unique capabilities
  void _createWarrior() {
    print(FakeWorldMenu.warriorMenu);
    int? input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > 5) {
      print('[ERROR]: Invalid input: choose between (1-5)\n');
    }
    _buildWarrior(WarriorType.values[input! - 1]);
    _display(warriors, true);
  }

  /// Create an attack between two warrior.
  /// Defender will lose health, while attacker doesn't gain anything.
  void _createAttack() {
    final attacker = _chooseWarrior(WarriorType.any);
    final opponent = _chooseWarrior(WarriorType.any);
    attacker.attack(opponent);
    print(opponent);
  }

  /// Hobbits can steal money from others.
  /// warrior will gain some coins, while other loses.
  void _stealMoney() {
    final hobbit = _chooseWarrior(WarriorType.hobbit) as Hobbit;
    final other = _chooseWarrior(WarriorType.any);
    hobbit.stealFrom(other);
    print(hobbit);
    print(other);
  }

  /// Wizards are capable of healing other warrior.
  /// Dead warrior can become alive by the healing.
  /// warrior will gain some health, while Wizard lose some of healing power.
  void _healWarrior() {
    final wizard = _chooseWarrior(WarriorType.wizard) as Wizard;
    final other = _chooseWarrior(WarriorType.any);
    wizard.heal(other);
    print(wizard);
    print(other);
  }

  /// Elf can change its friend.
  /// Elf only allowed to choose Hobbit as a friend.
  void _changeFriend() {
    final elf = _chooseWarrior(WarriorType.elf) as Elf;
    final hobbit = _chooseWarrior(WarriorType.hobbit) as Hobbit;
    elf.becomeFriendOf(hobbit);
    print(elf);
  }

  /// Display all warrior and its available capabilities.
  void _display(List<Humanoid> warriors, bool detailed) {
    for (var item in warriors.indexed) {
      final content = StringBuffer(item.$1 + 1);
      content.write('. ');
      final warrior = item.$2;
      if (detailed) {
        content.write(warrior);
      } else {
        content.write(warrior.name);
        content.write(' [');
        content.write(warrior.isAlive ? 'ALIVE' : 'DEAD');
        content.write(' ');
        content.write(warrior.runtimeType);
        content.write(' ]');
      }
      print(content);
    }
  }
}

extension UtilsFakeWorld on FakeWorld {
  /// Get healing power for Wizard.
  int _magicRating() {
    print("Enter magic rating: ");
    int? input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 0) {
      print('[ERROR]: Invalid input: ratings cannot be negative');
    }
    return input!;
  }

  /// Choose a residence for Elf.
  String _chooseClan() {
    print("\nSelect clan: \n");
    print("1. City\n");
    print("2. Forest\n");

    int? input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > 2) {
      print('[ERROR]: Invalid input: choose (1 or 2)');
    }
    return getResidence(input! == 1);
  }

  /// Choose a warrior if available or create new in some cases.
  Humanoid _chooseWarrior(WarriorType type) {
    var items = switch (type) {
      WarriorType.any => warriors,
      WarriorType.hobbit ||
      WarriorType.elf ||
      WarriorType.wizard =>
        warriors.where((w) => w is Hobbit || w is Elf || w is Wizard).toList(),
      _ => throw UnimplementedError(),
    };

    if (items.isEmpty) {
      print("\nNo $type found, we will create one for you");

      final warrior = switch (type) {
        WarriorType.elf => Elf(name: Warrior.name),
        WarriorType.hobbit => Hobbit(name: Warrior.name),
        WarriorType.wizard => Wizard(name: Warrior.name),
        _ => throw FormatException('Invalid warrior: $type'),
      };

      items.add(warrior);
      warriors.add(warrior);
    }

    _display(items, false);
    print('\nSelect $type: ');

    int? input = int.tryParse(stdin.readLineSync() ?? '');
    if (input == null || input < 1 || input > 5) {
      print('[ERROR]: Invalid input: choose between (1-5)\n');
    }
    return items[input! - 1];
  }

  /// Create a warrior with custom or random abilities.
  void _buildWarrior(WarriorType type) {
    print("Create new $type with random abilities? (y/n): ");

    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print('[ERROR]: Invalid input: enter (y or n)\n');
    }

    if (input!.toLowerCase() == 'y') {
      warriors.add(switch (type) {
        WarriorType.elf => Elf(name: Warrior.name),
        WarriorType.hobbit => Hobbit(name: Warrior.name),
        WarriorType.wizard => Wizard(name: Warrior.name),
        WarriorType.fighter => Fighter(name: Warrior.name),
        WarriorType.human => Human(name: Warrior.name),
        _ => throw UnimplementedError(),
      });
      return;
    }

    print("\nEnter name: ");
    final name = stdin.readLineSync();
    if (name == null || name.isEmpty) {
      print('[ERROR]: Invalid input: enter a valid name\n');
    }

    print("Enter strength: ");
    int? strength = int.tryParse(stdin.readLineSync() ?? '');
    if (strength == null || strength < 0) {
      print('[ERROR]: Invalid input: enter valid strength value\n');
    }

    print("Enter dexterity: ");
    int? dexterity = int.tryParse(stdin.readLineSync() ?? '');
    if (dexterity == null || dexterity < 0) {
      print('[ERROR]: Invalid input: enter valid dexterity value\n');
    }

    print("Enter armour: ");
    int? armour = int.tryParse(stdin.readLineSync() ?? '');
    if (armour == null || armour < 0) {
      print('[ERROR]: Invalid input: enter valid armour value\n');
    }

    print("Enter moxie: ");
    int? moxie = int.tryParse(stdin.readLineSync() ?? '');
    if (moxie == null || moxie < 0) {
      print('[ERROR]: Invalid input: enter valid moxie value\n');
    }

    print("Enter coins: ");
    int? coins = int.tryParse(stdin.readLineSync() ?? '');
    if (coins == null || coins < 0) {
      print('[ERROR]: Invalid input: enter valid coin value\n');
    }

    print("Enter health: ");
    int? health = int.tryParse(stdin.readLineSync() ?? '');
    if (health == null || health < 0) {
      print('[ERROR]: Invalid input: enter valid health value\n');
    }

    Humanoid? other;
    switch (type) {
      case WarriorType.elf:
        print('\nSelect your Elf enemy: ');
        other = _chooseWarrior(type);
        break;
      case WarriorType.fighter || WarriorType.wizard || WarriorType.human:
        print('\nSelect your Hobbit friend: ');
        other = _chooseWarrior(WarriorType.hobbit);
        break;
      case WarriorType.hobbit:
      case WarriorType.any:
        other = null;
    }

    final warrior = switch (type) {
      WarriorType.hobbit => Hobbit(
          name: name!,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
        ),
      WarriorType.elf => Elf(
          name: name!,
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
          name: name!,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
          enemy: other as Elf,
        ),
      WarriorType.wizard => Wizard(
          name: name!,
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
          name: name!,
          armour: armour,
          coins: coins,
          dexterity: dexterity,
          health: health,
          moxie: moxie,
          strength: strength,
          enemy: other as Elf,
        ),
      WarriorType.any => null,
    };
    if (warrior != null) warriors.add(warrior);
  }
}

mixin FakeWorldMenu {
  static const gameMenu = '''
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

  static const warriorMenu = '''
All warrior - can attack and defend
--------------------------------------------
1. Hobbits - can steal money
2. Elves   - can have a patron or be a rival
3. Fighter - can double attack
4. Wizard  - can heal
5. Human   - easy life
--------------------------------------------
Select warrior type: ''';
}
