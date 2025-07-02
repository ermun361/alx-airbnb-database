# Database Performance Monitoring and Refinement Report

This document outlines the process of monitoring database query performance, identifying bottlenecks, and implementing schema and index refinements to improve efficiency.


## 1. Monitoring a Frequently Used, Complex Query

A critical user-facing query in our Airbnb application is the property search, which often involves multiple filters like location, price, number of guests, and specific amenities.

**Scenario:** A user searches for properties in 'San Francisco', costing less than $300 per night, for at least 4 guests, and that specifically include 'WiFi'.

**The Inefficient Query:**
```sql
SELECT
    p.property_id,
    p.title,
    p.location,
    p.price,
    p.max_guests
FROM
    properties AS p
WHERE
    p.location = 'San Francisco'
    AND p.price < 300.00
    AND p.max_guests >= 4
    AND p.amenities LIKE '%WiFi%';