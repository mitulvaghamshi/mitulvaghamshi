import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

Future<void> main() async {
  const dbPath = String.fromEnvironment('DB_PATH');
  final db = DatabaseConfig(
    inMemory: dbPath.isEmpty,
    database: dbPath.isEmpty ? sqlite3.openInMemory() : sqlite3.open(dbPath),
  );

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(db.rootRouter.call);

  final ip = InternetAddress.loopbackIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  print('Server listening on port ${server.port}...');
}

class DatabaseConfig {
  DatabaseConfig({required this.inMemory, required this.database}) {
    createTable();
    fillTestData();
  }

  final bool inMemory;
  final Database database;

  Router get rootRouter => _rootRouter;
}

extension on DatabaseConfig {
  void createTable() {
    if (!inMemory) return;
    database.execute('''
      CREATE TABLE IF NOT EXISTS Inventory (
        animal TEXT, description TEXT, age INTEGER, price REAL
      );
    ''');
  }

  void fillTestData() {
    if (!inMemory) return;
    final stmt = database.prepare('''
      INSERT INTO Inventory (animal, description, age, price)
      VALUES (?, ?, ?, ?);
    ''');
    stmt.execute(['Dog', 'Wags tail when happy', '2', '250.00']);
    stmt.execute(['Cat', 'Black colour, friendly with kids', '3', '50.00']);
    stmt.execute(['Love Bird', 'Blue with some yellow', '2', '100.00']);
  }
}

extension on DatabaseConfig {
  Router get _rootRouter => Router()
    // curl http://localhost:8080/api
    ..get('/api', (_) async {
      return Response.ok(
        '<h2>Pet API v1.0</h2>\n',
        headers: {HttpHeaders.contentTypeHeader: ContentType.html.value},
      );
    })
    // curl http://localhost:8080/api/pets
    ..mount('/api/pets', _petRouter.call);

  Router get _petRouter => Router()
    // curl -X GET http://localhost:8080/api/pets
    ..get('/', (Request request) async {
      final result = database.select('''
        SELECT rowid AS id, animal, description, age, price
        FROM   Inventory;
      ''');

      return Response.ok(
        jsonEncode(result),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
      );
    })
    // curl -X GET http://localhost:8080/api/pets/1
    ..get('/<id>', (Request request) {
      if (request.params case {'id': String id}) {
        final result = database.select(
          '''
          SELECT rowid AS id, animal, description, age, price
          FROM   Inventory
          WHERE  rowid = (?);
          ''',
          [id],
        );
        return Response.ok(
          jsonEncode(result),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        );
      }
      return Response.badRequest();
    })
    // curl -X GET http://localhost:8080/api/search/term
    ..get('/search/<term>', (Request request) {
      if (request.params case {'term': String term}) {
        final result = database.select(
          '''
          SELECT rowid AS id, animal, description, age, price
          FROM   Inventory
          WHERE  animal LIKE '%' || (?) || '%'
          OR     description LIKE '%' || (?) || '%'
          OR     age LIKE '%' || (?) || '%'
          OR     price LIKE '%' || (?) || '%';
          ''',
          [term],
        );
        return Response.ok(
          jsonEncode(result),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        );
      }
      return Response.badRequest();
    })
    // curl -X POST http://localhost:8080/api/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'
    ..post('/', (Request request) async {
      final body = await request.readAsString();
      if (jsonDecode(body) case {
        'animal': String animal,
        'description': String desc,
        'age': int age,
        'price': num price,
      }) {
        database.execute(
          '''
          INSERT INTO Inventory (animal, description, age, price)
          VALUES (?, ?, ?, ?);
          ''',
          [animal, desc, age, price],
        );
        return Response.ok(
          jsonEncode({'status': 'Insert Successful!'}),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        );
      }
      return Response.badRequest();
    })
    // curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
    ..patch('/<id>', (Request request) async {
      if (request.params case {'id': String id}) {
        final body = await request.readAsString();
        if (jsonDecode(body) case {
          'animal': String animal,
          'description': String desc,
          'age': int age,
          'price': num price,
        }) {
          database.execute(
            '''
            UPDATE Inventory
            SET    animal = (?), description = (?), age = (?), price = (?)
            WHERE  rowid  = (?);
            ''',
            [animal, desc, age, price, id],
          );
          return Response.ok(
            jsonEncode({'status': 'Update Successful!'}),
            headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
          );
        }
      }
      return Response.badRequest();
    })
    // curl -X DELETE http://localhost:8080/api/1
    ..delete('/<id>', (Request request) async {
      if (request.params case {'id': String id}) {
        database.execute(
          '''
          DELETE FROM Inventory
          WHERE rowid = (?);
          ''',
          [id],
        );
        return Response.ok(
          jsonEncode({'status': 'Delete Successful!'}),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        );
      }
      return Response.badRequest();
    });
}
