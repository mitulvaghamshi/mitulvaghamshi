import 'package:fake_world/warrior/humanoid.dart';

class Hobbit extends Humanoid {
  Hobbit({
    required super.name,
    super.dexterity,
    super.strength,
    super.armour,
    super.moxie,
    super.coins,
    super.health,
  });
}

extension Utils on Hobbit {
  /// Hobbit can steal money from other `Humanoid`s `Hobbit`s.
  /// Only alive Hobbits can steal, and stealing from itself is not allowed.
  void stealFrom(Humanoid other) {
    if (!isAlive || this == other) return;

    final coins = dexterity / 2; // calculate coins to steal.
    other.reduceCoins(coins.toInt()); // decrease coins of other Humanoid.
    increaseCoins(coins.toInt()); // increase coins of this Hobbit.
  }
}
