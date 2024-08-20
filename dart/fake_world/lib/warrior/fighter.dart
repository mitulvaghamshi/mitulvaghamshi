import 'package:fake_world/warrior/human.dart';

class Fighter extends Human {
  Fighter({
    required super.name,
    super.dexterity,
    super.strength,
    super.armour,
    super.moxie,
    super.coins,
    super.health,
    super.enemy,
  });
}
