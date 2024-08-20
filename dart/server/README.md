# Inventory API Server

A server app built using [Shelf](https://pub.dev/packages/shelf).

## Running with the Dart SDK

Run with the [Dart SDK](https://dart.dev/get-dart).

For in-memory database:

```shell
# Takes one argument: path-to-sql-file.
$ dart bin/server.dart inventory.sql
Server listening on port 8080
```

For database file:

```shell
# Takes two arguments: path-to-sql-file and path-to-db-file.
$ dart bin/server.dart inventory.sql inventory.db
Server listening on port 8080
```

And then from a second terminal:

```shell
# GET: Root
$ curl http://localhost:8080/

# GET: Select all items
$ curl http://localhost:8080/api/pets

# GET: Select one item by id
$ curl http://localhost:8080/api/pets/1

# GET: Search by given term
$ curl http://localhost:8080/api/search/term

# POST: Insert a record
$ curl -X POST http://localhost:8080/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'

# PATCH: Update a record by given id
$ curl -X PATCH http://localhost:8080/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'

# DELETE: Delete a record by given id
$ curl -X DELETE http://localhost:8080/api/1
```
