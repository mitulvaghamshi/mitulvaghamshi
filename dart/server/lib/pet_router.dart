import 'package:server/pet_controller.dart';
import 'package:server/pet_database.dart';
import 'package:shelf_router/shelf_router.dart';

extension PetRouter on PetDatabase {
  Router get router => Router()
    // curl http://localhost:8080/api
    ..get('/api', rootHandler)
    // curl http://localhost:8080/api/pets
    ..mount('/api/pets', _petRouter.call);

  Router get _petRouter => Router()
    // curl -X GET http://localhost:8080/api/pets
    ..get('/', queryHandler)
    // curl -X GET http://localhost:8080/api/pets/1
    ..get('/<id>', selectHandler)
    // curl -X GET http://localhost:8080/api/search/term
    ..get('/search/<term>', searchHandler)
    // curl -X POST http://localhost:8080/api/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'
    ..post('/', insertHandler)
    // curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
    ..patch('/<id>', updateHandler)
    // curl -X DELETE http://localhost:8080/api/1
    ..delete('/<id>', deleteHandler);
}
