import 'package:fake_world/fake_world.dart' as fake_world;

void main(List<String> arguments) {
  print('\n*** Welcome to the town of Hogsface '
      'in the magical land of Foon ***\n');

  final world = fake_world.FakeWorld();
  world.startWar();
}
