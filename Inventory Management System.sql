CREATE DATABASE Inventory;
USE Inventory;

CREATE TABLE Suppliers (
  supplier_id INT PRIMARY KEY,
  name VARCHAR(100),
  contact VARCHAR(50)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(200),
  unit_price DECIMAL(10,2)
);

CREATE TABLE Supplies (
  supply_id INT PRIMARY KEY,
  supplier_id INT,
  product_id INT,
  supply_date DATE,
  quantity INT,
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample data
INSERT INTO Suppliers VALUES
(1,'Global Supplies','1111111111'),
(2,'ABC Traders','2222222222'),
(3,'XYZ Wholesalers','3333333333'),
(4,'QuickSupply','4444444444'),
(5,'PrimeSource','5555555555');

INSERT INTO Products VALUES
(2001,'LED Monitor',7000.00),
(2002,'Keyboard',800.00),
(2003,'Mouse',400.00),
(2004,'Laptop',55000.00),
(2005,'Docking Station',3500.00);

INSERT INTO Supplies VALUES
(10001,1,2001,'2025-01-10',20),
(10002,2,2002,'2025-02-15',50),
(10003,1,2003,'2025-03-05',100),
(10004,3,2004,'2025-03-20',10),
(10005,4,2005,'2025-04-01',30);

-- Queries

-- 1. Total quantity supplied per supplier
SELECT s.supplier_id, s.name, SUM(sp.quantity) AS Total_Quantity
FROM Suppliers s
LEFT JOIN Supplies sp ON s.supplier_id = sp.supplier_id
GROUP BY s.supplier_id, s.name
ORDER BY Total_Quantity DESC;
-- # supplier_id, name, Total_Quantity
-- '1', 'Global Supplies', '120'
-- '2', 'ABC Traders', '50'
-- '4', 'QuickSupply', '30'
-- '3', 'XYZ Wholesalers', '10'
-- '5', 'PrimeSource', NULL

-- 2. Total quantity supplied per product in a date range
SELECT p.product_id, p.name, SUM(sp.quantity) AS Qty_Supplied
FROM Products p
JOIN Supplies sp ON p.product_id = sp.product_id
WHERE sp.supply_date BETWEEN '2025-01-01' AND '2025-04-30'
GROUP BY p.product_id, p.name;
-- # product_id, name, Qty_Supplied
-- '2001', 'LED Monitor', '20'
-- '2002', 'Keyboard', '50'
-- '2003', 'Mouse', '100'
-- '2004', 'Laptop', '10'
-- '2005', 'Docking Station', '30'

-- 3. Recent supplies with supplier names
SELECT sp.supply_id, sp.supply_date, sp.quantity, p.name AS product_name, s.name AS supplier_name
FROM Supplies sp
JOIN Products p ON sp.product_id = p.product_id
JOIN Suppliers s ON sp.supplier_id = s.supplier_id
ORDER BY sp.supply_date DESC;
-- # supply_id, supply_date, quantity, product_name, supplier_name
-- '10005', '2025-04-01', '30', 'Docking Station', 'QuickSupply'
-- '10004', '2025-03-20', '10', 'Laptop', 'XYZ Wholesalers'
-- '10003', '2025-03-05', '100', 'Mouse', 'Global Supplies'
-- '10002', '2025-02-15', '50', 'Keyboard', 'ABC Traders'
-- '10001', '2025-01-10', '20', 'LED Monitor', 'Global Supplies'

-- Procedure to insert supply order and return inserted id
DELIMITER //
CREATE PROCEDURE InsertSupply(
  IN sid INT, IN suppid INT, IN prodid INT, IN sdate DATE, IN qty INT
)
BEGIN
  INSERT INTO Supplies VALUES (sid, suppid, prodid, sdate, qty);
END //
DELIMITER ;
CALL InsertSupply(10006, 5, 2004, '2025-05-01', 15);
SELECT * FROM Supplies;
-- # supply_id, supplier_id, product_id, supply_date, quantity
-- '10001', '1', '2001', '2025-01-10', '20'
-- '10002', '2', '2002', '2025-02-15', '50'
-- '10003', '1', '2003', '2025-03-05', '100'
-- '10004', '3', '2004', '2025-03-20', '10'
-- '10005', '4', '2005', '2025-04-01', '30'
-- '10006', '5', '2004', '2025-05-01', '15'

-- Procedure to update supply quantity
DELIMITER //
CREATE PROCEDURE UpdateSupplyQty(
  IN supplyid INT, IN new_qty INT
)
BEGIN
  UPDATE Supplies SET quantity = new_qty WHERE supply_id = supplyid;
END //
DELIMITER ;
CALL UpdateSupplyQty(10003, 120);
SELECT * FROM Supplies;
-- # supply_id, supplier_id, product_id, supply_date, quantity
-- '10001', '1', '2001', '2025-01-10', '20'
-- '10002', '2', '2002', '2025-02-15', '50'
-- '10003', '1', '2003', '2025-03-05', '120'
-- '10004', '3', '2004', '2025-03-20', '10'
-- '10005', '4', '2005', '2025-04-01', '30'
-- '10006', '5', '2004', '2025-05-01', '15'
