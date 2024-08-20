import 'dart:math' as math;

import 'package:warrior/warrior/fighter.dart';

final _rnd = math.Random();

abstract class Humanoid {
  Humanoid({
    required this.name,
    int? dexterity,
    int? strength,
    int? armour,
    int? moxie,
    int? coins,
    int? health,
  }) : dexterity = dexterity ?? _rnd.nextInt(21),
       strength = strength ?? _rnd.nextInt(21),
       armour = armour ?? _rnd.nextInt(20) + 1,
       moxie = moxie ?? _rnd.nextInt(21),
       coins = coins ?? _rnd.nextInt(1000),
       health = health ?? _rnd.nextInt(21);

  final String name;

  int dexterity;
  int strength;
  int armour;
  int moxie;
  int coins;
  int health;

  @override
  String toString() =>
      '$name [${isAlive ? "ALIVE" : "DEAD"} $runtimeType] '
      '[STR: $strength  DEX:  $dexterity  ARM:  $armour  '
      'MOX:  $moxie] [COINS: $coins  HEALTH: $health]';
}

extension Utils on Humanoid {
  /// Check if `Humanoid` is dead or alive.
  /// Alive humanoids have `health` is greater than zero.
  bool get isAlive => health > 0;

  void increaseCoins(int coins) => this.coins += coins;

  void reduceCoins(int coins) => this.coins = math.max(this.coins - coins, 0);

  void increaseHealth(int health) => this.health += health;

  void reduceHealth(int health) =>
      this.health = math.max(this.health - health, 0);

  /// Attack any `Humanoid` except itself, only alive humanoids can attack.
  /// After successful attack, target will lose some `health` points.
  /// Attack by `Fighter` will cause double damage then regular.
  void attack(Humanoid other) {
    if (!isAlive || this == other) return;

    final powers = strength + dexterity + health;
    final damageStrength = this is Fighter ? 2 : 1;
    final damage = powers / 3 * damageStrength / other.armour;
    other.increaseHealth(-math.max(damage, 1).toInt());
  }
}
