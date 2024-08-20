const Inventory = {};

Inventory.Logger = (function () {
  // TODO(me): Save to persistent media.
  const logcat = [];
  const requestsLog = [];

  function _defaultLogger(message, isError) {
    if (isError) {
      console.error(message);
    } else {
      console.debug(message);
    }
  }

  function _logRequests(logger) {
    const _theLogger = logger ?? _defaultLogger;
    return function (req, res, next) {
      res.on("finish", function () {
        let _msg = `${new Date().toUTCString()}: ${req.method}\t${req.path}\t${res.statusCode}`;
        if (res.statusCode >= 400) {
          _msg = `[ERR]: ${_msg}`;
          requestsLog.push(_msg);
          _theLogger(_msg, true);
        } else {
          _msg = `[LOG]: ${_msg}`;
          requestsLog.push(_msg);
          _theLogger(_msg, false);
        }
      });
      return next();
    };
  }

  return {
    logRequests: _logRequests,
    write: function (message) {
      logcat.push(`${new Date().toUTCString()}: ${message}`);
    },
    logs: function () {
      this.write('Logs requested...');
      return Array.of(requestsLog, logcat);
    },
  };
})();

Inventory.Store = (function (Logger, IS_DEV) {
  const sqlite3 = require("sqlite3").verbose();
  const db = IS_DEV
    ? new sqlite3.Database(":memory:")
    : new sqlite3.Database("db.sqlite");

  function _resetDB() {
    db.serialize(function () {
      db.exec(`
        DROP TABLE IF EXISTS Inventory;
      `);
      db.exec(`
        CREATE TABLE IF NOT EXISTS Inventory (
          animal TEXT, description TEXT, age Number, price REAL
        );
      `);
      const _stmt = db.prepare("INSERT INTO Inventory VALUES (?,?,?,?);");
      _stmt.run("Dog", "Wags tail when happy", "2", "250.00");
      _stmt.run("Cat", "Black colour, friendly with kids", "3", "50.00");
      _stmt.run("Love Bird", "Blue with some yellow", "2", "100.00");
      _stmt.finalize();
    });
  }

  return {
    get instance() {
      return db;
    },
    restore: function () {
      Logger.write("Initialize Database...");
      if (IS_DEV) _resetDB();
    },
  };
})(Inventory.Logger, process.env.ISDEV || false);

Inventory.Auth = (function (Logger, DB) {
  const _crypto = require("crypto");
  const _sessions = new Map();

  function _validate(token) {
    if (_sessions.has(token)) {
      const { user_id, username, expires_at } = _sessions.get(token);
      if (expires_at > Date.now()) {
        return { status: "valid", user_id, username };
      } else {
        _sessions.delete(token);
        return { status: "expired" };
      }
    }
    return { status: "notfound" };
  }

  function _login(username, password) {
    // TODO(me): Check against database...
    if (username === "admin" && password === "admin@123") {
      // TODO(me): Use JWT insted of opaque token...
      const token = _crypto.randomBytes(32).toString("hex");
      const datetime_now_millis = Date.now();
      const expire_in_secs = 24 * 60 * 60;
      _sessions.set(token, {
        user_id: _crypto.randomUUID(),
        username: username,
        created_at: datetime_now_millis,
        expires_at: datetime_now_millis + (expire_in_secs * 1000),
      });
      return {
        access_token: token,
        token_type: "Bearer",
        expires_in: expire_in_secs,
      };
    }
    return false;
  }

  function _logout(token) {
    return _sessions.delete(token);
  }

  return {
    login: _login,
    logout: _logout,
    validate: _validate,
  };
})(Inventory.Logger, Inventory.Store);

