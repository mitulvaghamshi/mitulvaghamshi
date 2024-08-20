import { writeFile } from "fs";

const saveToDatabase = async (db) => {
  await writeFile(
    "./src/database/json/db.json",
    JSON.stringify(db, null, 2),
    {
      encoding: "utf-8",
    },
  );
};

export default { saveToDatabase };
