const swaggerJSDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");

// Basic meta information about API
const options = {
  definition: {
    openapi: "3.0.0",
    info: { title: "Crossfit API", version: "1.0.0" },
  },
  apis: [
    "./src/v1/routes/workout-routes.js",
    "./src/database/workout.js",
  ],
};

// Docs in JSON format
const swaggerSpec = swaggerJSDoc(options);

// Setup docs
const swaggerDocs = (app, port) => {
  // route handler to visit docs
  app.use("/api/v1/docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
  app.get("/api/v1/docs.json", (req, res) => {
    res.setHeader("Content-Type", "application/json");
    res.send(swaggerSpec);
  });
  console.log(`API v1.0 docs: http://localhost:${port}/api/v1/docs`);
};

module.exports = { swaggerDocs };
