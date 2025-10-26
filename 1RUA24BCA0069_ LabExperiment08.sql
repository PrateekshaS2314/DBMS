-- Lab Experiment 08: Implementation of Procedure ( insert, update and delete)
-- STUDENT NAME: PRATEEKSHA S
-- USN: 1RUA24BCA0069
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- 'root@localhost', 'LAPTOP-P28LNMN8', '8.4.6', '2025-10-13 11:23:04';

-- Scenario: Employee Management System
-- CREATE AND LOAD THE database DBLab008
-- Write your SQL query below Codespace:

Create database DBLab008;
use DBLab008;

-- Task 1: Create the Employee Table
-- Create a table to store information about Employee.
-- Include the following columns:
 --   empid INT PRIMARY KEY,
   -- empname VARCHAR(50),
   -- age INT,
   -- salary DECIMAL(10,2),
   -- designation VARCHAR(30),
   -- address VARCHAR(100),
   -- date_of_join DATE
-- Write your SQL query below Codespace:

create table Employee
( empid INT PRIMARY KEY,
  empname VARCHAR(50),
  age INT,
  salary DECIMAL(10,2),
  designation VARCHAR(30),
  address VARCHAR(100),
  date_of_join DATE);
  
-- DESCRIBE THE SCHEMA -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
desc Employee;

-- 'empid', 'int', 'NO', 'PRI', NULL, ''
-- 'empname', 'varchar(50)', 'YES', '', NULL, ''
-- 'age', 'int', 'YES', '', NULL, ''
-- 'salary', 'decimal(10,2)', 'YES', '', NULL, ''
-- 'designation', 'varchar(30)', 'YES', '', NULL, ''
-- 'address', 'varchar(100)', 'YES', '', NULL, ''
-- 'date_of_join', 'date', 'YES', '', NULL, ''

-- insert 10 records to the table 
-- Write your SQL query below Codespace:

insert into Employee values
(100, 'Lisa', 24, 13000, 'HR', 'abc', '1999-02-23'),
(101, 'John', 25, 23000, 'IT', 'xyz', '1998-04-15'),
(102, 'Emma', 27, 33000, 'Finance', 'def', '1997-09-05'),
(103, 'Michael', 28, 43000, 'HR', 'ghi', '1996-12-11'),
(104, 'Sophia', 26, 53000, 'Marketing', 'jkl', '1999-06-18'),
(105, 'Daniel', 30, 48000, 'Sales', 'mno', '1995-03-29'),
(106, 'Olivia', 23, 29000, 'IT', 'pqr', '2000-10-02'),
(107, 'James', 29, 37000, 'Finance', 'stu', '1996-08-19'),
(108, 'Ava', 24, 33000, 'HR', 'vwx', '1999-01-12'),
(109, 'Ethan', 22, 21000, 'Support', 'yz', '2001-07-07');
-- COPYPASTE OF THE OUTPUT in CSV Format and terminate with ;
select * from Employee;

-- # empid, empname, age, salary, designation, address, date_of_join
-- '100', 'Lisa', '24', '13000.00', 'HR', 'abc', '1999-02-23'
-- '101', 'John', '25', '23000.00', 'IT', 'xyz', '1998-04-15'
-- '102', 'Emma', '27', '33000.00', 'Finance', 'def', '1997-09-05'
-- '103', 'Michael', '28', '43000.00', 'HR', 'ghi', '1996-12-11'
-- '104', 'Sophia', '26', '53000.00', 'Marketing', 'jkl', '1999-06-18'
-- '105', 'Daniel', '30', '48000.00', 'Sales', 'mno', '1995-03-29'
-- '106', 'Olivia', '23', '29000.00', 'IT', 'pqr', '2000-10-02'
-- '107', 'James', '29', '37000.00', 'Finance', 'stu', '1996-08-19'
-- '108', 'Ava', '24', '33000.00', 'HR', 'vwx', '1999-01-12'
-- '109', 'Ethan', '22', '21000.00', 'Support', 'yz', '2001-07-07'

-- perform the following procedures on the employee database and copy paste the output in the space provided
-- A. Insert Procedure

