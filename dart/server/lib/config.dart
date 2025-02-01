import 'dart:io';

import 'package:server/my_controller.dart';
import 'package:server/my_database.dart';
import 'package:server/my_service.dart';
import 'package:shelf_router/shelf_router.dart';

class Config {
  const Config._({
    required this.sqlPath,
    required this.dbPath,
    required this.router,
  });

  factory Config.fromArg(List<String> args) {
    final sqlPath = args.elementAtOrNull(0) ??
        Platform.environment['SQL_PATH'] ??
        String.fromEnvironment('SQL_PATH');
    final dbPath = args.elementAtOrNull(1) ??
        Platform.environment['DB_PATH'] ??
        String.fromEnvironment('DB_PATH');

    final database = dbPath.isEmpty
        ? MyDatabase.inMemory(sqlPath: sqlPath)
        : MyDatabase.fromFile(sqlPath: sqlPath, dbPath: dbPath)
      ..initialize();

    final controller = MyController(setvice: MyService(database: database));

    final router = Router()
      ..get('/', controller.rootHandler)
      ..get('/api/pets', controller.queryHandler)
      ..get('/api/pets/<id>', controller.selectHandler)
      ..get('/api/search/<term>', controller.searchHandler)
      ..post('/api', controller.insertHandler)
      ..patch('/api/<id>', controller.updateHandler)
      ..delete('/api/<id>', controller.deleteHandler);

    return Config._(sqlPath: sqlPath, dbPath: dbPath, router: router);
  }

  final String sqlPath;
  final String dbPath;
  final Router router;
}
