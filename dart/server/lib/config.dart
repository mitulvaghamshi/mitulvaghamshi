import 'package:server/pet_database.dart';
import 'package:shelf/shelf.dart';

class Config {
  const Config._({required PetDatabase database}) : _database = database;

  factory Config.fromEnv() => Config._(database: PetDatabase.open());

  final PetDatabase _database;
}

extension Utils on Config {
  Future<Response> Function(Request) get rootHandler => _database.router.call;

  Future<void> init() async => _database.init();
}
