-- alx-airbnb-database/database-adv-script/2-aggregations_and_window_functions.sql

-- This script demonstrates the use of aggregation and window functions to perform
-- data analysis on the Airbnb clone database.

-- =================================================================================
-- Query 1: Aggregation with COUNT and GROUP BY
-- Objective: Find the total number of bookings made by each user.
-- =================================================================================

-- This query joins the users and bookings tables, then groups the results by each
-- user to count how many bookings are associated with them.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    users AS u
JOIN
    bookings AS b ON u.user_id = b.guest_id
GROUP BY
    u.user_id, u.first_name, u.last_name
ORDER BY
    total_bookings DESC;


-- =================================================================================
-- Query 2: Window Functions (RANK and ROW_NUMBER)
-- Objective: Rank properties based on the total number of bookings they have received.
-- =================================================================================

-- This query first uses a Common Table Expression (CTE) to calculate the booking
-- count for each property. Then, it uses the RANK() and ROW_NUMBER() window
-- functions to assign a rank to each property based on its booking count.
-- RANK() will assign the same rank to properties with the same number of bookings (ties),
-- while ROW_NUMBER() will assign a unique, sequential number to each row.

WITH PropertyBookingCounts AS (
    SELECT
        property_id,
        COUNT(booking_id) AS booking_count
    FROM
        bookings
    GROUP BY
        property_id
)
SELECT
    p.property_id,
    p.title,
    pbc.booking_count,
    RANK() OVER (ORDER BY pbc.booking_count DESC) AS property_rank,
    ROW_NUMBER() OVER (ORDER BY pbc.booking_count DESC) AS property_row_number
FROM
    properties AS p
JOIN
    PropertyBookingCounts AS pbc ON p.property_id = pbc.property_id
ORDER BY
    property_rank;