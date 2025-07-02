# Performance Optimization with Table Partitioning

This report details the implementation and performance benefits of partitioning the `bookings` table in the Airbnb database.

## Problem Statement

The `bookings` table grows continuously over time. As it scales to millions or billions of rows, queries that filter by date range (e.g., "find all bookings in the next month") become increasingly slow. This is because the database must scan a massive amount of irrelevant historical data to find the few rows it needs.

## Solution: Partitioning by Date

To solve this, we implement **RANGE partitioning** on the `bookings` table using the `start_date` column as the key. The table is divided into smaller, more manageable sub-tables (partitions), each containing data for a specific year.

### Implementation Steps

1.  **Modify Primary Key:** In MySQL, the partitioning key must be part of the primary key. The primary key was changed from `(booking_id)` to a composite key `(booking_id, start_date)`.
2.  **Apply Partitioning:** The `ALTER TABLE` command was used to partition the table by `RANGE(YEAR(start_date))`.

```sql
ALTER TABLE bookings
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);

## Performance Analysis: The Power of Partition Pruning

We can observe the performance improvement by comparing the `EXPLAIN` plans for a date-range query before and after partitioning.

**Query:** `SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';`

### Before Partitioning:

-   **Execution Plan:** The database performs a **Full Table Scan**. It must read every single row...

### After Partitioning:

-   **Execution Plan:** The database uses a technique called **Partition Pruning**. It looks at the `WHERE` clause...
-   **`EXPLAIN` Output:** The `EXPLAIN` command will now show a `partitions` key...
    ```
    id: 1
    select_type: SIMPLE
    table: bookings
    partitions: p2024  <-- KEY IMPROVEMENT!
    ...
    ```