Inventory.Router = (function (Logger, Auth, DB) {
  function _petsHandler(req, res) {
    DB.instance.all(
      `
      SELECT rowid as id, animal, description, age, price
      FROM Inventory;
      `,
      function (err, rows) {
        if (rows) {
          return res.status(200).json(rows);
        }
        if (err) {
          return res.status(404).json({
            "status": false,
            "message": err?.message ?? "An unknown error occured.",
          });
        }
        return res.status(500).json({
          "status": false,
          "message": "Internal Server Error.",
        });
      },
    );
  }

  function _petHandler(req, res) {
    const { id } = req.params;
    if (isNaN(id)) {
      return res.status(400).json({
        "status": false,
        "message": "Invalid or misiing resource id.",
      });
    }
    DB.instance.get(
      `
      SELECT rowid as id, animal, description, age, price
      FROM Inventory
      WHERE rowid = (?);
      `,
      parseInt(id),
      function (err, row) {
        if (row) {
          return res.status(200).json(row);
        }
        if (err) {
          return res.status(404).json({
            "status": false,
            "message": err?.message ?? "An unknown error occured.",
          });
        }
        return res.status(500).json({
          "status": false,
          "message": "Internal Server Error.",
        });
      },
    );
  }

  function _searchHandler(req, res) {
    const { term } = req.query;
    if (!term) {
      return res.status(400).json({
        "status": false,
        "message": "Invalid or missing search term.",
      });
    }
    DB.instance.all(
      `
      SELECT rowid as id, animal, description, age, price
      FROM  Inventory
      WHERE rowid       LIKE "%${term}%"
         OR animal      LIKE "%${term}%"
         OR description LIKE "%${term}%"
         OR age         LIKE "%${term}%"
         OR price       LIKE "%${term}%";
      `,
      function (err, rows) {
        if (rows) {
          return res.status(200).json(rows);
        }
        if (err) {
          return res.status(404).json({
            "status": false,
            "message": err?.message ?? "An unknown error occured.",
          });
        }
        return res.status(500).json({
          "status": false,
          "message": "Internal Server Error.",
        });
      },
    );
  }

  function _insertHandler(req, res) {
    const { animal, description, age, price } = req.body;
    if (!animal || !description || !age || !price) {
      return res.status(400).json({
        "status": false,
        "message": "Invalid or missing values.",
      });
    }
    DB.instance.run(
      `
      INSERT INTO Inventory (animal, description, age, price)
      VALUES (?, ?, ?, ?);
      `,
      [animal, description, age, price],
      function (err) {
        if (err) {
          return res.status(500).json({
            "status": false,
            "message": err?.message ?? "Internal Server Error.",
          });
        }
        return res.status(201).json({
          "status": true,
          "message": "Pet Inserted Successfully!",
        });
      },
    );
  }

  function _updateHandler(req, res) {
    const {
      params: { id },
      body: { animal, description, age, price },
    } = req;
    if (isNaN(id)) {
      return res.status(400).json({
        "status": false,
        "message": "Invalid or missing resource id.",
      });
    }
    DB.instance.run(
      `
      UPDATE Inventory
      SET
        animal      = (?),
        description = (?),
        age         = (?),
        price       = (?)
      WHERE rowid   = (?);
      `,
      [animal, description, age, price, parseInt(id)],
      function (err) {
        if (err) {
          return res.status(500).json({
            "status": false,
            "message": err?.message ?? "Internal Server Error!",
          });
        }
        return res.status(204).json({
          "status": true,
          "message": "Pet Updated Successfully!",
        });
      },
    );
  }

  function _deleteHandler(req, res) {
    const { id } = req.params;
    if (isNaN(id)) {
      return res.status(400).json({
        "status": false,
        "message": "Invalid or missing resource id.",
      });
    }
    DB.instance.run(
      `
      DELETE FROM Inventory
      WHERE rowid = (?);
      `,
      parseInt(id),
      function (err) {
        if (err) {
          return res.status(500).json({
            "status": false,
            "message": err?.message ?? "Internal Server Error!",
          });
        }
        return res.status(204).json({
          "status": true,
          "message": "Pet Deleted Successfully!",
        });
      },
    );
  }

  function _login(req, res) {
    const { username, password } = req.body;
    const result = Auth.login(username, password);
    if (result) {
      return res.status(200).json(result);
    }
    res.sendStatus(401);
  }

  function _logout(req, res) {
    const { authorization } = req.headers;
    const token = authorization.split(" ")[1];
    Auth.logout(token);
    return res.status(200).json({
      status: true,
      message: "You have been logged out successfully!",
    });
  }

  function _validateToken(req, res, next) {
    const { authorization } = req.headers;

    if (!authorization) {
      return res.status(401).json({
        status: false,
        message: "Invalid or missing auth headers!",
      });
    }

    if (authorization.startsWith("Basic ")) {
      const base64 = authorization.split(" ")[1];
      const values = Buffer.from(base64, "base64").toString("utf-8");
      const [username, password] = values.split(":");
      if (username === "admin" && password === "admin@123") {
        req.user = { user_id: 0, username };
        return next();
      }
      return res.sendStatus(401);
    }

    if (authorization.startsWith("Bearer ")) {
      const token = authorization.split(" ")[1];
      if (!token) {
        return res.status(401).json({
          status: false,
          message: "Invalid or missing auth token!",
        });
      }

      const { status, user_id, username } = Auth.validate(token);
      if (status === "valid") {
        req.user = { user_id, username };
        return next();
      } else if (status === "expired") {
        return res.status(401).json({
          status: false,
          message: "Session expired, please signin again!",
        });
      } else {
        Logger.write(`Unauthorized Access!!!: ${req.method}\t${req.path}`);
        return res.status(401).json({
          status: false,
          message: "Unauthorized Access!!! This incident will be reported!",
        });
      }
    }
    res.status(401).json({
      status: false,
      message: "Invalid or missing auth headers!",
    });
  }

  return {
    root: {
      path: "/",
      method: "GET",
      public: true,
      description: "Root handler.",
      handler: function (req, res) {
        res.status(200).send("<h1>Welcome to Pet Inventory API</h1>\n");
      },
      notFound: function (req, res) {
        res.status(404).format({
          text: function () {
            res.type("text/plain").send("404 Not Found!\n");
          },
          html: function () {
            res.type("text/html").send("<h1>404 Not Found!</h1>\n");
          },
          json: function () {
            res.json({
              status: false,
              message: "404 Not Found!",
            });
          },
        });
      },
    },
    pets: {
      path: "/api/pets",
      method: "GET",
      public: false,
      description: "Get all pets avaiable in inventory.",
      handler: _petsHandler,
    },
    pet: {
      path: "/api/pets/:id",
      method: "GET",
      public: false,
      description: "Get a specific pet with given ID.",
      handler: _petHandler,
    },
    search: {
      path: "/api/search",
      method: "GET",
      public: false,
      description: "Serach for a specific pet by name, price, etc.",
      handler: _searchHandler,
    },
    insert: {
      path: "/api",
      method: "POST",
      public: false,
      description: "Add a new pet to the inventory.",
      handler: _insertHandler,
    },
    update: {
      path: "/api/:id",
      method: "PATCH",
      public: false,
      description: "Update existing pet information.",
      handler: _updateHandler,
    },
    delete: {
      path: "/api/:id",
      method: "DELETE",
      public: false,
      description: "Delete pet entry from the inventory.",
      handler: _deleteHandler,
    },
    auth: {
      path: "/login | /logout",
      method: "POST | GET",
      public: "true | false",
      description: "Login/Logout requests.",
      login: _login,
      logout: _logout,
      gatekeeper: _validateToken,
    },
    misc: {
      logs: function (req, res) {
        res.status(200).json(Logger.logs());
      },
      listen: function (port) {
        Logger.write(`Server listening at: ${port}`);
        DB.restore();
      },
      restore: function (req, res) {
        DB.restore();
        res.status(201).json({
          status: true,
          message: "Database Restored Successfully!",
        });
      },
    },
  };
})(Inventory.Logger, Inventory.Auth, Inventory.Store);

