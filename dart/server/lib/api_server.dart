import 'dart:convert';

import 'package:server/inventory_db.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class APIServer {
  const APIServer._({required this.router, required this.database});

  factory APIServer.inMemory({required String sqlPath}) => APIServer._(
      router: Router(), database: InventoryDB.inMemory(sqlPath: sqlPath));

  factory APIServer.file({required List<String> args}) =>
      APIServer._(router: Router(), database: InventoryDB.file(args: args));

  final Router router;
  final InventoryDB database;
}

extension ServerAppExt on APIServer {
  // Configure routes.
  void configureRoutes() => router
    ..get('/', _rootHandler)
    ..get('/api/pets', _getAllHandler)
    ..get('/api/pets/<id>', _getByHandler)
    ..get('/api/search/<term>', _searchHandler)
    ..post('/api', _insertHandler)
    ..patch('/api/<id>', _updateHandler)
    ..delete('/api/<id>', _deleteHandler);

  // Create Inventory table, and compile prepared-statements.
  Future<void> prepareStatements() async {
    database.createTable('Inventory');
    await database.prepareStatements();
  }
}

extension on APIServer {
  /// curl http://localhost:8080/
  Response _rootHandler(Request request) =>
      Response.ok('<h2>Welcome to Pet Inventory API v1.0</h2>\n');

  /// curl http://localhost:8080/api/pets
  Response _getAllHandler(Request request) =>
      Response.ok(jsonEncode(database.getAll));

  /// curl http://localhost:8080/api/pets/1
  Response _getByHandler(Request request) {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest(body: 'Invalid request\n');
    final result = database.getBy(id);
    return Response.ok(jsonEncode(result));
  }

  /// curl http://localhost:8080/api/search/term
  Response _searchHandler(Request request) {
    final term = request.params['term'];
    if (term == null) return Response.badRequest(body: 'Invalid request\n');
    final result = database.search(term);
    return Response.ok(jsonEncode(result));
  }

  /// curl -X POST http://localhost:8080/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'
  Future<Response> _insertHandler(Request request) async {
    final body = await request.readAsString();
    if (jsonDecode(body)
        case {
          'animal': String animal,
          'description': String desc,
          'age': int age,
          'price': num price,
        }) {
      database.insert(animal, desc, age, price.toDouble());
      return Response.ok('Inserted successfully');
    }
    return Response.badRequest(body: 'Invalid request body');
  }

  /// curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
  Future<Response> _updateHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest(body: 'Invalid request');
    final body = await request.readAsString();
    if (jsonDecode(body)
        case {
          'animal': String animal,
          'description': String desc,
          'age': int age,
          'price': num price,
        }) {
      database.update(id, animal, desc, age, price.toDouble());
      return Response.ok('Updated successfully');
    }
    return Response.badRequest(body: 'Invalid request body');
  }

  /// curl -X DELETE http://localhost:8080/api/1
  Future<Response> _deleteHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest(body: 'Invalid request');
    database.delete(id);
    return Response.ok('Deleted successfully');
  }
}
