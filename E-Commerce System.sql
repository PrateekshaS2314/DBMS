CREATE DATABASE ECommerce;
USE ECommerce;

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20),
  join_date DATE
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(200),
  price DECIMAL(10,2),
  stock INT
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(12,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample data
INSERT INTO Customers VALUES
(1,'Rohan Patel','rohan@example.com','7000000001','2024-06-01'),
(2,'Mira Joshi','mira@example.com','7000000002','2024-07-12'),
(3,'Siddharth Roy','sid@example.com','7000000003','2024-08-20'),
(4,'Lata Deshmukh','lata@example.com','7000000004','2024-09-05'),
(5,'Deepak Nair','deepak@example.com','7000000005','2024-10-01');

INSERT INTO Products VALUES
(1001,'Wireless Mouse',799.00,50),
(1002,'Mechanical Keyboard',2499.00,20),
(1003,'USB-C Charger',999.00,100),
(1004,'Noise Cancelling Headphones',5999.00,10),
(1005,'Webcam HD',1999.00,15);

INSERT INTO Orders VALUES
(4001,1,'2025-04-10',1798.00),
(4002,2,'2025-04-11',2499.00),
(4003,1,'2025-04-12',2998.00),
(4004,3,'2025-04-13',999.00),
(4005,4,'2025-04-14',799.00);

INSERT INTO OrderItems VALUES
(7001,4001,1001,2,799.00),
(7002,4002,1002,1,2499.00),
(7003,4003,1004,1,5999.00),
(7004,4003,1003,1,999.00),
(7005,4004,1003,1,999.00);

-- Queries

-- 1. Total sales per product
SELECT p.product_id, p.name, SUM(oi.quantity * oi.price) AS Total_Sales, SUM(oi.quantity) AS Units_Sold
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY Total_Sales DESC;

-- # product_id, name, Total_Sales, Units_Sold
-- '1004', 'Noise Cancelling Headphones', '5999.00', '1'
-- '1002', 'Mechanical Keyboard', '2499.00', '1'
-- '1003', 'USB-C Charger', '1998.00', '2'
-- '1001', 'Wireless Mouse', '1598.00', '2'

-- 2. Most purchased product (by units)
SELECT product_id, SUM(quantity) AS Units_Sold
FROM OrderItems
GROUP BY product_id
ORDER BY Units_Sold DESC
LIMIT 1;

-- # product_id, Units_Sold
-- '1001', '2'

-- 3. Customer orders with items
SELECT o.order_id, o.order_date, c.name AS customer_name, oi.product_id, oi.quantity, oi.price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
ORDER BY o.order_date DESC;

-- # order_id, order_date, customer_name, product_id, quantity, price
-- '4004', '2025-04-13', 'Siddharth Roy', '1003', '1', '999.00'
-- '4003', '2025-04-12', 'Rohan Patel', '1004', '1', '5999.00'
-- '4003', '2025-04-12', 'Rohan Patel', '1003', '1', '999.00'
-- '4002', '2025-04-11', 'Mira Joshi', '1002', '1', '2499.00'
-- '4001', '2025-04-10', 'Rohan Patel', '1001', '2', '799.00'

-- Procedure to update product stock after an order
DELIMITER //
CREATE PROCEDURE UpdateStock(
  IN pid INT,
  IN qty_sold INT
)
BEGIN
  UPDATE Products
  SET stock = stock - qty_sold
  WHERE product_id = pid;
END //
DELIMITER ;
CALL UpdateStock(101, 2);
select * from Products;

-- # product_id, name, price, stock
-- '1001', 'Wireless Mouse', '799.00', '50'
-- '1002', 'Mechanical Keyboard', '2499.00', '20'
-- '1003', 'USB-C Charger', '999.00', '100'
-- '1004', 'Noise Cancelling Headphones', '5999.00', '10'
-- '1005', 'Webcam HD', '1999.00', '15'

-- Procedure to insert a new order (high level)
DELIMITER //
CREATE PROCEDURE InsertOrder(
  IN oid INT,
  IN cid INT,
  IN odate DATE,
  IN total DECIMAL(10,2)
)
BEGIN
  INSERT INTO Orders VALUES (oid, cid, odate, total);
END //
DELIMITER ;
CALL InsertOrder(1001, 1, '2025-10-26', 2298.00);
select * from Orders;
-- # order_id, customer_id, order_date, total_amount
-- '1001', '1', '2025-10-26', '2298.00'
-- '4001', '1', '2025-04-10', '1798.00'
-- '4002', '2', '2025-04-11', '2499.00'
-- '4003', '1', '2025-04-12', '2998.00'
-- '4004', '3', '2025-04-13', '999.00'
-- '4005', '4', '2025-04-14', '799.00'
