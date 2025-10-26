-- Lab Experiment 04: Implement arithmetic, logical, comparison, special, and set operators in SQL using the Employees and Departments tables.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: PRATEEKSHA S
-- USN: 1RUA24BCA0069
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- 'root@localhost', 'LAPTOP-P28LNMN8', '8.4.6', '2025-09-15 11:38:06'

-- Write your code below this line along with the output 
create database University;
use University;

CREATE TABLE Employees (  
    EmployeeID INT PRIMARY KEY,  
    Name VARCHAR(100),  
    Age INT,  
    Salary DECIMAL(10,2),  
    DepartmentID INT,  
    HireDate DATE,  
    Address VARCHAR(255)  
);  

INSERT INTO Employees VALUES  
(1, 'Alice Johnson', 30, 60000, 1, '2020-03-15', '123 Main St, City A'),  
(2, 'Bob Smith', 28, 55000, 2, '2021-06-20', '456 Oak St, City B'),  
(3, 'Charlie Brown', 35, 75000, 3, '2019-01-10', '789 Pine St, City C'),  
(4, 'David Wilson', 40, 90000, 3, '2018-07-25', '101 Maple St, City D'),  
(5, 'Emma Davis', 27, 50000, 4, '2022-09-30', '202 Birch St, City E'),  
(6, 'Frank Miller', 32, 70000, 5, '2020-11-18', '303 Cedar St, City F'),  
(7, 'Grace Lee', 29, 58000, 1, '2021-04-05', '404 Walnut St, City G'),  
(8, 'Hank Adams', 45, 98000, 2, '2017-12-12', '505 Spruce St, City H'),  
(9, 'Ivy Green', 31, 64000, 4, '2023-02-14', '606 Redwood St, City I'),  
(10, 'Jack White', 38, 85000, 5, '2019-08-08', '707 Elm St, City J');  

-- TABLE:02 Department Table

CREATE TABLE Departments (  
    DepartmentID INT PRIMARY KEY,  
    DepartmentName VARCHAR(50)  
);  

INSERT INTO Departments VALUES  
(1, 'HR'),  
(2, 'Finance'),  
(3, 'Engineering'),  
(4, 'Marketing'),  
(5, 'Sales');  


-- TASK FOR STUDENTS 


-- Exercise 1: Arithmetic Operators
-- Addition, Subtraction, Multiplication, Division
-- Q1 - Add a bonus (10% of Salary) to each employee’s salary.

-- Q2 - Subtract tax (15% of Salary) from each employee’s salary.

-- Q3 - Calculate the yearly salary from the monthly salary.

-- -- Modulus Operator
-- Q4 - Find the remainder when employees’ ages are divided by 5.

-- Write your code below this line along with the output 

  select Salary+(0.1*Salary) as Bonus from Employees;
--   # Bonus
-- '66000.000'
-- '60500.000'
-- '82500.000'
-- '99000.000'
-- '55000.000'
-- '77000.000'
-- '63800.000'
-- '107800.000'
-- '70400.000'
-- '93500.000'

select Salary-(0.15*Salary) as Tax from Employees;
--   # Tax
-- '51000.0000'
-- '46750.0000'
-- '63750.0000'
-- '76500.0000'
-- '42500.0000'
-- '59500.0000'
-- '49300.0000'
-- '83300.0000'
-- '54400.0000'
-- '72250.0000'

select Salary*12 as YearlySalary from Employees;
--  # YearlySalary
-- '720000.00'
-- '660000.00'
-- '900000.00'
-- '1080000.00'
-- '600000.00'
-- '840000.00'
-- '696000.00'
-- '1176000.00'
-- '768000.00'
-- '1020000.00'

select Age%5 as ModulusAge from Employees;
--  # ModulusAge
-- '0'
-- '3'
-- '0'
-- '0'
-- '2'
-- '2'
-- '4'
-- '0'
-- '1'
-- '3'

  


--  Exercise 2: Logical Operators: AND, OR, NOT

-- Q5 - Retrieve employees older than 30 AND with salary > 50000.

-- Q6 - Retrieve employees in the HR department (ID=1) OR earning > 70000.

-- Q7 - Retrieve employees NOT living in City G.




-- Write your code below this line along with the output 

select * from Employees where Age>30 and Salary>50000;
--  # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '3', 'Charlie Brown', '35', '75000.00', '3', '2019-01-10', '789 Pine St, City C'
-- '4', 'David Wilson', '40', '90000.00', '3', '2018-07-25', '101 Maple St, City D'
-- '6', 'Frank Miller', '32', '70000.00', '5', '2020-11-18', '303 Cedar St, City F'
-- '8', 'Hank Adams', '45', '98000.00', '2', '2017-12-12', '505 Spruce St, City H'
-- '9', 'Ivy Green', '31', '64000.00', '4', '2023-02-14', '606 Redwood St, City I'
-- '10', 'Jack White', '38', '85000.00', '5', '2019-08-08', '707 Elm St, City J'

