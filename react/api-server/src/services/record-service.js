const record = require("../database/record");

const getRecordForWorkout = (workoutId) => {
  try {
    return record.getRecordForWorkout(workoutId);
  } catch (error) {
    throw error;
  }
};

module.exports = { getRecordForWorkout };
