# Inventory API Server

A server app built using [Shelf](https://pub.dev/packages/shelf).

## Running with the Dart SDK

Run with the [Dart SDK](https://dart.dev/get-dart).

For in-memory database:

```shell
# Takes one argument: path-to-sql-file.
$ dart bin/server.dart inventory.sql
# OR
$ PORT=3001 SQL_PATH=inventory.sql dart run bin/server.dart
Server listening on port `<port>`
```

For database file:

```shell
# Takes two arguments: path-to-sql-file and path-to-db-file.
$ PORT=3001 dart bin/server.dart inventory.sql inventory.db
# OR
$ PORT=3001 SQL_PATH=inventory.sql DB_PATH=inventory.db dart run bin/server.dart
Server listening on port `<port>`
```

And then from a second terminal:

```shell
# GET: Root
$ curl -X GET http://localhost:8080/

# GET: Select all items
$ curl -X GET http://localhost:8080/api/pets

# GET: Select one item by id
$ curl -X GET http://localhost:8080/api/pets/1

# GET: Search by given term
$ curl -X GET http://localhost:8080/api/search/term

# POST: Insert a record
$ curl -X POST http://localhost:8080/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'

# PATCH: Update a record by given id
$ curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'

# DELETE: Delete a record by given id
$ curl -X DELETE http://localhost:8080/api/1
```

Find process by port and kill.

```shell
lsof -i tcp:8080
kill -9 <port>
```