select * from Employees where DepartmentID=1 or Salary>70000;
--  # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'
-- '3', 'Charlie Brown', '35', '75000.00', '3', '2019-01-10', '789 Pine St, City C'
-- '4', 'David Wilson', '40', '90000.00', '3', '2018-07-25', '101 Maple St, City D'
-- '7', 'Grace Lee', '29', '58000.00', '1', '2021-04-05', '404 Walnut St, City G'
-- '8', 'Hank Adams', '45', '98000.00', '2', '2017-12-12', '505 Spruce St, City H'
-- '10', 'Jack White', '38', '85000.00', '5', '2019-08-08', '707 Elm St, City J'

select * from Employees where Address not like '%City G';
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'
-- '2', 'Bob Smith', '28', '55000.00', '2', '2021-06-20', '456 Oak St, City B'
-- '3', 'Charlie Brown', '35', '75000.00', '3', '2019-01-10', '789 Pine St, City C'
-- '4', 'David Wilson', '40', '90000.00', '3', '2018-07-25', '101 Maple St, City D'
-- '5', 'Emma Davis', '27', '50000.00', '4', '2022-09-30', '202 Birch St, City E'
-- '6', 'Frank Miller', '32', '70000.00', '5', '2020-11-18', '303 Cedar St, City F'
-- '8', 'Hank Adams', '45', '98000.00', '2', '2017-12-12', '505 Spruce St, City H'
-- '9', 'Ivy Green', '31', '64000.00', '4', '2023-02-14', '606 Redwood St, City I'
-- '10', 'Jack White', '38', '85000.00', '5', '2019-08-08', '707 Elm St, City J'


--  Exercise 3: Comparison Operators

-- Q8 - Equality, Inequality, Greater Than, Less Than

-- Q9 - Find employees with salary = 60000.

-- Q10 - List employees not in the IT department (no IT department exists; returns all).

-- Q11 - Retrieve employees younger than 25 with salary > 50000 

-- Q12 - List employees aged 25–35.

-- Q13 - Find employees in HR, Finance, or Engineering (IDs 1, 2, 3).

-- Q14 - Find employees with names starting with A.

-- Q15 - List employees with no address.


-- Write your code below this line along with the output 

select * from Employees where Salary = 60000;
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'

select * from Employees where DepartmentID < 6;
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'
-- '2', 'Bob Smith', '28', '55000.00', '2', '2021-06-20', '456 Oak St, City B'
-- '3', 'Charlie Brown', '35', '75000.00', '3', '2019-01-10', '789 Pine St, City C'
-- '4', 'David Wilson', '40', '90000.00', '3', '2018-07-25', '101 Maple St, City D'
-- '5', 'Emma Davis', '27', '50000.00', '4', '2022-09-30', '202 Birch St, City E'
-- '6', 'Frank Miller', '32', '70000.00', '5', '2020-11-18', '303 Cedar St, City F'
-- '7', 'Grace Lee', '29', '58000.00', '1', '2021-04-05', '404 Walnut St, City G'
-- '8', 'Hank Adams', '45', '98000.00', '2', '2017-12-12', '505 Spruce St, City H'
-- '9', 'Ivy Green', '31', '64000.00', '4', '2023-02-14', '606 Redwood St, City I'
-- '10', 'Jack White', '38', '85000.00', '5', '2019-08-08', '707 Elm St, City J'


select * from Employees where Age<25 AND Salary > 50000;
# EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- null

select * from Employees where Age>25 and Age<35;
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'
-- '2', 'Bob Smith', '28', '55000.00', '2', '2021-06-20', '456 Oak St, City B'
-- '5', 'Emma Davis', '27', '50000.00', '4', '2022-09-30', '202 Birch St, City E'
-- '6', 'Frank Miller', '32', '70000.00', '5', '2020-11-18', '303 Cedar St, City F'
-- '7', 'Grace Lee', '29', '58000.00', '1', '2021-04-05', '404 Walnut St, City G'
-- '9', 'Ivy Green', '31', '64000.00', '4', '2023-02-14', '606 Redwood St, City I'

select * from Employees where DepartmentID in(1,2,3);
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'
-- '2', 'Bob Smith', '28', '55000.00', '2', '2021-06-20', '456 Oak St, City B'
-- '3', 'Charlie Brown', '35', '75000.00', '3', '2019-01-10', '789 Pine St, City C'
-- '4', 'David Wilson', '40', '90000.00', '3', '2018-07-25', '101 Maple St, City D'
-- '7', 'Grace Lee', '29', '58000.00', '1', '2021-04-05', '404 Walnut St, City G'
-- '8', 'Hank Adams', '45', '98000.00', '2', '2017-12-12', '505 Spruce St, City H'

select * from Employees where Name like 'A%';
-- # EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- '1', 'Alice Johnson', '30', '60000.00', '1', '2020-03-15', '123 Main St, City A'

select * from Employees where Address is null;
# EmployeeID, Name, Age, Salary, DepartmentID, HireDate, Address
-- null


 

-- Exercise 5: Set Operators: UNION.

-- Q16 - Retrieve names from the HR department hired in 2022 OR 2023.

-- Q17 - Find common employees in the Engineering department (ID=3) hired before and after 2020.

-- Q18 - Find employees hired in 2023 but not in 2022.