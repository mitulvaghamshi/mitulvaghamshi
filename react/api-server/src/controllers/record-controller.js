const recordService = require("../services/record-service");

const getRecordForWorkout = (req, res) => {
  try {
    const { params: { workoutId } } = req;
    if (!workoutId) {
      req.status(400).send({
        status: "FAILED",
        data: { error: "Parameter ':workoutId' cannot be empty" },
      });
    }
    res.send({
      status: "OK",
      data: recordService.getRecordForWorkout(workoutId),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

module.exports = { getRecordForWorkout };
