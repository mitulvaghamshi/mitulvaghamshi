const DB = require("./json/db.json");

const getRecordForWorkout = (workoutId) => {
  try {
    const record = DB.records.filter((record) => record.workout === workoutId);
    if (record) return record;
    throw {
      status: 400,
      massage: `Can't find workout with the id '${workoutId}'`,
    };
  } catch (error) {
    throw {
      status: error?.status || 500,
      message: error?.message || error,
    };
  }
};

module.exports = { getRecordForWorkout };
