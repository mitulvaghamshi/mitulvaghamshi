const workoutService = require("../services/workout-service");

const getAllWorkouts = (req, res) => {
  try {
    const { mode } = req.query;
    res.send({
      status: "OK",
      data: workoutService.getAllWorkouts({ mode }),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

const getWorkout = (req, res) => {
  const { params: { workoutId } } = req;
  if (!workoutId) {
    req.status(400).send({
      status: "FAILED",
      data: { error: "Parameter ':workoutId' cannot be empty" },
    });
  }
  try {
    res.send({
      status: "OK",
      data: workoutService.getWorkout(workoutId),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

const createWorkout = (req, res) => {
  const { body } = req;
  if (
    !body.name || !body.mode || !body.equipment ||
    !body.exercises || !body.trainerTips
  ) {
    res.status(400).send({
      status: "FAILED",
      data: {
        error:
          "One of the following keys is missing or is empty in request body: 'name', 'mode', 'equipment', 'exercises', 'trainerTips'",
      },
    });
    return;
  }
  const newWorkout = {
    name: body.name,
    mode: body.mode,
    equipment: body.equipment,
    exercises: body.exercises,
    trainerTips: body.trainerTips,
  };
  try {
    res.status(201).send({
      status: "OK",
      data: workoutService.createWorkout(newWorkout),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

const updateWorkout = (req, res) => {
  const { body, params: { workoutId } } = req;
  if (!workoutId) {
    req.status(400).send({
      status: "FAILED",
      data: { error: "Parameter ':workoutId' cannot be empty" },
    });
  }
  try {
    res.send({
      status: "OK",
      data: workoutService.updateWorkout(workoutId, body),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

const deleteWorkout = (req, res) => {
  const { params: { workoutId } } = req;
  if (!workoutId) {
    req.status(400).send({
      status: "FAILED",
      data: { error: "Parameter ':workoutId' cannot be empty" },
    });
  }
  try {
    workoutService.deleteWorkout(workoutId);
    res.status(204).send({ status: "OK" });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

module.exports = {
  getAllWorkouts,
  getWorkout,
  createWorkout,
  updateWorkout,
  deleteWorkout,
};
