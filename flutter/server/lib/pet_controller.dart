import 'dart:convert';

import 'package:server/pet_database.dart';
import 'package:server/pet_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

extension PetController on PetDatabase {
  Response rootHandler(Request _) => .ok('<h2>Pet API v1.0</h2>\n');

  Response queryHandler(Request request) => .ok(jsonEncode(selectAll));

  Response selectHandler(Request request) {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return .badRequest();
    return .ok(jsonEncode(selectBy(id)));
  }

  Response searchHandler(Request request) {
    final term = request.params['term'];
    if (term == null) return .badRequest();
    return .ok(jsonEncode(search(term)));
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
      return .ok(jsonEncode('Record inserted successfully!'));
    }
    return .badRequest();
  }

  Future<Response> updateHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return .badRequest();
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
      return .ok(jsonEncode('Record updated successfully!'));
    }
    return .badRequest();
  }

  Future<Response> deleteHandler(Request request) async {
    final id = int.tryParse(request.params['id'].toString());
    if (id == null) return .badRequest();
    delete(id);
    return .ok(jsonEncode('Record deleted successfully!'));
  }
}
