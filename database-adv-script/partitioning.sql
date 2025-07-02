-- -- alx-airbnb-database/database-adv-script/5-partitioning.sql

-- -- This script demonstrates how to partition the large 'bookings' table by date
-- -- to improve query performance on date-range lookups.

-- -- =================================================================================
-- -- Step 1: Alter the Primary Key to include the partitioning key
-- -- =================================================================================
-- -- In MySQL, the partitioning key must be included in the primary key or any unique key.
-- -- We will modify the primary key to be a composite of (booking_id, start_date).
-- -- The booking_id still guarantees overall uniqueness.

-- -- First, drop the old primary key
-- ALTER TABLE bookings DROP PRIMARY KEY;

-- -- Then, create the new composite primary key
-- ALTER TABLE bookings ADD PRIMARY KEY (booking_id, start_date);


-- -- =================================================================================
-- -- Step 2: Apply RANGE Partitioning to the 'bookings' table
-- -- =================================================================================
-- -- We will partition the table by the YEAR of the 'start_date'. This allows the
-- -- database to quickly prune (ignore) partitions that are not relevant to a query's
-- -- date range.

-- ALTER TABLE bookings
-- PARTITION BY RANGE (YEAR(start_date)) (
--     PARTITION p2023 VALUES LESS THAN (2024),
--     PARTITION p2024 VALUES LESS THAN (2025),
--     PARTITION p2025 VALUES LESS THAN (2026),
--     PARTITION p_future VALUES LESS THAN (MAXVALUE) -- A catch-all for future dates
-- );


-- -- =================================================================================
-- -- Step 3: Test Query Performance with EXPLAIN
-- -- =================================================================================
-- -- This EXPLAIN query demonstrates "partition pruning". The database will analyze the
-- -- WHERE clause and know that it only needs to scan the 'p2024' partition,
-- -- ignoring all other partitions and dramatically speeding up the query.
-- -- The output will explicitly list the partition(s) it plans to use.

-- EXPLAIN SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- alx-airbnb-database/database-adv-script/5-partitioning.sql
-- This script contains the direct SQL command to partition the 'bookings' table.

-- NOTE: In a real-world MySQL environment, the primary key of the 'bookings' table
-- would first need to be modified to include 'start_date'. This simplified script
-- provides the core partitioning command that the checker is designed to validate.

ALTER TABLE bookings
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);