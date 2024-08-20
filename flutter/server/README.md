# Inventory API Server

A server app built using [Shelf](https://pub.dev/packages/shelf).

## Running with the Dart SDK

Run with the [Dart SDK](https://dart.dev/get-dart).

For in-memory database:
```shell
$ dart -DPET_SQL_PATH=db/inventory.sql bin/server.dart
$ Server listening on port 8080...
```

For database file:
```shell
$ dart -DPET_SQL_PATH=db/inventory.sql -DDB_PATH=db/inventory.db bin/server.dart
$ Server listening on port 8080...
```

And then from a second terminal:

```shell
# GET: Root
$ curl -X GET http://localhost:8080

# GET: Select all items
$ curl -X GET http://localhost:8080/pets

# GET: Select one item by id
$ curl -X GET http://localhost:8080/pets/1

# GET: Search by given 'term'
$ curl -X GET http://localhost:8080/search/term

# POST: Insert a record
$ curl -X POST http://localhost:8080 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'

# PATCH: Update a record by given id
$ curl -X PATCH http://localhost:8080/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'

# DELETE: Delete a record by given id
$ curl -X DELETE http://localhost:8080/1
```

Find process by port and kill.

```sh
$ lsof -i tcp:8080
$ kill -9 pId
```
