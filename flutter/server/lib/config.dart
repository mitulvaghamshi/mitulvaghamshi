import 'dart:async';

import 'package:server/pet_database.dart';
import 'package:server/pet_router.dart';
import 'package:shelf/shelf.dart';

class Config {
  const Config._({required PetDatabase db}) : _db = db;

  factory Config.fromEnv() {
    const dbPath = String.fromEnvironment('DB_PATH');
    const sqlPath = String.fromEnvironment('PET_SQL_PATH');
    assert(sqlPath.isNotEmpty, 'Sql file missing');

    return Config._(
      db: .open(dbPath: dbPath, sqlPath: sqlPath),
    );
  }

  final PetDatabase _db;
}

extension Utils on Config {
  Future<Response> Function(Request) get apiHandler => _db.router.call;

  Future<void> init() async {
    _db.createTable();
    await _db.prepareStatements();
    _db.fillTestData();
  }
}
