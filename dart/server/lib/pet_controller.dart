import 'dart:convert';

import 'package:server/pet_service.dart';
import 'package:server/pet_statements.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

extension PetController on PetStatements {
  Response queryHandler(Request request) => Response.ok(jsonEncode(selectAll));

  Response selectHandler(Request request) {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest();
    return Response.ok(jsonEncode(selectBy(id)));
  }

  Response searchHandler(Request request) {
    final term = request.params['term'];
    if (term == null) return Response.badRequest();
    return Response.ok(jsonEncode(search(term)));
  }

  Future<Response> insertHandler(Request request) async {
    final body = await request.readAsString();
    if (jsonDecode(body) case {
      'animal': String animal,
      'description': String desc,
      'age': int age,
      'price': num price,
    }) {
      insert(animal: animal, desc: desc, age: age, price: price.toDouble());
      return Response.ok(0);
    }
    return Response.badRequest();
  }

  Future<Response> updateHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest();
    final body = await request.readAsString();
    if (jsonDecode(body) case {
      'animal': String animal,
      'description': String desc,
      'age': int age,
      'price': num price,
    }) {
      update(
        id: id,
        animal: animal,
        desc: desc,
        age: age,
        price: price.toDouble(),
      );
      return Response.ok(0);
    }
    return Response.badRequest();
  }

  Future<Response> deleteHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return Response.badRequest();
    delete(id);
    return Response.ok(0);
  }
}
