import 'dart:math' as math;

import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';

final _rnd = math.Random();

class Wizard extends Human {
  Wizard({
    required super.name,
    super.dexterity,
    super.strength,
    super.armour,
    super.moxie,
    super.coins,
    super.health,
    super.enemy,
    int? magicRating,
  }) : _magicRating = magicRating ?? _rnd.nextInt(21);

  int _magicRating;

  @override
  String toString() => '${super.toString()} | MGC: $_magicRating';
}

extension Utils on Wizard {
  /// A Wizard can heal other `Humanoid`s by increasing its `health` value.
  /// Wizard will lose 3 points after each successful heal.
  /// Wizard can heal only if it is alive and has healing power > 0.
  /// Wizard cannot heal itself.
  void heal(Humanoid other) {
    if (!isAlive || _magicRating <= 0 || this == other) return;

    other.increaseHealth(_magicRating ~/ 2);
    _magicRating = math.max(_magicRating - 3, 0);
  }
}
