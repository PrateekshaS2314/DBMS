create database online_book_store;
use online_book_store;
create table Books
( BookID varchar(10) primary key,
Title varchar(15),
Author varchar(25),
Price int,
Publish_Date date);
create table Customers
(CustID varchar(10) primary key,
name varchar(15),
Email varchar(20),
JoinDate date);
create table Orders
( OrderID varchar(10) primary key,
 CustID varchar(10),
 BookID varchar(10),
 foreign key(CustID) references Customers(CustID),
 foreign key(BookID) references Books(BookID),
 OrderDate date,
 Quantity int);
 insert into Books values
('101', 'The Alchemist', 'Paulo Coelho', 350, '2010-06-15'),
('102', 'Atomic Habits', 'James Clear', 450, '2018-10-16'),
('103', 'Clean Code', 'Robert Martin', 550, '2008-08-01'),
('104', 'Think Like Monk', 'Jay Shetty', 400, '2020-09-08'),
('105', 'Python Course', 'Eric Matthes', 500, '2019-05-10');
insert into Customers values
('201', 'Arjun Rao', 'arjun@gmail.com', '2021-02-10'),
('202', 'Priya Nair', 'priya@yahoo.com', '2020-07-25'),
('203', 'John Smith', 'john@gmail.com', '2022-01-14'),
('204', 'Maria Lopez', 'maria@outlook.com', '2019-11-30');
insert into Orders values
('301', '201', '102', '2022-03-05', 2),
('302', '202', '101', '2021-09-12', 1),
('303', '203', '105', '2022-05-20', 3),
('304', '204', '104', '2020-12-25', 1),
('305', '201', '103', '2021-11-18', 1);
SELECT Name, UPPER(Name) AS UpperName FROM Customers;
-- # Name, UpperName
-- 'Arjun Rao', 'ARJUN RAO'
-- 'Priya Nair', 'PRIYA NAIR'
-- 'John Smith', 'JOHN SMITH'
-- 'Maria Lopez', 'MARIA LOPEZ'
SELECT Name, LOWER(Name) AS LowerName FROM Customers;
-- # Name, LowerName
-- 'Arjun Rao', 'arjun rao'
-- 'Priya Nair', 'priya nair'
-- 'John Smith', 'john smith'
-- 'Maria Lopez', 'maria lopez'
SELECT LEFT(Title, 3) AS ShortTitle FROM Books;
-- # ShortTitle
-- 'The'
-- 'Ato'
-- 'Cle'
-- 'Thi'
-- 'Pyt'
SELECT SUBSTRING_INDEX(Email, '@', -1) AS Domain FROM Customers;
-- # Domain
-- 'gmail.com'
-- 'yahoo.com'
-- 'gmail.com'
-- 'outlook.com'

SELECT Title, LENGTH(Title) AS TitleLength FROM Books;
-- # Title, TitleLength
-- 'The Alchemist', '13'
-- 'Atomic Habits', '13'
-- 'Clean Code', '10'
-- 'Think Like Monk', '15'
-- 'Python Course', '13'

SELECT REPLACE(Title, 'Book', 'Text') AS NewTitle FROM Books;
-- # NewTitle
-- 'The Alchemist'
-- 'Atomic Habits'
-- 'Clean Code'
-- 'Think Like Monk'
-- 'Python Course'

SELECT CONCAT(Author, ' - ', Title) AS AuthorBook FROM Books;
-- # AuthorBook
-- 'Paulo Coelho - The Alchemist'
-- 'James Clear - Atomic Habits'
-- 'Robert Martin - Clean Code'
-- 'Jay Shetty - Think Like Monk'
-- 'Eric Matthes - Python Course'

SELECT * FROM Books WHERE Author LIKE '%a%';
-- # BookID, Title, Author, Price, Publish_Date
-- '101', 'The Alchemist', 'Paulo Coelho', '350', '2010-06-15'
-- '102', 'Atomic Habits', 'James Clear', '450', '2018-10-16'
-- '103', 'Clean Code', 'Robert Martin', '550', '2008-08-01'
-- '104', 'Think Like Monk', 'Jay Shetty', '400', '2020-09-08'
-- '105', 'Python Course', 'Eric Matthes', '500', '2019-05-10'

SELECT Title, YEAR(Publish_Date) AS PublishYear FROM Books;
-- # Title, PublishYear
-- 'The Alchemist', 2010
-- 'Atomic Habits', 2018
-- 'Clean Code', 2008
-- 'Think Like Monk', 2020
-- 'Python Course', 2019

SELECT Name, MONTHNAME(JoinDate) AS JoinMonth FROM Customers;
-- # Name, JoinMonth
-- 'Arjun Rao', 'February'
-- 'Priya Nair', 'July'
-- 'John Smith', 'January'
-- 'Maria Lopez', 'November'

SELECT * FROM Customers WHERE YEAR(JoinDate) = 2021;
-- # CustID, name, Email, JoinDate
-- '201', 'Arjun Rao', 'arjun@gmail.com', '2021-02-10'

SELECT OrderID, DAYNAME(OrderDate) AS OrderDay FROM Orders;
-- # OrderID, OrderDay
-- '301', 'Saturday'
-- '302', 'Sunday'
-- '303', 'Friday'
-- '304', 'Friday'
-- '305', 'Thursday'

SELECT Title, TIMESTAMPDIFF(YEAR, Publish_Date, CURDATE()) AS BookAge FROM Books;
-- # Title, BookAge
-- 'The Alchemist', '15'
-- 'Atomic Habits', '6'
-- 'Clean Code', '17'
-- 'Think Like Monk', '5'
-- 'Python Course', '6'

SELECT Name, DATEDIFF(CURDATE(), JoinDate) AS DaysSinceJoin FROM Customers;
-- # Name, DaysSinceJoin
-- 'Arjun Rao', '1680'
-- 'Priya Nair', '1880'
-- 'John Smith', '1342'
-- 'Maria Lopez', '2118'

SELECT * FROM Orders WHERE MONTH(OrderDate) = 12;
-- # OrderID, CustID, BookID, OrderDate, Quantity
-- '304', '204', '104', '2020-12-25', '1'

SELECT COUNT(*) AS TotalBooks FROM Books;
-- # TotalBooks
-- '5'

SELECT AVG(Price) AS AvgPrice FROM Books;
-- # AvgPrice
-- '450.0000'

SELECT MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice FROM Books;
-- # MaxPrice, MinPrice
-- '550', '350'

SELECT COUNT(*) AS CountAfter2020 FROM Customers WHERE YEAR(JoinDate) > 2020;
-- # CountAfter2020
-- '2'

SELECT SUM(Quantity) AS TotalOrdered FROM Orders;
-- # TotalOrdered
-- '8'