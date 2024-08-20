import 'package:fake_world/fake_world.dart';
import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/humanoid.dart';

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
  }) : enemy = enemy ?? Elf(name: Warrior.generateName);

  final Elf enemy;

  @override
  String toString() => '${super.toString()} | ENM: ${enemy.name}';
}
