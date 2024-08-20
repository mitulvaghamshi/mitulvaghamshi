## SQL join operations

SQL join operations are used to combine data from two or more tables based on a related column between them.

### INNER JOIN

Returns only the rows that have matching values in both tables.
```sql
SELECT * FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id;
```

### LEFT JOIN

Returns all the rows from the left table and the matching rows from the right table. If there are no matches, the result set will contain **NULL** values.
```sql
SELECT * FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id;
```

### RIGHT JOIN

Similar to **LEFT JOIN**, but returns all the rows from the right table and the matching rows from the left table.
```sql
SELECT * FROM orders RIGHT JOIN customers ON orders.customer_id = customers.customer_id;
```

### FULL OUTER

OIN: Returns all the rows from both tables, with **NULL** values in the columns where there are no matches.
```sql
SELECT * FROM customers FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id;
```

### CROSS JOIN

Returns the Cartesian product of both tables, with each row of one table combined with each row of the other table.
```sql
SELECT * FROM customers CROSS JOIN orders;
```

### SELF JOIN

Joins a table with itself, used for comparing rows within the same table.
```sql
SELECT * FROM employees INNER JOIN employees AS managers ON employees.manager_id = managers.employee_id;
```

### EQUI-JOIN

A special type of **INNER JOIN** where the join condition is based on equality.
```sql
SELECT * FROM orders INNER JOIN customers ON orders.customer_id = customers.customer_id;
```

### NATURAL JOIN

A type of **EQUI-JOIN** where the join condition is based on all columns with the same names.
```sql
SELECT * FROM orders NATURAL JOIN customers;
```

*The examples assume two tables, `customers` and `orders`, with a common column `customer_id`.*
