import 'dart:convert';
import 'dart:io';

import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/fighter.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';
import 'package:fake_world/warrior/wizard.dart';

part 'utils/action.dart';
part 'utils/builder.dart';
part 'utils/helper.dart';
part 'utils/warrior.dart';

final class FakeWorld {
  final _warriors = <Humanoid>[];
  static final instance = FakeWorld();
  static void startWar() => instance._startWar();
}

extension Utils on FakeWorld {
  void _startWar() {
    print('Welcome to the town of Hogsface in the magical land of Foon!');
    print(_gameMenu);

    void _ = switch (_getUserInput()) {
      1 => _create(),
      2 => _attack(),
      3 => _steal(),
      4 => _heal(),
      5 => _friend(),
      6 => _display(_warriors, showWarriorInfo: true),
      _ => exit(0),
    };
  }
}

const _gameMenu = '''
------------------------
| 1 | Create Warrior
| 2 | Start a Fight
| 3 | Steal Money
| 4 | Heal Warrior
| 5 | Change Friend
| 6 | View Warriors
| 7 | Exit Fight
------------------------

Enter your choice (1-7): ''';

const _warriorMenu = '''
---------------------------------------------
| No | Type    | Feature/Speciality
---------------------------------------------
| 1 | Hobbit  | Steal money from others.
| 2 | Elves   | Have friend or enemy.
| 3 | Fighter | Ability to double attack.
| 4 | Wizard  | Ability to heal the damage.
| 5 | Human   | Enjoy easy life!
---------------------------------------------
* All warriors can attack and defend.
---------------------------------------------

Select warrior type (1-5): ''';
