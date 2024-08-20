import 'package:warrior/utils/utils.dart';
import 'package:warrior/warrior/elf.dart';
import 'package:warrior/warrior/humanoid.dart';

class Human extends Humanoid {
  Human({
    required super.name,
    super.dexterity,
    super.strength,
    super.armour,
    super.moxie,
    super.coins,
    super.health,
    Elf? enemy,
  }) : enemy = enemy ?? Elf(name: Warrior.name);

  final Elf enemy;

  @override
  String toString() => '${super.toString()} [ENEMY: ${enemy.name}]';
}
