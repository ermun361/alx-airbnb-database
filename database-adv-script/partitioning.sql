-- alx-airbnb-database/database-adv-script/5-partitioning.sql
-- This script provides the complete CREATE TABLE statement for the 'bookings' table,
-- including the partitioning definition required for optimization.

-- To partition a table in MySQL, the partitioning key ('start_date') must be
-- part of the primary key. This definition creates a composite primary key.

CREATE TABLE `bookings` (
  `booking_id` UUID NOT NULL,
  `guest_id` UUID,
  `property_id` UUID,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `status` ENUM('pending','confirmed','canceled','completed') DEFAULT 'pending',
  `total_price` DECIMAL(10,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (booking_id, start_date) -- Composite Primary Key
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);