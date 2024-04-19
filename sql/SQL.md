```sql
-- SQL QUERIES

-- Use MyDB database
USE MyDB;

-- SQL SELECT

PRINT 'SELECT 1 - Show the tables exist'
SELECT
    SUBSTRING(TABLE_CATALOG, 1, 20) [Database],
    SUBSTRING(TABLE_NAME, 1, 20)    [Table]
FROM INFORMATION_SCHEMA.TABLES;

PRINT 'SELECT 2 - Show that the tables have the correct columns'
SELECT
    SUBSTRING(TABLE_NAME, 1, 20)    [Table],
    SUBSTRING(COLUMN_NAME, 1, 20)   [Column],
    ORDINAL_POSITION                [Pos],
    SUBSTRING(DATA_TYPE, 1, 20)     [Type],
    CHARACTER_MAXIMUM_LENGTH        [Length]
FROM INFORMATION_SCHEMA.COLUMNS;

PRINT 'SELECT 3 - Show that all the constraints (PK, CK and FK) were set up properly'
SELECT
    SUBSTRING(TC.TABLE_NAME, 1, 15)      [Table],
    SUBSTRING(CCU.COLUMN_NAME, 1, 20)    [Column],
    SUBSTRING(TC.CONSTRAINT_NAME, 1, 35) [Constraint],
    SUBSTRING(TC.CONSTRAINT_TYPE, 1, 11) [Type],
    COALESCE(
        SUBSTRING(CC.CHECK_CLAUSE, 1, 75),
        SUBSTRING(KCU.TABLE_NAME, 1 , 15) + '(' +
        SUBSTRING(KCU.COLUMN_NAME, 1, 20) + ')',
        'Missing'
    ) [Constraint Details]
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
LEFT JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CCU
    ON TC.CONSTRAINT_NAME = CCU.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS CC
    ON TC.CONSTRAINT_NAME = CC.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
    ON TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
ORDER BY [Table], [Constraint] DESC;


-- SQL JOIN

--(1) GROUP - 1, SELECT - A
PRINT 'GROUP - 1, SELECT - A';
SELECT COUNT(*) 'child patients (age < 18)'
FROM patients
WHERE FLOOR(DATEDIFF(DAY, birth_date, GETDATE()) / 365.25) < 18;

--(2) GROUP - 1, SELECT - C
PRINT 'GROUP - 1, SELECT - C';
SELECT first_name, last_name, patient_height
FROM patients
WHERE gender = 'F' AND patient_height >= (
    SELECT MAX(patient_height)
    FROM patients
    WHERE gender = 'F'
);

--(3) GROUP - 2, SELECT - C
PRINT 'GROUP - 2, SELECT - C';
SELECT province_id, COUNT(*) 'patients'
FROM patients
WHERE province_id NOT IN ('ON')
GROUP BY province_id;

--(4) GROUP - 2, SELECT - D
PRINT 'GROUP - 2, SELECT - D';
SELECT gender, COUNT(*) 'patients'
FROM patients
WHERE patient_height > 175
GROUP BY gender;

--(5) GROUP - 3, SELECT - A
PRINT 'GROUP - 3, SELECT - A';
SELECT p.patient_id, p.first_name, p.last_name, a.room, a.bed
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.nursing_unit_id IN (
    SELECT nursing_unit_id
    FROM nursing_units
    WHERE nursing_unit_id = '2SOUTH'
) AND a.discharge_date IS NULL
ORDER BY p.last_name;

--(6) GROUP - 3, SELECT - D
PRINT 'GROUP - 3, SELECT - D';
SELECT d.department_id, d.department_name, d.manager_first_name,
       d.manager_last_name, p.purchase_order_id, p.total_amount
FROM departments d
JOIN purchase_orders p ON d.department_id = p.department_id
WHERE p.total_amount >= 1500
ORDER BY d.department_id;

--(7) GROUP - 4, SELECT - A
PRINT 'GROUP - 4, SELECT - A';
SELECT h.physician_id, h.first_name, h.last_name, h.specialty
FROM physicians h
JOIN encounters e   ON h.physician_id   = e.physician_id
JOIN patients p     ON e.patient_id     = p.patient_id
WHERE p.first_name = 'Harry' AND p.last_name = 'Sullivan';

--(8) GROUP - 4, SELECT - B
PRINT 'GROUP - 4, SELECT - B';
SELECT p.patient_id, p.first_name, p.last_name,
       a.nursing_unit_id, a.primary_diagnosis
FROM patients p
JOIN admissions a       ON p.patient_id             = a.patient_id
JOIN physicians h       ON a.attending_physician_id = h.physician_id
WHERE a.discharge_date IS NULL AND h.specialty = 'Internist';

--(9) GROUP - 5, SELECT - B
PRINT 'GROUP - 5, SELECT - B';
SELECT p.first_name + ' ' + p.last_name 'patient',
       a.nursing_unit_id, a.room, m.medication_description
FROM unit_dose_orders o
JOIN admissions a   ON o.patient_id     = a.patient_id
JOIN patients p     ON o.patient_id     = p.patient_id
JOIN medications m  ON o.medication_id  = m.medication_id
WHERE a.discharge_date IS NULL AND p.allergies = 'Penicillin';

--(10) GROUP - 6, SELECT - B
PRINT 'GROUP - 6, SELECT - B';
SELECT o.purchase_order_id, o.order_date, o.department_id
FROM purchase_orders o
WHERE NOT EXISTS (
    SELECT l.purchase_order_id
    FROM purchase_order_lines l
    WHERE l.purchase_order_id = o.purchase_order_id
);


-- SQL PROCEDURES

-- Setting NOCOUNT ON suppresses completion messages for each INSERT
SET NOCOUNT ON

-- Set date format to year, month, day
SET DATEFORMAT ymd;

-- Make the master database the current database
USE master

-- If database MyDB exists, drop it
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'MyDB')
    DROP DATABASE MyDB;
GO

-- Create the MyDB database
CREATE DATABASE MyDB;
GO

-- Make the MyDB database the current database
USE MyDB;

-- Create database_services table
CREATE TABLE database_services (
    service_id          INT             PRIMARY KEY,
    service_description VARCHAR(30),
    service_type        CHAR(1)         CHECK (service_type IN ('A', 'C', 'S')),
    hourly_rate         MONEY,
    sales_ytd           MONEY
);

-- Create sales table
CREATE TABLE sales (
    sales_id    INT     PRIMARY KEY,
    sales_date  DATE,
    amount      MONEY   CHECK (amount >= 0),
    service_id  INT     FOREIGN KEY REFERENCES database_services(service_id));
GO

-- Insert database_services records
INSERT INTO database_services VALUES(101, 'Crashlytics',            'A',  89, 560);
INSERT INTO database_services VALUES(102, 'Cloud Storage',          'S', 107, 350);
INSERT INTO database_services VALUES(103, 'Realtime Database',      'C', 129, 425);
INSERT INTO database_services VALUES(104, 'Hosting',                'S', 100, 465);
INSERT INTO database_services VALUES(105, 'Performance Monitoring', 'A',  70, 525);

-- Insert sales records
INSERT INTO sales VALUES(1,  '2020-8-7',    150, 101);
INSERT INTO sales VALUES(2,  '2020-8-8',    120, 102);
INSERT INTO sales VALUES(3,  '2020-8-11',   230, 104);
INSERT INTO sales VALUES(4,  '2020-8-15',   300, 101);
INSERT INTO sales VALUES(5,  '2020-8-2',     90, 103);
INSERT INTO sales VALUES(6,  '2020-9-5',    110, 101);
INSERT INTO sales VALUES(7,  '2020-9-10',   125, 105);
INSERT INTO sales VALUES(8,  '2020-9-16',   220, 105);
INSERT INTO sales VALUES(9,  '2020-9-23',   150, 102);
INSERT INTO sales VALUES(10, '2020-10-6',    85, 103);
INSERT INTO sales VALUES(11, '2020-10-14',  140, 104);
INSERT INTO sales VALUES(12, '2020-10-28',   95, 104);
INSERT INTO sales VALUES(13, '2020-11-10',   80, 102);
INSERT INTO sales VALUES(14, '2020-11-21',  180, 105);
INSERT INTO sales VALUES(15, '2020-11-30',  250, 103);
GO

-- Create an unique index on service_description on database_services table
CREATE UNIQUE INDEX IX_database_services_service_description
ON database_services (service_description ASC);
GO

-- Create a view for most expensive services
CREATE VIEW high_end_services AS SELECT
    SUBSTRING(service_description, 1, 15) AS descriptions, sales_ytd
FROM database_services WHERE hourly_rate > (
    SELECT AVG(hourly_rate) FROM database_services
);
GO

-- Verify inserts
CREATE TABLE verify (table_name varchar(30), actual INT, expected INT);
GO

-- Populate verification table
INSERT INTO verify VALUES('database_services', (SELECT COUNT(*) FROM database_services), 5);
INSERT INTO verify VALUES('sales', (SELECT COUNT(*) FROM sales), 15);

-- Print verification data
PRINT 'Verification';
SELECT table_name, actual, expected, expected - actual discrepancy FROM verify;
DROP TABLE verify;
GO

-- Alter master table to add new column
ALTER TABLE database_services ADD last_activity_date DATE NULL;
GO

-- Update database_services records
UPDATE database_services SET last_activity_date = '2019-07-25' WHERE service_id = 101;
UPDATE database_services SET last_activity_date = '2020-12-31' WHERE service_id = 102;
UPDATE database_services SET last_activity_date = '2020-06-15' WHERE service_id = 103;
UPDATE database_services SET last_activity_date = '2019-01-23' WHERE service_id = 104;
UPDATE database_services SET last_activity_date = '2020-03-16' WHERE service_id = 105;
GO

-- Insert a new record into master table
INSERT INTO database_services VALUES(106, 'Authentication', 'S', 99, 480, '2015-05-01');
GO

-- Create a stored procedure
-- if update = 1 delete record(s), if update = 0 show record(s) that would be deleted
CREATE PROCEDURE purge_database_services @cut_off_date DATE, @update INT = 0 AS BEGIN
IF @update = 1
    DELETE FROM database_services WHERE last_activity_date < @cut_off_date;
ELSE
    PRINT 'Record(s) that would be deleted';
    SELECT * FROM database_services WHERE last_activity_date < @cut_off_date;
END
GO

-- Verification
PRINT 'Verify procedure';

-- SELECT all rows and columns from the master table
PRINT 'Master Table Before Changes'
SELECT * FROM database_services;

--Execute procedure passing a date 3 years ago from today
PRINT 'After 1st Call To Procedure'
EXEC purge_database_services @cut_off_date = '2017-01-01';

-- SELECT all rows and columns from the master table
PRINT 'Master Table After 1st Call'
SELECT * FROM database_services;

-- Execute procedure passing a date 3 years ago from today and 1 for @Update
PRINT 'After 2nd Call To Procedure'
EXEC purge_database_services @cut_off_date = '2017-01-01', @update = 1;

-- SELECT all rows and columns from the master table
PRINT 'Master Table After 2nd Call'
SELECT * FROM database_services;
GO


-- SQL TRIGGERS

-- Setting NOCOUNT ON suppresses completion messages for each INSERT
SET NOCOUNT ON

-- Set date format to year, month, day
SET DATEFORMAT ymd;

-- Make the master database the current database
USE master

-- If database MyDB exists, drop it
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'MyDB')
    DROP DATABASE MyDB;
GO

-- Create the MyDB database
CREATE DATABASE MyDB;
GO

-- Make the MyDB database the current database
USE MyDB;

-- Create database_services table
CREATE TABLE database_services (
    service_id INT PRIMARY KEY,
    service_description VARCHAR(30),
    service_type CHAR(1) CHECK (service_type IN ('A', 'C', 'S')),
    hourly_rate MONEY,
    sales_ytd MONEY
);

-- Create sales table
CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    sales_date DATE,
    amount MONEY CHECK (amount >= 0),
    service_id INT FOREIGN KEY REFERENCES database_services(service_id)
);
GO

-- Insert database_services records
INSERT INTO database_services VALUES(101, 'Crashlytics',            'A',  89, 560);
INSERT INTO database_services VALUES(102, 'Cloud Storage',          'S', 107, 350);
INSERT INTO database_services VALUES(103, 'Realtime Database',      'C', 129, 425);
INSERT INTO database_services VALUES(104, 'Hosting',                'S', 100, 465);
INSERT INTO database_services VALUES(105, 'Performance Monitoring', 'A',  70, 525);

-- Insert sales records
INSERT INTO sales VALUES(1,  '2020-8-7',   150, 101);
INSERT INTO sales VALUES(2,  '2020-8-8',   120, 102);
INSERT INTO sales VALUES(3,  '2020-8-11',  230, 104);
INSERT INTO sales VALUES(4,  '2020-8-15',  300, 101);
INSERT INTO sales VALUES(5,  '2020-8-2',    90, 103);
INSERT INTO sales VALUES(6,  '2020-9-5',   110, 101);
INSERT INTO sales VALUES(7,  '2020-9-10',  125, 105);
INSERT INTO sales VALUES(8,  '2020-9-16',  220, 105);
INSERT INTO sales VALUES(9,  '2020-9-23',  150, 102);
INSERT INTO sales VALUES(10, '2020-10-6',   85, 103);
INSERT INTO sales VALUES(11, '2020-10-14', 140, 104);
INSERT INTO sales VALUES(12, '2020-10-28',  95, 104);
INSERT INTO sales VALUES(13, '2020-11-10',  80, 102);
INSERT INTO sales VALUES(14, '2020-11-21', 180, 105);
INSERT INTO sales VALUES(15, '2020-11-30', 250, 103);
GO

-- Create an unique index on service_description on database_services table
CREATE UNIQUE INDEX IX_database_services_service_description
ON database_services (service_description ASC);
GO

-- Create a view for most expensive services
CREATE VIEW high_end_services AS SELECT
    SUBSTRING(service_description, 1, 15) AS descriptions, sales_ytd
FROM database_services WHERE hourly_rate > (
    SELECT AVG(hourly_rate) FROM database_services
);
GO

-- Verify inserts
CREATE TABLE verify (table_name varchar(30), actual INT, expected INT);
GO

-- Populate verification tables
INSERT INTO verify VALUES('database_services', (SELECT COUNT(*) FROM database_services), 5);
INSERT INTO verify VALUES('sales', (SELECT COUNT(*) FROM sales), 15);

-- Display verification data
PRINT 'Verification';
SELECT table_name, actual, expected, expected - actual discrepancy FROM verify;
DROP TABLE verify;
GO

-- Create an INSERT trigger for each row
CREATE OR ALTER TRIGGER trigger_insert ON sales FOR INSERT AS
DECLARE @service_id INT;
DECLARE @new_amount MONEY;
DECLARE MY_CURSOR CURSOR FOR

SELECT service_id, amount FROM inserted;

OPEN MY_CURSOR;
FETCH NEXT FROM MY_CURSOR INTO @service_id, @new_amount;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE database_services SET sales_ytd += @new_amount
    WHERE service_id = @service_id;
    FETCH NEXT FROM MY_CURSOR INTO @service_id, @new_amount;
END;

CLOSE MY_CURSOR;
DEALLOCATE MY_CURSOR;
GO

-- Create trigger DELETE for each row
CREATE OR ALTER TRIGGER trigger_delete ON sales FOR DELETE AS
DECLARE @service_id INT;
DECLARE @old_amount MONEY;
DECLARE MY_CURSOR CURSOR FOR

SELECT service_id, amount FROM deleted;

OPEN MY_CURSOR;
FETCH NEXT FROM MY_CURSOR INTO @service_id, @old_amount;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE database_services SET sales_ytd -= @old_amount
    WHERE service_id = @service_id;
    FETCH NEXT FROM MY_CURSOR INTO @service_id, @old_amount;
END;

CLOSE MY_CURSOR;
DEALLOCATE MY_CURSOR;
GO

-- Create an UPDATE trigger for each row
CREATE OR ALTER TRIGGER trigger_update ON sales FOR UPDATE AS
DECLARE @service_id INT;
DECLARE @new_amount MONEY;
DECLARE @old_amount MONEY;
DECLARE MY_CURSOR CURSOR FOR

SELECT i.service_id, i.amount, d.amount FROM inserted i
JOIN deleted d ON i.sales_id = d.sales_id;

OPEN MY_CURSOR;
FETCH NEXT FROM MY_CURSOR INTO @service_id, @new_amount, @old_amount;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE database_services SET sales_ytd += (@new_amount - @old_amount)
    WHERE service_id = @service_id;
    FETCH NEXT FROM MY_CURSOR INTO @service_id, @new_amount, @old_amount;
END;

CLOSE MY_CURSOR;
DEALLOCATE MY_CURSOR;
GO

-- Verification
PRINT 'Verify triggers';

-- Print master table data before insert
PRINT 'Master Table Before Changes';
SELECT * FROM database_services;

-- Insert new record into sales table (id = 16)
INSERT INTO sales VALUES(16, '2020-09-15', 100000, 103);
-- OR
-- Insert multiple (id = 16, 17)
INSERT INTO sales VALUES(16, '2020-09-15', 100000, 103), (17, '2020-11-20', 150000, 102);

-- Print master table data after insert
PRINT 'After INSERT';
SELECT * FROM database_services;

-- Delete last inserted row from sales table (id = 16)
DELETE FROM sales WHERE sales_id = 16;
-- OR
-- Delete Multiple (id = 16, 17)
DELETE FROM sales WHERE sales_id IN (16, 17);

-- Print master table data after delete
PRINT 'After DELETE';
SELECT * FROM database_services;

-- Update a row (amount) in sales table (id = 15)
UPDATE sales SET amount += 200000 WHERE sales_id = 15;
-- OR
-- Update multiple (id = 14, 15)
UPDATE sales SET amount += 200000 WHERE sales_id IN (14, 15);

-- Print master table data after update
PRINT 'After UPDATE';
SELECT * FROM database_services;
GO
```
