import 'dart:io';

import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/fighter.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';
import 'package:fake_world/warrior/wizard.dart';
import 'package:test/test.dart';

void main() {
  final w = Warriors();

  setUp(() {
    stdout.writeAll([
      '\nTwo Hobbits arrived:\n${w.hobbit1}\n${w.hobbit2}',
      '\nTwo Elves arrived:\n${w.elf1}\n${w.elf2}',
      '\nTwo Humans arrived:\n${w.human1}\n${w.human2}',
      '\nTwo Fighters arrived:\n${w.fighter1}\n${w.fighter2}',
      '\nTwo Wizards arrived:\n${w.wizard1}\n${w.wizard2}',
    ]);
  });

  tearDown(() => print('Test war completed...'));

  test('FakeWorld test...', () {
    print('\n${w.elf2.name} attacks ${w.human2.name}!\n');
    w.elf2.attack(w.human2);
    print(w.human2);

    print('\n${w.hobbit1.name} steals from ${w.human2.name}!\n');
    w.hobbit1.stealFrom(w.human2);
    print('${w.hobbit1}\n${w.human2}');

    print('\n${w.elf2.name} changes his best friend!\n');
    w.elf2.friend = w.hobbit2;
    print(w.elf2);

    print('\n${w.fighter1.name} attacks ${w.hobbit1.name}!\n');
    w.fighter1.attack(w.hobbit1);
    print(w.hobbit1);

    print('\n${w.wizard1.name} heals ${w.hobbit1.name}!\n');
    w.wizard1.heal(w.hobbit1);
    print('${w.wizard1}\n${w.hobbit1}');

    print('\n${w.fighter1.name} attacks itself!\n${w.fighter1}');
    w.fighter1.attack(w.fighter1);
    print(w.fighter1);
  });
}

interface class Warriors {
  late final hobbit1 = Hobbit(name: 'Frodo');
  late final hobbit2 = Hobbit(
    name: 'Samwise',
    dexterity: 8,
    strength: 12,
    armour: 2,
    moxie: 14,
    coins: 10,
    health: 30,
  );

  late final elf1 = Elf(name: 'Legolas');
  late final elf2 = Elf(
    name: 'Elrond',
    dexterity: 14,
    strength: 20,
    armour: 18,
    moxie: 12,
    coins: 1000,
    health: 80,
    clan: 'Forest',
    friend: hobbit1,
  );

  late final human1 = Human(name: 'Aragorn');
  late final human2 = Human(
    name: 'Wormtongue',
    dexterity: 100,
    strength: 12,
    armour: 2,
    moxie: 16,
    coins: 100,
    health: 50,
    enemy: elf2,
  );

  late final fighter1 = Fighter(name: 'Boromir');
  late final fighter2 = Fighter(
    name: 'Faramir',
    dexterity: 18,
    strength: 15,
    armour: 3,
    moxie: 8,
    coins: 150,
    health: 55,
    enemy: elf1,
  );

  late final wizard1 = Wizard(name: 'Gandalf');
  late final wizard2 = Wizard(
    name: 'Saruman',
    dexterity: 8,
    strength: 12,
    armour: 4,
    moxie: 15,
    coins: 2500,
    health: 90,
    enemy: elf1,
    magicRating: 20,
  );
}
