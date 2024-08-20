# Inventory Store and API Server

## Running app

```sh
# Assuming the api server is listening on same machine at port 8080.
$ flutter run -d macos --dart-define HOST=localhost:8080
```

## Running server

## For in-memory (dev, debug)

```sh
$ PORT=3001 dart bin/server.dart
$ Server listening on port 3001...
```

## With persistent db file

```sh
$ dart -DDB_PATH=db.sqlite bin/server.dart
$ Server listening on port 8080...
```

## Test endpoints

```sh
# GET: /
$ curl -X GET http://localhost:8080 -H 'accept: application/json'

# GET: /pets
$ curl -X GET http://localhost:8080/pets -H 'accept: application/json'

# GET: /pets/{id}
$ curl -X GET http://localhost:8080/pets/1 -H 'accept: application/json'

# GET: /search/{term}
$ curl -X GET http://localhost:8080/search/term -H 'accept: application/json'

# POST: /
$ curl -X POST http://localhost:8080 -H 'content-type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'

# PATCH: /{id}
$ curl -X PATCH http://localhost:8080/1 -H 'content-type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'

# DELETE: /{id}
$ curl -X DELETE http://localhost:8080/1 -H 'accept: application/json'
```
