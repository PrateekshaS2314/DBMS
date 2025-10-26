CREATE DATABASE Hotel;
USE Hotel;

CREATE TABLE Guests (
  guest_id INT PRIMARY KEY,
  name VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(100)
);

CREATE TABLE Rooms (
  room_id INT PRIMARY KEY,
  room_number VARCHAR(10),
  room_type VARCHAR(50), -- e.g., Deluxe, Suite
  price_per_night DECIMAL(10,2)
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  guest_id INT,
  room_id INT,
  check_in DATE,
  check_out DATE,
  status VARCHAR(20),
  FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Sample data
INSERT INTO Guests VALUES
(1,'Rakesh Sharma','8000000001','rakesh@example.com'),
(2,'Meena Kapoor','8000000002','meena@example.com'),
(3,'Devika Menon','8000000003','devika@example.com'),
(4,'Sanjay Rao','8000000004','sanjay@example.com'),
(5,'Tina Fernandes','8000000005','tina@example.com');

INSERT INTO Rooms VALUES
(301,'101','Deluxe',4000.00),
(302,'102','Suite',8000.00),
(303,'201','Deluxe',4000.00),
(304,'202','Standard',2500.00),
(305,'301','Executive',6000.00);

INSERT INTO Bookings VALUES
(9001,1,301,'2025-05-01','2025-05-05','Checked-in'),
(9002,2,302,'2025-05-03','2025-05-04','Booked'),
(9003,3,304,'2025-05-02','2025-05-06','Checked-out'),
(9004,4,305,'2025-05-10','2025-05-12','Cancelled'),
(9005,5,303,'2025-05-15','2025-05-18','Booked');

-- Queries

-- 1. Total revenue per room type (for bookings that are checked-out or checked-in)
SELECT r.room_type, SUM(DATEDIFF(b.check_out, b.check_in) * r.price_per_night) AS Total_Revenue
FROM Rooms r
JOIN Bookings b ON r.room_id = b.room_id
WHERE b.status IN ('Checked-in','Checked-out','Booked')
GROUP BY r.room_type;
-- # room_type, Total_Revenue
-- 'Deluxe', '28000.00'
-- 'Suite', '8000.00'
-- 'Standard', '10000.00'

-- 2. Booking duration using date functions
SELECT booking_id, guest_id, room_id, check_in, check_out, DATEDIFF(check_out, check_in) AS Nights
FROM Bookings;
-- # booking_id, guest_id, room_id, check_in, check_out, Nights
-- '9001', '1', '301', '2025-05-01', '2025-05-05', '4'
-- '9002', '2', '302', '2025-05-03', '2025-05-04', '1'
-- '9003', '3', '304', '2025-05-02', '2025-05-06', '4'
-- '9004', '4', '305', '2025-05-10', '2025-05-12', '2'
-- '9005', '5', '303', '2025-05-15', '2025-05-18', '3'

-- 3. Guests with active bookings
SELECT g.name, b.booking_id, r.room_number, b.check_in, b.check_out, b.status
FROM Guests g
JOIN Bookings b ON g.guest_id = b.guest_id
JOIN Rooms r ON b.room_id = r.room_id
WHERE b.status = 'Booked' OR b.status = 'Checked-in';
-- # name, booking_id, room_number, check_in, check_out, status
-- 'Rakesh Sharma', '9001', '101', '2025-05-01', '2025-05-05', 'Checked-in'
-- 'Meena Kapoor', '9002', '102', '2025-05-03', '2025-05-04', 'Booked'
-- 'Tina Fernandes', '9005', '201', '2025-05-15', '2025-05-18', 'Booked'

-- Procedure to insert booking
DELIMITER //
CREATE PROCEDURE InsertRoomBooking(
  IN bid INT, IN gid INT, IN rid INT, IN cin DATE, IN cout DATE, IN st VARCHAR(20)
)
BEGIN
  INSERT INTO Bookings VALUES (bid, gid, rid, cin, cout, st);
END //
DELIMITER ;
CALL InsertRoomBooking(9006, 2, 304, '2025-05-20', '2025-05-22', 'Booked');
SELECT * FROM Bookings;
-- # booking_id, guest_id, room_id, check_in, check_out, status
-- '9001', '1', '301', '2025-05-01', '2025-05-05', 'Checked-in'
-- '9002', '2', '302', '2025-05-03', '2025-05-04', 'Booked'
-- '9003', '3', '304', '2025-05-02', '2025-05-06', 'Checked-out'
-- '9004', '4', '305', '2025-05-10', '2025-05-12', 'Cancelled'
-- '9005', '5', '303', '2025-05-15', '2025-05-18', 'Booked'
-- '9006', '2', '304', '2025-05-20', '2025-05-22', 'Booked'

-- Procedure to update booking dates/status
DELIMITER //
CREATE PROCEDURE UpdateBooking(
  IN bid INT, IN new_checkin DATE, IN new_checkout DATE, IN new_status VARCHAR(20)
)
BEGIN
  UPDATE Bookings
  SET check_in = new_checkin, check_out = new_checkout, status = new_status
  WHERE booking_id = bid;
END //
DELIMITER ;
CALL UpdateBooking(9002, '2025-05-04', '2025-05-06', 'Checked-in');
SELECT * FROM Bookings;
-- # booking_id, guest_id, room_id, check_in, check_out, status
-- '9001', '1', '301', '2025-05-01', '2025-05-05', 'Checked-in'
-- '9002', '2', '302', '2025-05-04', '2025-05-06', 'Checked-in'
-- '9003', '3', '304', '2025-05-02', '2025-05-06', 'Checked-out'
-- '9004', '4', '305', '2025-05-10', '2025-05-12', 'Cancelled'
-- '9005', '5', '303', '2025-05-15', '2025-05-18', 'Booked'
-- '9006', '2', '304', '2025-05-20', '2025-05-22', 'Booked'
