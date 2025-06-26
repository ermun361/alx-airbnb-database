# ER Diagram Requirements

This document includes the entity-relationship diagram for the Airbnb database system.

## Entities

- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

## Relationships

- A User can have many Properties.
- A User can make many Bookings.
- A Booking is for one Property.
- A Booking results in one Payment.
- A User can write multiple Reviews on Properties.
- Users can message each other (Messages have sender and recipient).
