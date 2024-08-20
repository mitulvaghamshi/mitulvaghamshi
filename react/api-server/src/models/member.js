const DB = require("../database/json/db.json");

/**
 * @openapi
 * components:
 *   schemas:
 *     member:
 *       type: object
 *       properties:
 *         id:
 *           type: string
 *           example: "12a410bc-849f-4e7e-bfc8-4ef283ee4b19"
 *         name:
 *           type: string
 *           example: "Jason Miller"
 *         gender:
 *           type: string
 *           example: "male"
 *         dateOfBirth:
 *           type: string
 *           example: "23/04/1990"
 *         email:
 *           type: string
 *           example: "jason@mail.com"
 *         password:
 *           type: string
 *           example: "666349420ec497c1dc890c45179d44fb13220239325172af02d1fb6635922956"
 */
const getMembers = () => {
  try {
    const members = DB.members;
    if (members) return members;
  } catch (error) {
    throw {
      status: error?.status || 500,
      message: error?.message || error,
    };
  }
};

const getMember = (memberId) => {
  try {
    const member = DB.members.find((menubar) => menubar.id === memberId);
    if (member) return member;
    throw {
      status: 400,
      massage: `Can't find member with the id '${memberId}'`,
    };
  } catch (error) {
    throw {
      status: error?.status || 500,
      message: error?.message || error,
    };
  }
};

module.exports = { getMembers, getMember };
