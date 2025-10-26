CREATE DATABASE Flight;
USE Flight;

CREATE TABLE Passengers (
  passenger_id INT PRIMARY KEY,
  name VARCHAR(100),
  passport_no VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Flights (
  flight_id INT PRIMARY KEY,
  flight_number VARCHAR(20),
  origin VARCHAR(50),
  destination VARCHAR(50),
  departure_date DATE,
  departure_time TIME,
  capacity INT
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  passenger_id INT,
  flight_id INT,
  booking_date DATE,
  seat_no VARCHAR(10),
  status VARCHAR(20),
  FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
  FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Sample data
INSERT INTO Passengers VALUES
(1,'Aman Malhotra','P123456','9000011111'),
(2,'Nisha Rao','P234567','9000022222'),
(3,'Vivek Singh','P345678','9000033333'),
(4,'Ritu Menon','P456789','9000044444'),
(5,'Kiran Patel','P567890','9000055555');

INSERT INTO Flights VALUES
(5001,'AI101','Bangalore','Mumbai','2025-05-10','08:00:00',180),
(5002,'AI202','Mumbai','Delhi','2025-05-11','10:30:00',200),
(5003,'AI303','Delhi','Chennai','2025-05-12','13:00:00',150),
(5004,'AI404','Chennai','Kolkata','2025-05-13','16:45:00',160),
(5005,'AI505','Kolkata','Bangalore','2025-05-14','19:00:00',170);

INSERT INTO Bookings VALUES
(6001,1,5001,'2025-04-01','12A','Confirmed'),
(6002,2,5001,'2025-04-02','12B','Confirmed'),
(6003,3,5003,'2025-04-03','14C','Confirmed'),
(6004,4,5002,'2025-04-04','10D','Cancelled'),
(6005,5,5004,'2025-04-05','18F','Confirmed');

-- Queries

-- 1. Total passengers per flight
SELECT f.flight_id, f.flight_number, COUNT(b.passenger_id) AS Total_Passengers
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id AND b.status='Confirmed'
GROUP BY f.flight_id, f.flight_number
ORDER BY Total_Passengers DESC;
-- # flight_id, flight_number, Total_Passengers
-- '5001', 'AI101', '2'
-- '5003', 'AI303', '1'
-- '5004', 'AI404', '1'
-- '5002', 'AI202', '0'
-- '5005', 'AI505', '0'

-- 2. Flight details for each passenger
SELECT p.name AS passenger_name, f.flight_number, f.origin, f.destination, f.departure_date, b.seat_no, b.status
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
ORDER BY b.booking_date DESC;
-- # passenger_name, flight_number, origin, destination, departure_date, seat_no, status
-- 'Kiran Patel', 'AI404', 'Chennai', 'Kolkata', '2025-05-13', '18F', 'Confirmed'
-- 'Ritu Menon', 'AI202', 'Mumbai', 'Delhi', '2025-05-11', '10D', 'Cancelled'
-- 'Vivek Singh', 'AI303', 'Delhi', 'Chennai', '2025-05-12', '14C', 'Confirmed'
-- 'Nisha Rao', 'AI101', 'Bangalore', 'Mumbai', '2025-05-10', '12B', 'Confirmed'
-- 'Aman Malhotra', 'AI101', 'Bangalore', 'Mumbai', '2025-05-10', '12A', 'Confirmed'

-- 3. Upcoming flights with vacancy (capacity - confirmed bookings)
SELECT f.flight_id, f.flight_number, f.capacity, 
       (f.capacity - COUNT(b.booking_id)) AS Seats_Left
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id AND b.status='Confirmed'
GROUP BY f.flight_id, f.flight_number, f.capacity;
-- # flight_id, flight_number, capacity, Seats_Left
-- '5001', 'AI101', '180', '178'
-- '5002', 'AI202', '200', '200'
-- '5003', 'AI303', '150', '149'
-- '5004', 'AI404', '160', '159'
-- '5005', 'AI505', '170', '170'

-- Procedure to insert booking
DELIMITER //
CREATE PROCEDURE InsertBooking(
  IN bid INT, IN pid INT, IN fid INT, IN bdate DATE, IN seat VARCHAR(10), IN st VARCHAR(20)
)
BEGIN
  INSERT INTO Bookings VALUES (bid, pid, fid, bdate, seat, st);
END //
DELIMITER ;
CALL InsertBooking(6006, 2, 5003, '2025-04-06', '15A', 'Confirmed');
SELECT * FROM Bookings;
-- # booking_id, passenger_id, flight_id, booking_date, seat_no, status
-- '6001', '1', '5001', '2025-04-01', '12A', 'Confirmed'
-- '6002', '2', '5001', '2025-04-02', '12B', 'Confirmed'
-- '6003', '3', '5003', '2025-04-03', '14C', 'Confirmed'
-- '6004', '4', '5002', '2025-04-04', '10D', 'Cancelled'
-- '6005', '5', '5004', '2025-04-05', '18F', 'Confirmed'
-- '6006', '2', '5003', '2025-04-06', '15A', 'Confirmed'

-- Procedure to update booking status
DELIMITER //
CREATE PROCEDURE UpdateBookingStatus(
  IN bid INT, IN new_status VARCHAR(20)
)
BEGIN
  UPDATE Bookings SET status = new_status WHERE booking_id = bid;
END //
DELIMITER ;
CALL UpdateBookingStatus(6004, 'Confirmed');
SELECT * FROM Bookings;
-- # booking_id, passenger_id, flight_id, booking_date, seat_no, status
-- '6001', '1', '5001', '2025-04-01', '12A', 'Confirmed'
-- '6002', '2', '5001', '2025-04-02', '12B', 'Confirmed'
-- '6003', '3', '5003', '2025-04-03', '14C', 'Confirmed'
-- '6004', '4', '5002', '2025-04-04', '10D', 'Confirmed'
-- '6005', '5', '5004', '2025-04-05', '18F', 'Confirmed'
-- '6006', '2', '5003', '2025-04-06', '15A', 'Confirmed'
