# Airbnb Database Normalization

## Objective
The goal of normalization is to eliminate data redundancy and ensure data integrity. This database schema has been reviewed and normalized up to **Third Normal Form (3NF)**.

## First Normal Form (1NF)

**Requirements:**
- Each table has a primary key.
- All attributes contain atomic (indivisible) values.
- Each field contains only one value per record (no repeating groups or arrays).

**Applied To:**
- All tables (users, properties, bookings, payments, reviews, messages) have clearly defined atomic columns.
- No multi-valued attributes exist.

✅ **1NF satisfied**


## Second Normal Form (2NF)

**Requirements:**
- The database must first satisfy 1NF.
- All non-key attributes must be fully functionally dependent on the entire primary key (no partial dependencies).

**Applied To:**
- All tables have a **single-column primary key** (UUIDs), so partial dependencies don’t exist.
- Example: `property_id` in `bookings` table is functionally dependent on `booking_id` (no composite keys involved).

✅ **2NF satisfied**


## Third Normal Form (3NF)

**Requirements:**
- The database must first satisfy 2NF.
- No transitive dependencies (non-key attributes must not depend on other non-key attributes).

**Applied To:**
- Example: In the `users` table, `email`, `first_name`, `role`, etc., all directly depend on `user_id`, and not on each other.
- Payment methods and booking statuses are stored as ENUMs — not as descriptive text — avoiding transitive duplication.

✅ **3NF satisfied**


## Summary

This schema avoids:
- Repeated data,
- Partial dependencies,
- Transitive dependencies.

Normalization up to 3NF improves scalability, query efficiency, and ensures data integrity across all operations.