-- 1. Write a stored procedure named InsertEmployee to insert a new employee record into the Employee table with all fields as input parameters.
DELIMITER $$
CREATE PROCEDURE InsertEmployee(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    INSERT INTO Employee VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
END $$
DELIMITER ;
call InsertEmployee(110,'Arjun',30,50000,'HR','pqr','1995-12-30');
select * from Employee; 
-- # empid, empname, age, salary, designation, address, date_of_join
-- '100', 'Lisa', '24', '13000.00', 'HR', 'abc', '1999-02-23'
-- '101', 'John', '25', '23000.00', 'IT', 'xyz', '1998-04-15'
-- '102', 'Emma', '27', '33000.00', 'Finance', 'def', '1997-09-05'
-- '103', 'Michael', '28', '43000.00', 'HR', 'ghi', '1996-12-11'
-- '104', 'Sophia', '26', '53000.00', 'Marketing', 'jkl', '1999-06-18'
-- '105', 'Daniel', '30', '48000.00', 'Sales', 'mno', '1995-03-29'
-- '106', 'Olivia', '23', '29000.00', 'IT', 'pqr', '2000-10-02'
-- '107', 'James', '29', '37000.00', 'Finance', 'stu', '1996-08-19'
-- '108', 'Ava', '24', '33000.00', 'HR', 'vwx', '1999-01-12'
-- '109', 'Ethan', '22', '21000.00', 'Support', 'yz', '2001-07-07'
-- '110', 'Arjun', '30', '50000.00', 'HR', 'pqr', '1995-12-30'

-- 2. Modify the insert procedure to ensure the employee’s age must be between 18 and 60.
      -- If not, display a message: "Invalid age, employee not added."
      
      DELIMITER $$
CREATE PROCEDURE InsertEmployeeAgeCheck(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    IF p_age BETWEEN 18 AND 60 THEN
        INSERT INTO Employee VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
    ELSE
        SELECT 'Invalid age, employee not added.' AS Message;
    END IF;
END $$
DELIMITER ;
CALL InsertEmployeeAgeCheck(111, 'Kumar', 16, 25000, 'Intern', 'Delhi', '2024-03-15');
-- # Message
-- 'Invalid age, employee not added.'

-- 3. Create a procedure that inserts a new employee record.
          -- If the salary is not provided, assign a default salary of 20000.
          
          DELIMITER $$
CREATE PROCEDURE InsertEmployeeDefaultSalary(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    IF p_salary IS NULL THEN
        SET p_salary = 20000;
    END IF;
    INSERT INTO Employee VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
END $$
DELIMITER ;
CALL InsertEmployeeDefaultSalary(113, 'Meera Dey', 27, NULL, 'Assistant', 'Mysore', '2024-04-10');
select * from Employee;
-- # empid, empname, age, salary, designation, address, date_of_join
-- '100', 'Lisa', '24', '13000.00', 'HR', 'abc', '1999-02-23'
-- '101', 'John', '25', '23000.00', 'IT', 'xyz', '1998-04-15'
-- '102', 'Emma', '27', '33000.00', 'Finance', 'def', '1997-09-05'
-- '103', 'Michael', '28', '43000.00', 'HR', 'ghi', '1996-12-11'
-- '104', 'Sophia', '26', '53000.00', 'Marketing', 'jkl', '1999-06-18'
-- '105', 'Daniel', '30', '48000.00', 'Sales', 'mno', '1995-03-29'
-- '106', 'Olivia', '23', '29000.00', 'IT', 'pqr', '2000-10-02'
-- '107', 'James', '29', '37000.00', 'Finance', 'stu', '1996-08-19'
-- '108', 'Ava', '24', '33000.00', 'HR', 'vwx', '1999-01-12'
-- '109', 'Ethan', '22', '21000.00', 'Support', 'yz', '2001-07-07'
-- '110', 'Arjun', '30', '50000.00', 'HR', 'pqr', '1995-12-30'
-- '113', 'Meera Dey', '27', '20000.00', 'Assistant', 'Mysore', '2024-04-10'

-- 4. Write a procedure that inserts three new employee records in a single procedure using multiple INSERT statements.
DELIMITER $$
CREATE PROCEDURE InsertMultipleEmployees()
BEGIN
    INSERT INTO Employee VALUES (114, 'Raj Patel', 31, 42000, 'Developer', 'Delhi', '2024-02-01');
    INSERT INTO Employee VALUES (115, 'Simran Kaur', 26, 38000, 'Designer', 'Mumbai', '2024-03-12');
    INSERT INTO Employee VALUES (116, 'Tina George', 29, 40000, 'Analyst', 'Pune', '2024-03-20');
END $$
DELIMITER ;
CALL InsertMultipleEmployees();
select * from Employee;
-- # empid, empname, age, salary, designation, address, date_of_join
-- '100', 'Lisa', '24', '13000.00', 'HR', 'abc', '1999-02-23'
-- '101', 'John', '25', '23000.00', 'IT', 'xyz', '1998-04-15'
-- '102', 'Emma', '27', '33000.00', 'Finance', 'def', '1997-09-05'
-- '103', 'Michael', '28', '43000.00', 'HR', 'ghi', '1996-12-11'
-- '104', 'Sophia', '26', '53000.00', 'Marketing', 'jkl', '1999-06-18'
-- '105', 'Daniel', '30', '48000.00', 'Sales', 'mno', '1995-03-29'
-- '106', 'Olivia', '23', '29000.00', 'IT', 'pqr', '2000-10-02'
-- '107', 'James', '29', '37000.00', 'Finance', 'stu', '1996-08-19'
-- '108', 'Ava', '24', '33000.00', 'HR', 'vwx', '1999-01-12'
-- '109', 'Ethan', '22', '21000.00', 'Support', 'yz', '2001-07-07'
-- '110', 'Arjun', '30', '50000.00', 'HR', 'pqr', '1995-12-30'
-- '113', 'Meera Dey', '27', '20000.00', 'Assistant', 'Mysore', '2024-04-10'
-- '114', 'Raj Patel', '31', '42000.00', 'Developer', 'Delhi', '2024-02-01'
-- '115', 'Simran Kaur', '26', '38000.00', 'Designer', 'Mumbai', '2024-03-12'
-- '116', 'Tina George', '29', '40000.00', 'Analyst', 'Pune', '2024-03-20'

-- B.  Update Procedure

-- Update Salary:
-- Write a stored procedure named UpdateSalary to update an employee’s salary based on their empid.
DELIMITER $$
CREATE PROCEDURE UpdateSalary(IN p_empid INT, IN p_new_salary DECIMAL(10,2))
BEGIN
    UPDATE Employee SET salary = p_new_salary WHERE empid = p_empid;
END $$
DELIMITER ;
CALL UpdateSalary(101, 40000);

-- Increment Salary by Percentage:
-- Create a procedure to increase the salary by 10% for all employees whose designation = 'Manager'.
DELIMITER $$
CREATE PROCEDURE IncrementManagerSalary()
BEGIN
    UPDATE Employee
    SET salary = salary * 1.10
    WHERE designation = 'Manager';
END $$
DELIMITER ;

-- Update Designation:
-- Write a procedure to update the designation of an employee by empid.
-- Example: Promote an employee from 'Clerk' to 'Senior Clerk'.
DELIMITER $$
CREATE PROCEDURE UpdateDesignation(IN p_empid INT, IN p_new_desg VARCHAR(30))
BEGIN
    UPDATE Employee SET designation = p_new_desg WHERE empid = p_empid;
END $$
DELIMITER ;

-- Update Address:
-- Write a procedure to update the address of an employee when empid is given as input.
DELIMITER $$
CREATE PROCEDURE UpdateAddress(IN p_empid INT, IN p_new_address VARCHAR(100))
BEGIN
    UPDATE Employee SET address = p_new_address WHERE empid = p_empid;
END $$
DELIMITER ;

-- Conditional Update (Age Check):
-- Create a procedure that updates salary only if the employee’s age > 40; otherwise, print "Not eligible for salary update."
DELIMITER $$
CREATE PROCEDURE UpdateSalaryAgeCheck(IN p_empid INT, IN p_new_salary DECIMAL(10,2))
BEGIN
    IF (SELECT age FROM Employee WHERE empid = p_empid) > 40 THEN
        UPDATE Employee SET salary = p_new_salary WHERE empid = p_empid;
    ELSE
        SELECT 'Not eligible for salary update.' AS Message;
    END IF;
END $$
DELIMITER ;

-- C. Delete Procedure

-- Delete by empid:
-- Write a stored procedure named DeleteEmployee to delete an employee record using their empid.
DELIMITER $$
CREATE PROCEDURE DeleteEmployee(IN p_empid INT)
BEGIN
    DELETE FROM Employee WHERE empid = p_empid;
END $$
DELIMITER ;

-- Delete by Designation:
-- Create a procedure that deletes all employees belonging to a specific designation (e.g., 'Intern').
DELIMITER $$
CREATE PROCEDURE DeleteByDesignation(IN p_designation VARCHAR(30))
BEGIN
    DELETE FROM Employee WHERE designation = p_designation;
END $$
DELIMITER ;

-- Delete Based on Salary Range:
-- Write a procedure to delete employees whose salary is less than ₹15000.
DELIMITER $$
CREATE PROCEDURE DeleteLowSalary()
BEGIN
    DELETE FROM Employee WHERE salary < 15000;
END $$
DELIMITER ;

-- Delete by Joining Year:
-- Write a procedure to delete employees who joined before the year 2015.
DELIMITER $$
CREATE PROCEDURE DeleteOldEmployees()
BEGIN
    DELETE FROM Employee WHERE YEAR(date_of_join) < 2015;
END $$
DELIMITER ;

-- End of Lab Experiment 
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01