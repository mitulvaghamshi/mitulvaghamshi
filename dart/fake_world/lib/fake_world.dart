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

class FakeWorld {
  final _warriors = <Humanoid>[];
}

extension Utils on FakeWorld {
  void startWar() {
    print(_gameMenu);

    void _ = switch (_getInputInt) {
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

const _gameMenu = '''
------------------------
| 1 | Create new Warrior
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
| 1. | Hobbit  | Steal money from others.
| 2. | Elves   | Have friend or enemy.
| 3. | Fighter | Ability to double attack.
| 4. | Wizard  | Ability to heal the damage.
| 5. | Human   | Enjoy easy life!
---------------------------------------------
* All warriors can attack and defend.
---------------------------------------------
Select warrior type (1-5): ''';
