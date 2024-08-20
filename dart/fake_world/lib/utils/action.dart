part of '../fake_world.dart';

extension on FakeWorld {
  /// Create new warrior.
  /// By default all the warrior allowed to attack and defend
  /// and some of them are also have unique capabilities.
  void _createWarrior() {
    print(_warriorMenu);
    final input = _getInputInt;
    RangeError.checkValueInInterval(input, 1, 5);
    _buildWarrior(.values[input - 1]);
    _display(_warriors, true);
  }

  /// Create an attack between two warrior.
  /// Defender will lose health, while attacker doesn't gain anything.
  void _createAttack() {
    final attacker = _chooseWarrior(.any);
    final opponent = _chooseWarrior(.any);
    attacker.attack(opponent);
    print(opponent);
  }

  /// Hobbits can steal money from others.
  /// warrior will gain some coins, while other loses.
  void _stealMoney() {
    final hobbit = _chooseWarrior(.hobbit) as Hobbit;
    final other = _chooseWarrior(.any);
    hobbit.stealFrom(other);
    print('$hobbit\n$other');
  }

  /// Wizards are capable of healing other warrior.
  /// Dead warrior can become alive by the healing.
  /// warrior will gain some health, while Wizard lose some of healing power.
  void _healWarrior() {
    final wizard = _chooseWarrior(.wizard) as Wizard;
    final other = _chooseWarrior(.any);
    wizard.heal(other);
    print('$wizard\n$other');
  }

  /// Elf can change its friend.
  /// Elf only allowed to choose Hobbit as a friend.
  void _changeFriend() {
    final elf = _chooseWarrior(.elf) as Elf;
    final hobbit = _chooseWarrior(.hobbit) as Hobbit;
    elf.friend = hobbit;
    print(elf);
  }

  /// Display all warrior and its available capabilities.
  void _display(List<Humanoid> warriors, bool detailed) {
    final content = StringBuffer();

    if (detailed) {
      for (final (index, warrior) in warriors.indexed) {
        content.write('${index + 1}. $warrior');
      }
    }

    for (final (index, warrior) in warriors.indexed) {
      content.writeln(
        '${index + 1}. ${warrior.name} '
        '[${warrior.isAlive ? 'ALIVE' : 'DEAD'} '
        '${warrior.runtimeType}]',
      );
    }

    print(content);
  }
}
