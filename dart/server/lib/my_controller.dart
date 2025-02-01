import 'dart:convert';

import 'package:server/my_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class MyController {
  const MyController({required this.setvice});

  final MyService setvice;
}

extension Utils on MyController {
  /// curl http://localhost:8080/
  Response rootHandler(Request request) =>
      Response.ok('<h2>Welcome to Pet Inventory API v1.0</h2>\n');

  /// curl http://localhost:8080/api/pets
  Response queryHandler(Request request) =>
      Response.ok(jsonEncode(setvice.query));

  /// curl http://localhost:8080/api/pets/1
  Response selectHandler(Request request) {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest(body: 'Invalid request\n');
    final result = setvice.selectBy(id);
    return Response.ok(jsonEncode(result));
  }

  /// curl http://localhost:8080/api/search/term
  Response searchHandler(Request request) {
    final term = request.params['term'];
    if (term == null) return Response.badRequest(body: 'Invalid request\n');
    final result = setvice.search(term);
    return Response.ok(jsonEncode(result));
  }

  /// curl -X POST http://localhost:8080/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'
  Future<Response> insertHandler(Request request) async {
    final body = await request.readAsString();
    if (jsonDecode(body)
        case {
          'animal': String animal,
          'description': String desc,
          'age': int age,
          'price': num price,
        }) {
      setvice.insert(animal, desc, age, price.toDouble());
      return Response.ok('Inserted successfully');
    }
    return Response.badRequest(body: 'Invalid request body');
  }

  /// curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
  Future<Response> updateHandler(Request request) async {
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
      setvice.update(id, animal, desc, age, price.toDouble());
      return Response.ok('Updated successfully');
    }
    return Response.badRequest(body: 'Invalid request body');
  }

  /// curl -X DELETE http://localhost:8080/api/1
  Future<Response> deleteHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest(body: 'Invalid request');
    setvice.delete(id);
    return Response.ok('Deleted successfully');
  }
}
