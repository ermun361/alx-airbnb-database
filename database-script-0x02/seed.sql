-- Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
('1a1b1c1d-0000-0000-0000-000000000001', 'Alice', 'Doe', 'alice@example.com', 'hashedpass123', '1234567890', 'host'),
('2b2c2d2e-0000-0000-0000-000000000002', 'Bob', 'Smith', 'bob@example.com', 'hashedpass456', '0987654321', 'guest');

-- Properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES 
('prop-001', '1a1b1c1d-0000-0000-0000-000000000001', 'Cozy Loft', 'Nice loft in downtown', 'Nairobi', 50.00),
('prop-002', '1a1b1c1d-0000-0000-0000-000000000001', 'Beach Bungalow', 'Oceanfront property', 'Mombasa', 120.00);

-- Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('book-001', 'prop-001', '2b2c2d2e-0000-0000-0000-000000000002', '2025-07-01', '2025-07-05', 200.00, 'confirmed');

-- Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
('pay-001', 'book-001', 200.00, 'credit_card');

-- Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
('rev-001', 'prop-001', '2b2c2d2e-0000-0000-0000-000000000002', 5, 'Great place!');

-- Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
('msg-001', '2b2c2d2e-0000-0000-0000-000000000002', '1a1b1c1d-0000-0000-0000-000000000001', 'Hi! Is the loft available next weekend?');
