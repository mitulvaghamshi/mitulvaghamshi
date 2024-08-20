part of '../fake_world.dart';

extension on FakeWorld {
  /// Create new warrior.
  /// By default all the warrior allowed to attack and defend
  /// and some of them are also have unique capabilities.
  void _create() {
    print(_warriorMenu);
    final input = RangeError.checkValueInInterval(_getUserInput(), 1, 5);
    _buildWarrior(.values[input - 1]);
    _display(_warriors, showWarriorInfo: true);
  }

  /// Create an attack between two warrior.
  /// Defender will lose health, while attacker doesn't gain anything.
  void _attack() {
    final attacker = _selectWarrior(.any);
    final opponent = _selectWarrior(.any);
    attacker.attack(opponent);
    print(opponent);
  }

  /// Hobbits can steal money from others.
  /// warrior will gain some coins, while other loses.
  void _steal() {
    final hobbit = _selectWarrior(.hobbit) as Hobbit;
    final other = _selectWarrior(.any);
    hobbit.stealFrom(other);
    print('$hobbit\n$other');
  }

  /// Wizards are capable of healing other warrior.
  /// Dead warrior can become alive by the healing.
  /// warrior will gain some health, while Wizard lose some of healing power.
  void _heal() {
    final wizard = _selectWarrior(.wizard) as Wizard;
    final other = _selectWarrior(.any);
    wizard.heal(other);
    print('$wizard\n$other');
  }

  /// Elf can change its friend.
  /// Elf only allowed to choose Hobbit as a friend.
  void _friend() {
    final elf = _selectWarrior(.elf) as Elf;
    final hobbit = _selectWarrior(.hobbit) as Hobbit;
    elf.friend = hobbit;
    print(elf);
  }

  /// Display all warrior and its available capabilities.
  void _display(List<Humanoid> warriors, {required bool showWarriorInfo}) {
    final content = StringBuffer();
    final map = warriors.asMap();
    if (showWarriorInfo) {
      map.forEach((i, w) => content.write('${i + 1}. $w'));
    }
    map.forEach((i, w) {
      content.writeln(
        '${i + 1}. ${w.name} [${w.isAlive ? 'ALIVE' : 'DEAD'} ${w.runtimeType}]',
      );
    });
    print(content);
  }
}
