const sqlite3 = require("sqlite3").verbose();
const db = new sqlite3.Database(":memory:");
const bodyParser = require("body-parser");
const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT || 3001;

// Query: curl -i http://localhost:3001/api/pets
const getAllPets = (req, res) => {
  console.log("Get all request");
  db.all(
    "SELECT rowid as id, animal, description, age, price FROM Inventory",
    (err, result) => {
      if (err) {
        res.json({ "error": "Could not get inventory" });
      } else {
        res.json(result);
      }
    },
  );
};

// Search: curl -i http://localhost:3001/api/search?term=dog
const searchPet = (req, res) => {
  console.log("Search request");
  if (req.query.term == null) {
    res.json({ status: "error", message: "search term is undefined" });
  } else {
    const term = req.query.term;
    db.all(
      `SELECT rowid as id, animal, description, age, price FROM Inventory WHERE rowid LIKE '%${term}%' OR animal LIKE '%${term}%' OR description LIKE '%${term}%' OR age LIKE '%${term}%' OR price LIKE '%${term}%'`,
      (err, result) => {
        if (err) {
          res.json({ "error": `Could not search inventory${err}` });
        } else {
          res.json(result);
        }
      },
    );
  }
};

// Query: curl -i http://localhost:3001/api/1
const getPet = (req, res) => {
  console.log("Get request");
  if (req.params.id == null) {
    res.json({ status: "error", message: "data is undefined" });
  } else {
    db.all(
      `SELECT rowid as id, animal, description, age, price FROM Inventory WHERE rowid = ${req.params.id}`,
      (err, result) => {
        if (err) {
          res.json({ "error": "Could not search inventory" });
        } else {
          res.json(result);
        }
      },
    );
  }
};

// Insert: curl -i -X POST http://localhost:3001/api -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
const insertPet = (req, res) => {
  console.log("Insert request");
  if (typeof req.body == undefined) {
    res.json({ status: "error", message: "data is undefined" });
  } else {
    const { body: { animal, description, age, price } } = req;
    db.run(
      "INSERT INTO Inventory(animal,description,age,price) VALUES (?,?,?,?)",
      [animal, description, age, price],
      (err, _) => {
        if (err) {
          res.json({ "error": "Could not insert animal" });
        } else {
          res.json({ "status": "Add animal successful" });
        }
      },
    );
  }
};

// Update: curl -i -X PATCH http://localhost:3001/api/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
const updatePet = (req, res) => {
  console.log("Update request");
  if (typeof req.body == undefined || req.params.id == null) {
    res.json({ status: "error", message: "id is undefined" });
  } else {
    const { body: { animal, description, age, price } } = req;
    db.run(
      "UPDATE Inventory SET animal=(?), description=(?), age=(?), price=(?) WHERE rowid=?",
      [animal, description, age, price, parseInt(req.params.id)],
      (err, _) => {
        if (err) {
          res.json({ "error": "Could not update animal" });
        } else {
          res.json({ "status": "Update animal successful" });
        }
      },
    );
  }
};

// Delete: curl -i -X DELETE http://localhost:3001/api/1
const deletePet = (req, res) => {
  console.log("Delete request");
  if (req.params.id == null) {
    res.json({ status: "error", message: "data is undefined" });
  } else {
    db.run(
      "DELETE FROM Inventory WHERE rowid=?",
      [parseInt(req.params.id)],
      (err, _) => {
        if (err) {
          res.json({ "error": "Could not delete animal" });
        } else {
          res.json({ "status": "Delete animal successful" });
        }
      },
    );
  }
};

(() => {
  db.serialize(() => {
    db.run("DROP TABLE IF EXISTS Inventory");
    db.run(
      "CREATE TABLE Inventory (animal TEXT, description TEXT, age INTEGER, price REAL)",
    );
    const stmt = db.prepare("INSERT INTO Inventory VALUES (?,?,?,?)");
    stmt.run("Dog", "Wags tail when happy", "2", "250.00");
    stmt.run("Cat", "Black colour, friendly with kids", "3", "50.00");
    stmt.run("Love Bird", "Blue with some yellow", "2", "100.00");
    stmt.finalize();
  });
})();

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());
app.get("/", (_, res) => res.send("<h2>Welcome to Pet Inventory API</h2>"));
app.get("/api/pets", getAllPets);
app.get("/api/search", searchPet);
app.get("/api/:id", getPet);
app.post("/api", insertPet);
app.patch("/api/:id", updatePet);
app.delete("/api/:id", deletePet);
app.listen(PORT, () => console.log(`API listening at: http://[::1]:${PORT}`));
