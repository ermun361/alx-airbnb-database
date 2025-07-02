-- alx-airbnb-database/database-adv-script/joins_queries.sql

-- This script contains queries that demonstrate the use of different SQL JOIN types
-- on the Airbnb clone database.

-- =================================================================================
-- Query 1: INNER JOIN
-- Objective: Retrieve all bookings and the respective users who made those bookings.
-- =================================================================================

-- This query selects bookings that have a valid, matching user.
-- It will not show bookings with a null guest_id or users who have never booked.
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    bookings AS b
INNER JOIN
    users AS u ON b.guest_id = u.user_id;


-- =================================================================================
-- Query 2: LEFT JOIN
-- Objective: Retrieve all properties and their reviews, including properties that have no reviews.
-- =================================================================================

-- This query ensures that every property is listed, regardless of whether it has
-- received a review. If a property has no reviews, the columns from the 'reviews'
-- table (rating, comment) will appear as NULL.
SELECT
    p.property_id,
    p.title,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM
    properties AS p
LEFT JOIN
    reviews AS r ON p.property_id = r.property_id
ORDER BY
    p.title;


-- =================================================================================
-- Query 3: FULL OUTER JOIN
-- Objective: Retrieve all users and all bookings, even if a user has no booking
--            or a booking is not linked to a user.
-- =================================================================================

-- NOTE: Standard SQL uses FULL OUTER JOIN. However, MySQL does not support this
-- syntax directly. The standard workaround in MySQL is to perform a LEFT JOIN
-- and a RIGHT JOIN and combine the results with UNION.

-- **Standard SQL (e.g., PostgreSQL, SQL Server) Syntax:**
/*
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM
    users AS u
FULL OUTER JOIN
    bookings AS b ON u.user_id = b.guest_id;
*/


-- **MySQL Compatible Workaround (using LEFT and RIGHT JOIN with UNION):**
-- This query achieves the FULL OUTER JOIN result in MySQL.
-- The first part (LEFT JOIN) gets all users and their associated bookings.
-- The second part (RIGHT JOIN) gets all bookings and their associated users.
-- UNION combines these two sets, effectively showing users without bookings
-- and bookings without users (an unlikely but possible data integrity issue).

(SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM
    users AS u
LEFT JOIN
    bookings AS b ON u.user_id = b.guest_id)
UNION
(SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM
    users AS u
RIGHT JOIN
    bookings AS b ON u.user_id = b.guest_id);