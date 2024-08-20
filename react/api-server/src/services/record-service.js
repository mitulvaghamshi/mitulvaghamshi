const record = require("../models/record");

const getRecordForWorkout = (workoutId) => {
  try {
    return record.getRecordForWorkout(workoutId);
  } catch (error) {
    throw error;
  }
};

module.exports = { getRecordForWorkout };
