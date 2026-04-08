-- Create Database Schema for Hotel Management
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Insert Sample Data for Testing
INSERT INTO users VALUES 
('u101', 'John Doe', '9711111111', 'john@example.com', 'Street A'),
('u102', 'Jane Smith', '9722222222', 'jane@example.com', 'Street B'),
('u103', 'Bob Martin', '9733333333', 'bob@example.com', 'Street C');

INSERT INTO items VALUES 
('itm-001', 'Tawa Paratha', 18.00),
('itm-002', 'Mix Veg', 89.00),
('itm-003', 'Paneer Butter Masala', 220.00),
('itm-004', 'Butter Naan', 40.00);

INSERT INTO bookings VALUES 
('bk-001', '2021-11-05 10:00:00', 'R-101', 'u101'),
('bk-002', '2021-11-15 12:00:00', 'R-102', 'u102'),
('bk-003', '2021-10-10 09:00:00', 'R-101', 'u101'),
('bk-004', '2021-10-25 14:00:00', 'R-103', 'u103');

-- Insert Commercial Data (Bills)
-- Note: bill_ids bl-01 and bl-02 are in Oct, bl-03 is in Nov
INSERT INTO booking_commercials VALUES 
('c1', 'bk-003', 'bl-01', '2021-10-10 09:30:00', 'itm-001', 5),   -- Bill 90 (Oct)
('c2', 'bk-003', 'bl-01', '2021-10-10 09:30:00', 'itm-003', 5),   -- Bill 1100 (Oct) -> Total 1190 > 1000
('c3', 'bk-004', 'bl-02', '2021-10-25 14:30:00', 'itm-002', 2),   -- Bill 178 (Oct)
('c4', 'bk-001', 'bl-03', '2021-11-05 10:30:00', 'itm-004', 10),  -- Nov Booking Item
('c5', 'bk-002', 'bl-04', '2021-11-15 12:30:00', 'itm-003', 2);   -- Nov Booking Item