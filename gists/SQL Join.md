## SQL join operations

SQL join is used to combine two or more tables based on related columns.

```sql
-- INNER JOIN
-- Rows that have matching values in both tables.
SELECT * FROM orders INNER JOIN customers ON orders.id = customers.id;
```

```sql
-- LEFT JOIN
-- All rows from the left and the matching rows from right table. Nullable.
SELECT * FROM customers LEFT JOIN orders ON customers.id = orders.id;
```

```sql
-- RIGHT JOIN
-- All rows from the right and the matching rows from left table. Nullable.
SELECT * FROM orders RIGHT JOIN customers ON orders.id = customers.id;
```

```sql
-- FULL OUTER JOIN
-- All rows from both tables, **NULL** for no matches.
SELECT * FROM customers FULL OUTER JOIN orders ON customers.id = orders.id;
```

```sql
-- CROSS JOIN
-- Cartesian product of both tables.
SELECT * FROM customers CROSS JOIN orders;
```

```sql
-- SELF JOIN
-- Joins a table with itself, comparing rows within the same table.
SELECT * FROM employees INNER JOIN employees AS managers ON employees.id = managers.id;
```

```sql
-- NATURAL JOIN
-- INNER JOIN where condition is based on all columns with the same names.
SELECT * FROM orders NATURAL JOIN customers;
```
