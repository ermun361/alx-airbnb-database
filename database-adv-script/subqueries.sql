-- alx-airbnb-database/database-adv-script/subqueries.sql

-- This script demonstrates the use of both non-correlated and correlated subqueries
-- on the Airbnb clone database.

-- =================================================================================
-- Query 1: Non-Correlated Subquery
-- Objective: Write a query to find all properties where the average rating is
--            greater than 4.0.
-- =================================================================================

-- This is a non-correlated subquery because the inner query can be run independently
-- of the outer query. The database first executes the inner query to get a list
-- of all property_ids with an average rating > 4.0, and then the outer query uses
-- this list to fetch the property details.

SELECT
    p.property_id,
    p.title,
    p.location,
    p.price
FROM
    properties AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            reviews AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );


-- =================================================================================
-- Query 2: Correlated Subquery
-- Objective: Write a correlated subquery to find users who have made more than
--            3 bookings.
-- =================================================================================

-- This is a correlated subquery because the inner query depends on the outer query.
-- For each row processed by the outer query (for each user 'u'), the inner query
-- is executed to count the number of bookings specifically for that user (WHERE b.guest_id = u.user_id).
-- While this works, a JOIN with GROUP BY and HAVING is often more performant for this task.

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    users AS u
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            bookings AS b
        WHERE
            b.guest_id = u.user_id
    ) > 3;