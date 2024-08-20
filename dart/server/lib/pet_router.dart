import 'package:server/pet_controller.dart';
import 'package:server/pet_statements.dart';
import 'package:shelf_router/shelf_router.dart';

extension PetRouter on PetStatements {
  Router get petRouter =>
      Router()
        // curl -X GET http://localhost:8080/pets
        ..get('/', queryHandler)
        // curl -X GET http://localhost:8080/pets/1
        ..get('/<id>', selectHandler)
        // curl -X GET http://localhost:8080/search/term
        ..get('/search/<term>', searchHandler)
        // curl -X POST http://localhost:8080/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'
        ..post('/', insertHandler)
        // curl -X PATCH http://localhost:8080/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
        ..patch('/<id>', updateHandler)
        // curl -X DELETE http://localhost:8080/1
        ..delete('/<id>', deleteHandler);
}
