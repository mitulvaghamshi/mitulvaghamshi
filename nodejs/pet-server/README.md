# Pet Inventory API Server

SQLite3 based API Server for [Pet Inventory](../pet-store/README.md) ReactJS
app.

```sh
npm install

# Runs with in-memory database.
npm run server:dev

# Runs with persisrent database.
npm run server:run
```

# API Endpoints

## ROOT

```sh
$ curl -X GET "http://localhost:3001"
$ curl -X GET "http://localhost:3001/api"
```

## CRUD

```sh
$ curl \
    -X GET "http://localhost:3001/api/pets" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
$ curl \
    -X GET "http://localhost:3001/api/pets/1" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
$ curl \
    -X GET "http://localhost:3001/api/search?term=dog" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
$ curl \
    -X POST "http://localhost:3001/api" \
    -H 'content-type: application/json' \
    -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
$ curl \
    -X PATCH "http://localhost:3001/api/1" \
    -H 'content-type: application/json' \
    -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
$ curl \
    -X DELETE "http://localhost:3001/api/1" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
```

## LOGS & DB RESET

```sh
$ curl \
    -X GET "http://localhost:3001/logs" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
$ curl \
    -X PURGE "http://localhost:3001/restore" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
```

## AUTH

```sh
$ curl \
    -X POST "http://localhost:3001/login" \
    -H 'content-type: application/json' \
    -d '{"username": "<username>", "password": "<password>"}'
$ curl \
    -X POST "http://localhost:3001/logout" \
    -H 'content-type: application/json' \
    -d '{"Authorization": "Bearer <token>"}'
```

## GLOB (404)

```sh
$ curl "http://localhost:3001/*"
```
