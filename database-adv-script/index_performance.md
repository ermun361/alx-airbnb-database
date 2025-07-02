# Performance Optimization with Indexes

This document demonstrates the process and impact of adding indexes to the Airbnb database to improve query performance.

## Methodology

The performance of a specific, common query is measured before and after adding an appropriate index. The measurement is done using the `EXPLAIN ANALYZE` command, which shows the database's execution plan and costs.

**Scenario:** Find all properties located in 'Nairobi'. This is a frequent query in an Airbnb-style application.

**Query:**
```sql
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'Nairobi';
```



## 1. Performance Before Indexing

### Execution Plan:
When run on a large `properties` table without an index on the `location` column, the database has no choice but to perform a **Full Table Scan**.

**Simulated `EXPLAIN ANALYZE` Output (Before Index):**
```
-> Filter: (properties.location = 'Nairobi')  (cost=1025.00 rows=100) (actual time=0.1...50.2 ms rows=100 loops=1)
    -> Table scan on properties  (cost=1025.00 rows=10000) (actual time=0.0...45.1 ms rows=10000 loops=1)
```

### Analysis:
-   **`Table scan on properties`**: This is the key problem. The database had to read all 10,000 rows in the table to find the 100 that matched the criteria.
-   **High Cost (`1025.00`)**: The cost represents the computational effort. This number is high because of the inefficient scan.
-   **Inefficiency**: This operation is slow and scales poorly. As the table grows to millions of rows, the query time will increase linearly.


## 2. Index Creation

To optimize this query, we create an index on the `location` column.

**SQL Command:**
```sql
CREATE INDEX idx_properties_location ON properties(location);
```


## 3. Performance After Indexing

### Execution Plan:
With the index in place, the database can now use a much more efficient **Index Seek** operation.

**Simulated `EXPLAIN ANALYZE` Output (After Index):**
```
-> Index lookup on properties using idx_properties_location (location='New York')  (cost=10.50 rows=100) (actual time=0.05...0.2 ms rows=100 loops=1)
```

### Analysis:
-   **`Index lookup on properties`**: The database used the `idx_properties_location` index to directly locate the required rows, similar to looking up a word in a book's index.
-   **Low Cost (`10.50`)**: The query cost has been dramatically reduced by nearly 99%.
-   **Efficiency**: The query is now extremely fast and will remain fast even as the table grows, because the database no longer needs to scan the entire table.

---

## Summary of Recommended Indexes

Based on common usage patterns, the following indexes are recommended to ensure overall application performance:

-   **On `users` table:**
    -   `idx_users_email`: For fast user login/lookup.
    -   `idx_users_role`: For filtering by user type.
-   **On `properties` table:**
    -   `idx_properties_user_id`: To speed up joins for finding a host's properties.
    -   `idx_properties_location`: For the most common search filter.
    -   `idx_properties_price`: For filtering and sorting by price.
-   **On `bookings` table:**
    -   `idx_bookings_guest_id` & `idx_bookings_property_id`: To optimize joins from both sides of the booking relationship.
    -   `idx_bookings_dates`: A composite index on `(start_date, end_date)` to make availability checks highly efficient.

## Conclusion

Proper indexing is not an optional tuning step; it is a fundamental requirement for a scalable and responsive database application. By identifying columns frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses and applying indexes, we can drastically reduce query execution times and server load.