# ALX Airbnb Database - Advanced Scripts: Joins

This directory contains SQL scripts demonstrating advanced querying techniques for the ALX Airbnb Database project.

## `joins_queries.sql`

This script provides examples of different types of SQL `JOIN` clauses to retrieve and combine data from multiple tables in the Airbnb database.

### 1. INNER JOIN Query

-   **Objective:** To retrieve a list of all bookings along with the details of the user who made each booking.
-   **Description:** This query uses an `INNER JOIN` to link the `bookings` table with the `users` table on the `guest_id` and `user_id` fields. The result only includes records where a booking has a corresponding user.

### 2. LEFT JOIN Query

-   **Objective:** To list all properties and any reviews they have received.
-   **Description:** This query uses a `LEFT JOIN` to start with the `properties` table and connect it to the `reviews` table. This ensures that **all** properties are included in the result set, even those that have not yet received any reviews. For properties without reviews, the review-related columns will be `NULL`.

### 3. FULL OUTER JOIN Emulation (for MySQL)

-   **Objective:** To retrieve a complete list of all users and all bookings, showing all possible connections.
-   **Description:** This query demonstrates how to simulate a `FULL OUTER JOIN` in MySQL, which does not natively support this feature. It combines a `LEFT JOIN` and a `RIGHT JOIN` using `UNION`. The result includes:
    -   Users who have made bookings.
    -   Users who have **never** made a booking.
    -   Bookings that may not be linked to a user (useful for data integrity checks).
-   **Note:** The standard `FULL OUTER JOIN` syntax, which works in databases like PostgreSQL, is also included as a commented-out example for reference.

## Task 1: Practice Subqueries (`1-subqueries.sql`)

This script provides examples of both non-correlated and correlated subqueries.

-   **Non-Correlated Subquery:** Finds all properties with an average rating greater than 4.0. The inner query runs once.
-   **Correlated Subquery:** Finds all users who have made more than 3 bookings. The inner query runs once for each user, making it dependent on the outer query.

## Task 2: Aggregations and Window Functions (`2-aggregations_and_window_functions.sql`)

This script demonstrates data analysis using aggregation and window functions.

-   **Aggregation (`COUNT` / `GROUP BY`):** Calculates the total number of bookings for each user, providing a summary of user activity.
-   **Window Functions (`RANK` / `ROW_NUMBER`):** Ranks properties based on their total booking count. This is useful for identifying the most popular properties. `RANK()` is used to handle ties gracefully.

## Task 3: Implement Indexes for Optimization

This task focuses on improving query performance by creating indexes.
- **`3-database_index.sql`**: Contains `CREATE INDEX` commands and `EXPLAIN ANALYZE` queries to measure performance.
- **`3-index_performance.md`**: A report explaining the performance impact of indexing.

---

## Task 5: Partitioning Large Tables

This task addresses performance on large datasets by implementing table partitioning.
- **`5-partitioning.sql`**: Contains the SQL commands to modify the `bookings` table's primary key and apply `RANGE` partitioning by date.
- **`5-partition_performance.md`**: A report explaining how partition pruning dramatically improves date-range query performance.