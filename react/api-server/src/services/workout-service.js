const { v4: uuid } = require("uuid");
const workout = require("../database/workout");

const getAllWorkouts = (filterParams) => {
  try {
    return workout.getAllWorkouts(filterParams);
  } catch (error) {
    throw error;
  }
};

const getWorkout = (workoutId) => {
  try {
    return workout.getWorkout(workoutId);
  } catch (error) {
    throw error;
  }
};

const createWorkout = (newWorkout) => {
  const timestamp = new Date().toLocaleString("en-US", { timeZone: "UTC" });
  const workoutToInsert = {
    ...newWorkout,
    id: uuid(),
    createdAt: timestamp,
    updatedAt: timestamp,
  };
  try {
    return workout.createWorkout(workoutToInsert);
  } catch (error) {
    throw error;
  }
};

const updateWorkout = (workoutId, changes) => {
  try {
    return workout.updateWorkout(workoutId, changes);
  } catch (error) {
    throw error;
  }
};

const deleteWorkout = (workoutId) => {
  try {
    workout.deleteWorkout(workoutId);
  } catch (error) {
    throw error;
  }
};

module.exports = {
  getAllWorkouts,
  getWorkout,
  createWorkout,
  updateWorkout,
  deleteWorkout,
};
