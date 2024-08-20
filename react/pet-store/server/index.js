const sqlite3 = require("sqlite3").verbose();
const db = new sqlite3.Database(":memory:");
const bodyParser = require("body-parser");
const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT || 3001;

// curl http://localhost:3001/api/pets
const getAllPets = (req, res) => {
  console.log("Get all request: /api/pets");
  db.all(
    "SELECT rowid as id, animal, description, age, price FROM Inventory;",
    (err, result) => handler(res, err, result),
  );
};

// curl http://localhost:3001/api/1
const getPet = ({ params: { id } }, res) => {
  console.log("Get request: /api/1");
  if (id == null) return res.json({ "ERROR": "Something went wrong" });
  db.get(
    `SELECT rowid as id, animal, description, age, price FROM Inventory WHERE rowid = ${id};`,
    (err, result) => handler(res, err, result),
  );
};

// curl http://localhost:3001/api/search?term=dog
const searchPet = ({ query: { term } }, res) => {
  console.log(`Search request: /api/search?term=${term}`);
  if (term == null) return res.json({ "ERROR": "Something went wrong" });
  db.all(
    `SELECT rowid as id, animal, description, age, price FROM Inventory WHERE rowid LIKE '%${term}%' OR animal LIKE '%${term}%' OR description LIKE '%${term}%' OR age LIKE '%${term}%' OR price LIKE '%${term}%';`,
    (err, result) => handler(res, err, result),
  );
};

// curl -X POST http://localhost:3001/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
const insertPet = (req, res) => {
  console.log("Insert request: /api");
  const { body: { animal, description, age, price } } = req;
  if (typeof animal == undefined) {
    return res.json({ "ERROR": "Something went wrong" });
  }
  db.run(
    "INSERT INTO Inventory(animal,description,age,price) VALUES (?,?,?,?)",
    [animal, description, age, price],
    (err) => handler(res, err),
  );
};

// curl -X PATCH http://localhost:3001/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
const updatePet = (req, res) => {
  console.log("Update request: /api/1");
  const { body: { animal, description, age, price }, params: { id } } = req;
  if (typeof animal == undefined || id == null) {
    return res.json({ "ERROR": "Something went wrong" });
  }
  db.run(
    "UPDATE Inventory SET animal=(?), description=(?), age=(?), price=(?) WHERE rowid=?",
    [animal, description, age, price, parseInt(id)],
    (err) => handler(res, err),
  );
};

// curl -X DELETE http://localhost:3001/api/1
const deletePet = ({ params: { id } }, res) => {
  console.log("Delete request: /api/1");
  if (id == null) return res.json({ "ERROR": "Something went wrong" });
  db.run(
    "DELETE FROM Inventory WHERE rowid=?",
    [parseInt(id)],
    (err) => handler(res, err),
  );
};

function handler(res, error, result) {
  if (error) return res.json({ "ERROR": "Something went wrong" });
  if (result) return res.json(result);
  return res.json({ "OK": "Request complete" });
}

db.serialize(() => {
  db.run("DROP TABLE IF EXISTS Inventory;");
  db.run(
    "CREATE TABLE Inventory (animal TEXT, description TEXT, age INTEGER, price REAL);",
  );
  const stmt = db.prepare("INSERT INTO Inventory VALUES (?,?,?,?);");
  stmt.run("Dog", "Wags tail when happy", "2", "250.00");
  stmt.run("Cat", "Black colour, friendly with kids", "3", "50.00");
  stmt.run("Love Bird", "Blue with some yellow", "2", "100.00");
  stmt.finalize();
});

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());

app.get("/", (_, res) => res.send("<h2>Welcome to Pet Inventory API</h2>\n"));
app.get("/api/pets", getAllPets);
app.get("/api/search", searchPet);
app.get("/api/:id", getPet);
app.post("/api", insertPet);
app.patch("/api/:id", updatePet);
app.delete("/api/:id", deletePet);

app.listen(PORT, () => console.log(`API Server listening at: ${PORT}`));
