PRAGMA foreign_keys=OFF;

BEGIN TRANSACTION;

CREATE TABLE Inventory (
    animal TEXT,
    description TEXT,
    age Number,
    price REAL
);

INSERT INTO Inventory VALUES('Dog','Wags tail when happy',2,250.0);
INSERT INTO Inventory VALUES('Cat','Black colour, friendly with kids',3,50.0);
INSERT INTO Inventory VALUES('Love Bird','Blue with some yellow',2,100.0);

COMMIT;
