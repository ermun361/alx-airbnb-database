-- alx-airbnb-database/database-adv-script/3-database_index.sql

-- This script contains commands to create indexes and demonstrates how to measure
-- query performance before and after optimization.

-- =================================================================================
-- Step 1: Measure Performance BEFORE Indexing
-- =================================================================================

-- We will analyze a common query: searching for properties in a specific location.
-- Without an index, this query will perform a full table scan, which is inefficient.
-- The output will show a high cost and a "Table scan" operation.

EXPLAIN ANALYZE SELECT * FROM properties WHERE location = 'New York';


-- =================================================================================
-- Step 2: Create the Recommended Indexes
-- =================================================================================

-- Index on 'location' to optimize the query analyzed above.
CREATE INDEX idx_properties_location ON properties(location);

-- Additional useful indexes for overall application performance:

-- Users Table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Properties Table
CREATE INDEX idx_properties