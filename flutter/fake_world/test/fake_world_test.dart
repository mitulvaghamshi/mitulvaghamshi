import 'package:fake_world/warrior/elf.dart';
import 'package:fake_world/warrior/fighter.dart';
import 'package:fake_world/warrior/hobbit.dart';
import 'package:fake_world/warrior/human.dart';
import 'package:fake_world/warrior/humanoid.dart';
import 'package:fake_world/warrior/wizard.dart';
import 'package:test/test.dart';

void main() {
  final world = FakeWorldTest();
  world.setUp();
  test('FakeWorld complete test...', () => world.test());
  world.tearDown();
}

class FakeWorldTest {
  late final Hobbit hobbit1;
  late final Hobbit hobbit2;
  late final Elf elf1;
  late final Elf elf2;
  late final Human human1;
  late final Human human2;
  late final Fighter fighter1;
  late final Fighter fighter2;
  late final Wizard wizard1;
  late final Wizard wizard2;

  void setUp() {
    print('Initializing test warriors...\n');

    hobbit1 = Hobbit(name: 'Frodo');
    hobbit2 = Hobbit(
      name: 'Samwise',
      dexterity: 8,
      strength: 12,
      armour: 2,
      moxie: 14,
      coins: 10,
      health: 30,
    );

    elf1 = Elf(name: 'Legolas');
    elf2 = Elf(
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

    human1 = Human(name: 'Aragorn');
    human2 = Human(
      name: 'Wormtongue',
      dexterity: 100,
      strength: 12,
      armour: 2,
      moxie: 16,
      coins: 100,
      health: 50,
      enemy: elf2,
    );

    fighter1 = Fighter(name: 'Boromir');
    fighter2 = Fighter(
      name: 'Faramir',
      dexterity: 18,
      strength: 15,
      armour: 3,
      moxie: 8,
      coins: 150,
      health: 55,
      enemy: elf1,
    );

    wizard1 = Wizard(name: 'Gandalf');
    wizard2 = Wizard(
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

    print('\nTwo Hobbits arrived:\n');
    print(hobbit1);
    print(hobbit2);

    print('\nTwo Elves arrived:\n');
    print(elf1);
    print(elf2);

    print('\nTwo Humans arrived:\n');
    print(human1);
    print(human2);

    print('\nTwo Fighters arrived:\n');
    print(fighter1);
    print(fighter2);

    print('\nTwo Wizards arrived:\n');
    print(wizard1);
    print(wizard2);
  }

  void test() {
    print('Starting test war...');

    print('\n${elf2.name} attacks ${human2.name}! \n');
    elf2.attack(human2);
    print(human2);

    print('\n${hobbit1.name} steals from ${human2.name}!\n');
    hobbit1.stealFrom(human2);
    print(hobbit1);
    print(human2);

    print('\n${elf2.name} changes his best friend!\n');
    elf2.becomeFriendOf(hobbit2);
    print(elf2);

    print('\n${fighter1.name} attacks ${hobbit1.name}!\n');
    fighter1.attack(hobbit1);
    print(hobbit1);

    print('\n${wizard1.name} heals ${hobbit1.name}!\n');
    wizard1.heal(hobbit1);
    print(wizard1);
    print(hobbit1);

    print('\n${fighter1.name} attacks itself!\n');
    print(fighter1);
    fighter1.attack(fighter1);
    print(fighter1);
  }

  void tearDown() => print('\nTest war completed...');
}
