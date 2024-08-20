const member = require("../models/member");

const getAllMembers = () => {
  try {
    return member.getMembers();
  } catch (error) {
    throw error;
  }
};

const getAllMember = (memberId) => {
  try {
    return member.getMember(memberId);
  } catch (error) {
    throw error;
  }
};

module.exports = { getAllMembers, getAllMember };
