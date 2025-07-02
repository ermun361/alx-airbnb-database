-- alx-airbnb-database/database-adv-script/3-database_index.sql

-- This script contains SQL commands to create indexes on high-usage columns
-- in the Airbnb clone database to improve query performance.

-- =================================================================================
-- Indexes for the 'users' table
-- =================================================================================

-- Index on the 'email' column to speed up user lookups during login.
-- Note: The 'UNIQUE' constraint on this column likely created an index already,
-- but explicitly defining it is good practice for clarity.
CREATE INDEX idx_users_email ON users(email);

-- Index on the 'role' column to quickly filter users by their role (guest, host, admin).
CREATE INDEX idx_users_role ON users(role);


-- =================================================================================
-- Indexes for the 'properties' table
-- =================================================================================

-- Index on the 'user_id' (foreign key) to optimize joins when retrieving properties for a specific host.
CREATE INDEX idx_properties_user_id ON properties(user_id);

-- Index on 'location' as it is a primary search criterion for users looking for properties.
CREATE INDEX idx_properties_location ON properties(location);

-- Index on 'price' to speed up queries that filter or sort by price range.
CREATE INDEX idx_properties_price ON properties(price);


-- =================================================================================
-- Indexes for the 'bookings' table
-- =================================================================================

-- Index on 'guest_id' (foreign key) for quickly finding all bookings made by a specific guest.
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);

-- Index on 'property_id' (foreign key) for quickly finding all bookings for a specific property.
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- A composite index on 'start_date' and 'end_date' is crucial for efficiently checking
-- property availability and avoiding booking conflicts.
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);