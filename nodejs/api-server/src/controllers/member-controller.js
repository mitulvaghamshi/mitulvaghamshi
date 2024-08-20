const memberService = require("../services/member-service");

const getMembers = (req, res) => {
  try {
    res.send({
      status: "OK",
      data: memberService.getAllMembers(),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

const getMember = (req, res) => {
  try {
    const { params: { memberId } } = req;
    if (!memberId) {
      req.status(400).send({
        status: "FAILED",
        data: { error: "Parameter ':memberId' cannot be empty" },
      });
    }
    res.send({
      status: "OK",
      data: memberService.getAllMember(memberId),
    });
  } catch (error) {
    res.status(error?.status || 500).send({
      status: "FAILED",
      data: { error: error?.massage || error },
    });
  }
};

module.exports = { getMembers, getMember };
