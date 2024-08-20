import 'dart:math' as math;

import 'package:fake_world/utils/utils.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/humanoid.dart';

final _rnd = math.Random();

String getResidence([bool? preferCity]) =>
    preferCity ?? _rnd.nextBool() ? 'City' : 'Forest';

class Elf extends Humanoid {
  Elf({
    required super.name,
    super.dexterity,
    super.strength,
    super.armour,
    super.moxie,
    super.coins,
    super.health,
    String? clan,
    Hobbit? friend,
  })  : clan = clan ?? getResidence(),
        friend = friend ?? Hobbit(name: Warrior.name);

  final String clan;

  Hobbit friend;

  @override
  String toString() =>
      '${super.toString()} [CLAN: $clan FRIEND: ${friend.name}]';
}

extension ExElf on Elf {
  /// Change an existing friend.
  void becomeFriendOf(Hobbit friend) => this.friend = friend;
}
