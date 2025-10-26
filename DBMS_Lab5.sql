-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: PRATEEKSHA S
-- USN: 1RUA24BCA0069
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Write your code below this line along with the output 
-- 'root@localhost', 'LAPTOP-P28LNMN8', '8.4.6', '2025-09-22 11:25:13'

create database Resturant;
use Resturant;
-- table 01: Customers
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)
create table Customers
(customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50));
-- insert 5 records
insert into Customers values
(100, 'Lisa', 'Bangalore'),
(101, 'Lilly', 'Mysore'),
(102, 'John', 'Humpi'),
(103, 'Priya', 'Manglore'),
(104, 'Arjun', 'Chennai');

-- TABLE:02 Orders Table

-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,
create table Orders
(order_id INT PRIMARY KEY,
customer_id INT,
foreign key(customer_id) references Customers(customer_id),
product_name VARCHAR(50),
order_date DATE);

    -- insert 5 records
insert into Orders values
(200, 103, 'Comb', '2020-04-12'),
(201, 104, 'Watch', '2025-10-20'),
(202, 101, 'Ring', '2024-11-11'),
(203, 100, 'Phone', '2019-12-31'),
(204, 102, 'shoe', '2022-05-06');


select * from Customers;
-- # customer_id, customer_name, city
-- '100', 'Lisa', 'Bangalore'
-- '101', 'Lilly', 'Mysore'
-- '102', 'John', 'Humpi'
-- '103', 'Priya', 'Manglore'
-- '104', 'Arjun', 'Chennai'

select * from Orders;
-- # order_id, customer_id, product_name, order_date
-- '200', '103', 'Comb', '2020-04-12'
-- '201', '104', 'Watch', '2025-10-20'
-- '202', '101', 'Ring', '2024-11-11'
-- '203', '100', 'Phone', '2019-12-31'
-- '204', '102', 'shoe', '2022-05-06'

-- TASK FOR STUDENTS 

 
-- Write and Execute Queries
/*
1. Inner Join – 
   Find all orders placed by customers from the city "Bangalore."
   List all customers with the products they ordered.
   Show customer names and their order dates.
   Display order IDs with the corresponding customer names.
   Find the number of orders placed by each customer.
   Show city names along with the products ordered by customers.
*/
SELECT c.customer_name, o.product_name FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id WHERE c.city = 'Bangalore';
-- # customer_name, product_name
-- 'Lisa', 'Phone'
SELECT c.customer_name, o.product_name FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_name, product_name
-- 'Lisa', 'Phone'
-- 'Lilly', 'Ring'
-- 'John', 'shoe'
-- 'Priya', 'Comb'
-- 'Arjun', 'Watch'
SELECT c.customer_name, o.order_date FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_name, order_date
-- 'Lisa', '2019-12-31'
-- 'Lilly', '2024-11-11'
-- 'John', '2022-05-06'
-- 'Priya', '2020-04-12'
-- 'Arjun', '2025-10-20'
SELECT o.order_id, c.customer_name FROM Customers c INNER JOIN Orders o ON o.customer_id = c.customer_id;
-- # order_id, customer_name
-- '203', 'Lisa'
-- '202', 'Lilly'
-- '204', 'John'
-- '200', 'Priya'
-- '201', 'Arjun'
SELECT c.city, o.product_name FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id;
-- # city, product_name
-- 'Bangalore', 'Phone'
-- 'Mysore', 'Ring'
-- 'Humpi', 'shoe'
-- 'Manglore', 'Comb'
-- 'Chennai', 'Watch'

/* 
2  Left Outer Join – 
    Find all customers and their orders, even if a customer has no orders.
    List all customers and the products they ordered.
    Show customer IDs, names, and their order IDs.
    Find the total number of orders (if any) placed by each customer.
    Retrieve customers who have not placed any orders.
	Display customer names with their order dates.
-- Write your code below this line along with the output 
*/
 SELECT c.customer_id,c.customer_name, o.order_id FROM Customers c LEFT OUTER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_id, customer_name, order_id
-- '100', 'Lisa', '203'
-- '101', 'Lilly', '202'
-- '102', 'John', '204'
-- '103', 'Priya', '200'
-- '104', 'Arjun', '201'
 SELECT c.customer_name, o.product_name FROM Customers c LEFT OUTER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_name, product_name
-- 'Lisa', 'Phone'
-- 'Lilly', 'Ring'
-- 'John', 'shoe'
-- 'Priya', 'Comb'
-- 'Arjun', 'Watch'
 SELECT c.customer_id,c.customer_name, o.order_id FROM Customers c LEFT OUTER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_id, customer_name, order_id
