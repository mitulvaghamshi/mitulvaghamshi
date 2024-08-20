-- 1: Create Table
CREATE TABLE IF NOT EXISTS Inventory (
  animal      TEXT,
  description TEXT,
  age         INTEGER,
  price       REAL
);

-- 2: Select All
SELECT rowid AS id, animal, description, age, price
FROM   Inventory;

-- 3: Select by id
SELECT rowid AS id, animal, description, age, price
FROM   Inventory
WHERE  rowid = (:id);

-- 4 Search
SELECT rowid AS id, animal, description, age, price
FROM   Inventory
WHERE  animal LIKE '%' || (:q) || '%'
OR     description LIKE '%' || (:q) || '%'
OR     age LIKE '%' || (:q) || '%'
OR     price LIKE '%' || (:q) || '%';

-- 5 Insert
INSERT INTO Inventory (animal, description, age, price)
VALUES      (:animal, :desc, :age, :price);

-- 6 Update
UPDATE Inventory
SET    animal = (:animal), description = (:desc), age = (:age), price = (:price)
WHERE  rowid = (:id);

-- 7 Delete
DELETE FROM Inventory WHERE rowid = (:id);
