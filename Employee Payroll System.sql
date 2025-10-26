CREATE DATABASE Payroll;
USE Payroll;

CREATE TABLE Departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100),
  location VARCHAR(100)
);

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(100),
  dept_id INT,
  join_date DATE,
  designation VARCHAR(50),
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Salaries (
  salary_id INT PRIMARY KEY,
  emp_id INT,
  basic DECIMAL(10,2),
  hra DECIMAL(10,2),
  allowances DECIMAL(10,2),
  pay_month DATE,
  FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- Sample data
INSERT INTO Departments VALUES
(10,'Engineering','Bangalore'),
(20,'HR','Mumbai'),
(30,'Sales','Delhi'),
(40,'Finance','Chennai'),
(50,'Support','Kolkata');

INSERT INTO Employees VALUES
(1,'Priya Nair',10,'2021-06-01','Software Engineer'),
(2,'Arjun Verma',10,'2020-09-15','Senior Developer'),
(3,'Neelam Gupta',20,'2019-11-20','HR Manager'),
(4,'Suresh Kumar',30,'2022-01-10','Sales Executive'),
(5,'Maya Joshi',40,'2018-03-05','Accountant');

INSERT INTO Salaries VALUES
(5001,1,50000.00,10000.00,5000.00,'2025-04-01'),
(5002,2,70000.00,14000.00,7000.00,'2025-04-01'),
(5003,3,45000.00,9000.00,4000.00,'2025-04-01'),
(5004,4,35000.00,7000.00,3000.00,'2025-04-01'),
(5005,5,60000.00,12000.00,6000.00,'2025-04-01');

-- Queries

-- 1. Total and average salary (gross) per department
SELECT d.dept_id, d.dept_name,
       SUM(s.basic + s.hra + s.allowances) AS Total_Payroll,
       AVG(s.basic + s.hra + s.allowances) AS Avg_Pay
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
JOIN Salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_id, d.dept_name;

-- # dept_id, dept_name, Total_Payroll, Avg_Pay
-- '10', 'Engineering', '156000.00', '78000.000000'
-- '20', 'HR', '58000.00', '58000.000000'
-- '30', 'Sales', '45000.00', '45000.000000'
-- '40', 'Finance', '78000.00', '78000.000000'

-- 2. Employees with salary > X
SELECT e.emp_id, e.name, (s.basic + s.hra + s.allowances) AS Gross
FROM Employees e
JOIN Salaries s ON e.emp_id = s.emp_id
WHERE (s.basic + s.hra + s.allowances) > 80000;

-- # emp_id, name, Gross
-- '2', 'Arjun Verma', '91000.00'

-- 3. Join employee and department details
SELECT e.emp_id, e.name, d.dept_name, e.designation, e.join_date
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- # emp_id, name, dept_name, designation, join_date
-- '1', 'Priya Nair', 'Engineering', 'Software Engineer', '2021-06-01'
-- '2', 'Arjun Verma', 'Engineering', 'Senior Developer', '2020-09-15'
-- '3', 'Neelam Gupta', 'HR', 'HR Manager', '2019-11-20'
-- '4', 'Suresh Kumar', 'Sales', 'Sales Executive', '2022-01-10'
-- '5', 'Maya Joshi', 'Finance', 'Accountant', '2018-03-05'

-- Procedure to insert salary
DELIMITER //

CREATE PROCEDURE InsertSalary(
  IN sid INT,
  IN emp INT,
  IN basic_in DECIMAL(10,2),
  IN hra_in DECIMAL(10,2),
  IN allow_in DECIMAL(10,2),
  IN pmonth DATE
)
BEGIN
  INSERT INTO Salaries (salary_id, emp_id, basic, hra, allowances, pay_month)
  VALUES (sid, emp, basic_in, hra_in, allow_in, pmonth);
END //

DELIMITER ;
CALL InsertSalary(5006, 1, 52000.00, 10400.00, 5200.00, '2025-05-01');
SELECT * FROM Salaries;

-- # salary_id, emp_id, basic, hra, allowances, pay_month
-- '5001', '1', '50000.00', '10000.00', '5000.00', '2025-04-01'
-- '5002', '2', '70000.00', '14000.00', '7000.00', '2025-04-01'
-- '5003', '3', '45000.00', '9000.00', '4000.00', '2025-04-01'
-- '5004', '4', '35000.00', '7000.00', '3000.00', '2025-04-01'
-- '5005', '5', '60000.00', '12000.00', '6000.00', '2025-04-01'
-- '5006', '1', '52000.00', '10400.00', '5200.00', '2025-05-01'

-- Procedure to update basic pay
DELIMITER //

CREATE PROCEDURE UpdateBasicPay(
  IN emp INT,
  IN new_basic DECIMAL(10,2)
)
BEGIN
  UPDATE Salaries
  SET basic = new_basic
  WHERE emp_id = emp
  ORDER BY pay_month DESC
  LIMIT 1;
END //

DELIMITER ;
CALL UpdateBasicPay(2, 75000.00);
SELECT * FROM Salaries;

-- # salary_id, emp_id, basic, hra, allowances, pay_month
-- '5001', '1', '50000.00', '10000.00', '5000.00', '2025-04-01'
-- '5002', '2', '75000.00', '14000.00', '7000.00', '2025-04-01'
-- '5003', '3', '45000.00', '9000.00', '4000.00', '2025-04-01'
-- '5004', '4', '35000.00', '7000.00', '3000.00', '2025-04-01'
-- '5005', '5', '60000.00', '12000.00', '6000.00', '2025-04-01'
-- '5006', '1', '52000.00', '10400.00', '5200.00', '2025-05-01'
