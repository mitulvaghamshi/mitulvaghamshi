const express = require("express");
const v1WorkoutRouter = require("./v1/routes/workout-routes");
const { swaggerDocs: v1SwaggerDocs } = require("./v1/swagger");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => res.send("<p>Welcome to Workout API</p>\n"));

app.use(express.json());
app.use("/api/v1/workouts", v1WorkoutRouter);

app.listen(PORT, () => {
  console.log(`API listening at: http://localhost:${PORT}`);
  v1SwaggerDocs(app, PORT);
});