Inventory.Server = (function (Logger, Router, PORT) {
  const express = require("express");
  const cors = require("cors");
  const app = express();

  app.use(express.json());
  app.use(Logger.logRequests());
  app.use(cors({ origin: "http://localhost:3000" }));

  // curl -X GET "http://localhost:3001"
  app.get("/", Router.root.handler);

  // curl -X GET "http://localhost:3001/api"
  app.get("/api", Router.root.handler);

  // curl -X GET "http://localhost:3001/api/pets" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.get("/api/pets", Router.auth.gatekeeper, Router.pets.handler);

  // curl -X GET "http://localhost:3001/api/pets/1" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.get("/api/pets/:id", Router.auth.gatekeeper, Router.pet.handler);

  // curl -X GET "http://localhost:3001/api/search?term=dog" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.get("/api/search", Router.auth.gatekeeper, Router.search.handler);

  // curl -X POST "http://localhost:3001/api" -H '"Content-Type": "application/json"' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
  app.post("/api", Router.auth.gatekeeper, Router.insert.handler);

  // curl -X PATCH "http://localhost:3001/api/1" -H '"Content-Type": "application/json"' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'
  app.patch("/api/:id", Router.auth.gatekeeper, Router.update.handler);

  // curl -X DELETE "http://localhost:3001/api/1" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.delete("/api/:id", Router.auth.gatekeeper, Router.delete.handler);

  // curl -X GET "http://localhost:3001/api/logs" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.get("/logs", Router.auth.gatekeeper, Router.misc.logs);

  // curl -X PURGE "http://localhost:3001/api" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.purge("/restore", Router.auth.gatekeeper, Router.misc.restore);

  // curl -X POST "http://localhost:3001/login" -H '"Content-Type": "application/json"' -d '{"username": "<username>", "password": "<password>"}'
  app.post("/login", Router.auth.login);

  // curl -X POST "http://localhost:3001/logout" -H '"Content-Type": "application/json"' -d '{"Authorization": "Bearer <token>"}'
  app.post("/logout", Router.auth.gatekeeper, Router.auth.logout);

  // curl "http://localhost:3001/*"
  app.all(RegExp("."), Router.root.notFound);

  app.listen(PORT, function (err) {
    if (err) {
      Logger.write(`Unable to start server: ${err?.message}`);
    } else {
      Router.misc.listen(PORT);
    }
  });

  return {
    port: PORT,
    auth: ["Basic", "Bearer"],
  };
})(Inventory.Logger, Inventory.Router, process.env.PORT || 3001);

Object.freeze(Inventory);

console.log(Inventory);