-- '100', 'Lisa', '203'
-- '101', 'Lilly', '202'
-- '102', 'John', '204'
-- '103', 'Priya', '200'
-- '104', 'Arjun', '201'
SELECT c.customer_name, o.order_date FROM Customers c LEFT OUTER JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_name, order_date
-- 'Lisa', '2019-12-31'
-- 'Lilly', '2024-11-11'
-- 'John', '2022-05-06'
-- 'Priya', '2020-04-12'
-- 'Arjun', '2025-10-20'

 
/* 3: Right Outer Join – 
      Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
      Show all orders with the customer names.
      Display product names with the customers who ordered them.
	  List order IDs with customer cities.
      Find the number of orders per customer (include those without orders).
	  Retrieve customers who do not have any matching orders.
     Write your code below this line along with the output 
 */
SELECT o.order_id, c.customer_name FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # order_id, customer_name
-- '203', 'Lisa'
-- '202', 'Lilly'
-- '204', 'John'
-- '200', 'Priya'
-- '201', 'Arjun'
SELECT o.order_id,o.product_name, c.customer_name FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # order_id, product_name, customer_name
-- '200', 'Comb', 'Priya'
-- '201', 'Watch', 'Arjun'
-- '202', 'Ring', 'Lilly'
-- '203', 'Phone', 'Lisa'
-- '204', 'shoe', 'John'
SELECT o.product_name, c.customer_name FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # product_name, customer_name
-- 'Comb', 'Priya'
-- 'Watch', 'Arjun'
-- 'Ring', 'Lilly'
-- 'Phone', 'Lisa'
-- 'shoe', 'John'
SELECT o.order_id, c.city FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # order_id, city
-- '203', 'Bangalore'
-- '202', 'Mysore'
-- '204', 'Humpi'
-- '200', 'Manglore'
-- '201', 'Chennai'

/* 4: Full Outer Join – 
        Find all customers and their orders, including those customers with no orders and orders without a customer.
        List all customers and products, whether they placed an order or not.
        Show customer IDs with order IDs (include unmatched ones).
		Display customer names with order dates.
		Find all unmatched records (customers without orders and orders without customers).
        Show customer cities with products.
     Write your code below this line along with the output 
  */   
SELECT c.customer_name, o.product_name FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_name, o.product_name FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_name, product_name
-- 'Lisa', 'Phone'
-- 'Lilly', 'Ring'
-- 'John', 'shoe'
-- 'Priya', 'Comb'
-- 'Arjun', 'Watch'
SELECT c.customer_id, o.order_id FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, o.order_id FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- # customer_id, order_id
-- '100', '203'
-- '101', '202'
-- '102', '204'
-- '103', '200'
-- '104', '201'
SELECT c.customer_name, o.product_name FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL
UNION
SELECT c.customer_name, o.product_name FROM Customers c RIGHT JOIN Orders o ON c.customer_id = o.customer_id WHERE c.customer_id IS NULL;
-- null

-- 5: Natural Join – 
--           Find all orders placed by customers.
--           List all customers with the products they ordered using NATURAL JOIN.
--           Show customer names along with their order dates using NATURAL JOIN.
--           Find all customer cities and the products ordered by those customers using NATURAL JOIN.

--      Write your code below this line along with the output 
SELECT * FROM Customers NATURAL JOIN Orders;
-- # customer_id, customer_name, city, order_id, product_name, order_date
-- '100', 'Lisa', 'Bangalore', '203', 'Phone', '2019-12-31'
-- '101', 'Lilly', 'Mysore', '202', 'Ring', '2024-11-11'
-- '102', 'John', 'Humpi', '204', 'shoe', '2022-05-06'
-- '103', 'Priya', 'Manglore', '200', 'Comb', '2020-04-12'
-- '104', 'Arjun', 'Chennai', '201', 'Watch', '2025-10-20'
SELECT customer_name, product_name FROM Customers NATURAL JOIN Orders;
-- # customer_name, product_name
-- 'Lisa', 'Phone'
-- 'Lilly', 'Ring'
-- 'John', 'shoe'
-- 'Priya', 'Comb'
-- 'Arjun', 'Watch'
SELECT customer_name, order_date FROM Customers NATURAL JOIN Orders;
-- # customer_name, order_date
-- 'Lisa', '2019-12-31'
-- 'Lilly', '2024-11-11'
-- 'John', '2022-05-06'
-- 'Priya', '2020-04-12'
-- 'Arjun', '2025-10-20'
SELECT city, product_name FROM Customers NATURAL JOIN Orders;
-- # city, product_name
-- 'Bangalore', 'Phone'
-- 'Mysore', 'Ring'
-- 'Humpi', 'shoe'
-- 'Manglore', 'Comb'
-- 'Chennai', 'Watch'

-- END OF THE EXPERIMENT