CREATE DATABASE Cinema;
USE Cinema;

CREATE TABLE Movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(200),
  duration_minutes INT,
  genre VARCHAR(50)
);

CREATE TABLE Shows (
  show_id INT PRIMARY KEY,
  movie_id INT,
  show_date DATE,
  show_time TIME,
  hall VARCHAR(50),
  total_seats INT,
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  show_id INT,
  customer_name VARCHAR(100),
  seats_booked INT,
  booking_date DATE,
  amount_paid DECIMAL(10,2),
  FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

-- Sample data
INSERT INTO Movies VALUES
(1,'Space Odyssey','140','Sci-Fi'),
(2,'The Heist','120','Action'),
(3,'Romance in Rain','110','Romance'),
(4,'Mystery Manor','130','Mystery'),
(5,'Animated Fun','95','Animation');

INSERT INTO Shows VALUES
(501,1,'2025-05-01','18:00:00','Hall 1',200),
(502,2,'2025-05-01','20:30:00','Hall 2',150),
(503,3,'2025-05-02','17:00:00','Hall 1',200),
(504,4,'2025-05-03','19:00:00','Hall 3',120),
(505,5,'2025-05-04','15:30:00','Hall 2',100);

INSERT INTO Bookings VALUES
(70001,501,'Rohit',2,'2025-04-10',400.00),
(70002,501,'Anita',3,'2025-04-11',600.00),
(70003,502,'Karan',1,'2025-04-12',200.00),
(70004,503,'Sara',4,'2025-04-13',800.00),
(70005,504,'Priya',2,'2025-04-14',400.00);

-- Queries

-- 1. Count tickets per movie (sum of seats_booked grouped by movie)
SELECT m.movie_id, m.title, SUM(b.seats_booked) AS Tickets_Sold
FROM Movies m
JOIN Shows s ON m.movie_id = s.movie_id
LEFT JOIN Bookings b ON s.show_id = b.show_id
GROUP BY m.movie_id, m.title
ORDER BY Tickets_Sold DESC;
-- # movie_id, title, Tickets_Sold
-- '1', 'Space Odyssey', '5'
-- '3', 'Romance in Rain', '4'
-- '4', 'Mystery Manor', '2'
-- '2', 'The Heist', '1'
-- '5', 'Animated Fun', NULL

-- 2. Booking details with movie/show info
SELECT b.booking_id, b.customer_name, b.seats_booked, b.amount_paid, m.title, s.show_date, s.show_time, s.hall
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
ORDER BY b.booking_date DESC;
-- # booking_id, customer_name, seats_booked, amount_paid, title, show_date, show_time, hall
-- '70005', 'Priya', '2', '400.00', 'Mystery Manor', '2025-05-03', '19:00:00', 'Hall 3'
-- '70004', 'Sara', '4', '800.00', 'Romance in Rain', '2025-05-02', '17:00:00', 'Hall 1'
-- '70003', 'Karan', '1', '200.00', 'The Heist', '2025-05-01', '20:30:00', 'Hall 2'
-- '70002', 'Anita', '3', '600.00', 'Space Odyssey', '2025-05-01', '18:00:00', 'Hall 1'
-- '70001', 'Rohit', '2', '400.00', 'Space Odyssey', '2025-05-01', '18:00:00', 'Hall 1'

-- 3. Most popular show (by seats booked)
SELECT s.show_id, m.title, SUM(b.seats_booked) AS Seats_Booked
FROM Shows s
JOIN Movies m ON s.movie_id = m.movie_id
LEFT JOIN Bookings b ON s.show_id = b.show_id
GROUP BY s.show_id, m.title
ORDER BY Seats_Booked DESC
LIMIT 1;
-- # show_id, title, Seats_Booked
-- '501', 'Space Odyssey', '5'

-- Procedure to insert booking (and optionally check seat availability)
DELIMITER //
CREATE PROCEDURE InsertBooking(
  IN bid INT, IN sid INT, IN cname VARCHAR(100), IN seats INT, IN bdate DATE, IN amount DECIMAL(10,2)
)
BEGIN
  -- Simple insert (business logic like seat availability checks can be added)
  INSERT INTO Bookings VALUES (bid, sid, cname, seats, bdate, amount);
END //
DELIMITER ;
CALL InsertBooking(70006, 502, 'Rhea', 2, '2025-04-15', 400.00);
SELECT * FROM Bookings;
-- # booking_id, show_id, customer_name, seats_booked, booking_date, amount_paid
-- '70001', '501', 'Rohit', '2', '2025-04-10', '400.00'
-- '70002', '501', 'Anita', '3', '2025-04-11', '600.00'
-- '70003', '502', 'Karan', '1', '2025-04-12', '200.00'
-- '70004', '503', 'Sara', '4', '2025-04-13', '800.00'
-- '70005', '504', 'Priya', '2', '2025-04-14', '400.00'
-- '70006', '502', 'Rhea', '2', '2025-04-15', '400.00'

-- Procedure to update booking (change seats or amount)
DELIMITER //
CREATE PROCEDURE UpdateBooking(
  IN bid INT, IN new_seats INT, IN new_amount DECIMAL(10,2)
)
BEGIN
  UPDATE Bookings SET seats_booked = new_seats, amount_paid = new_amount WHERE booking_id = bid;
END //
DELIMITER ;
CALL UpdateBooking(70002, 4, 800.00);
SELECT * FROM Bookings;
-- # booking_id, show_id, customer_name, seats_booked, booking_date, amount_paid
-- '70001', '501', 'Rohit', '2', '2025-04-10', '400.00'
-- '70002', '501', 'Anita', '4', '2025-04-11', '800.00'
-- '70003', '502', 'Karan', '1', '2025-04-12', '200.00'
-- '70004', '503', 'Sara', '4', '2025-04-13', '800.00'
-- '70005', '504', 'Priya', '2', '2025-04-14', '400.00'
-- '70006', '502', 'Rhea', '2', '2025-04-15', '400.00'
