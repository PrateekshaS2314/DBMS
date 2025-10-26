create database TechNova;
use TechNova;
create table Department
( dept_id varchar(10) Primary Key,
  dept_name varchar(10),
  location varchar(10));

create table Employee
(emp_id varchar(10) Primary Key,
 emp_name varchar(10),
 age int,
 salary int,
 designation varchar(10),
 address varchar(10),
 date_of_joining Date,
 dept_id varchar(10),
 Foreign Key(dept_id) references Department(dept_id));
 
 insert into Department values
 ('1', 'Tech', 'bangalore'),
 ('2', 'HR', 'mysore'),
 ('3', 'Mangement', 'hampi'),
 ('4', 'Event', 'udupi');

insert into Employee values
('101', 'James', 24, 30000, 'Team Head', 'Bangalore', '2000-10-31', '3'),
('102', 'Sophia', 26, 28000, 'Developer', 'Mumbai', '2001-05-12', '2'),
('103', 'Rahul', 25, 27000, 'Tester', 'Chennai', '1999-11-08', '1'),
('104', 'Emily', 27, 32000, 'Proj Lead', 'Pune', '1998-03-15', '4'),
('105', 'Arjun', 23, 25000, 'Intern', 'Hyderabad', '2002-07-22', '3');

select * from Department;
-- # dept_id, dept_name, location
-- '1', 'Tech', 'bangalore'
-- '2', 'HR', 'mysore'
-- '3', 'Mangement', 'hampi'
-- '4', 'Event', 'udupi'

select * from Employee;
-- # emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id
-- '101', 'James', '24', '30000', 'Team Head', 'Bangalore', '2000-10-31', '3'
-- '102', 'Sophia', '26', '28000', 'Developer', 'Mumbai', '2001-05-12', '2'
-- '103', 'Rahul', '25', '27000', 'Tester', 'Chennai', '1999-11-08', '1'
-- '104', 'Emily', '27', '32000', 'Proj Lead', 'Pune', '1998-03-15', '4'
-- '105', 'Arjun', '23', '25000', 'Intern', 'Hyderabad', '2002-07-22', '3'

UPDATE Employee SET salary = salary + 5000 WHERE designation = 'Developer';
select * from Employee;
-- # emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id
-- '101', 'James', '24', '30000', 'Team Head', 'Bangalore', '2000-10-31', '3'
-- '102', 'Sophia', '26', '33000', 'Developer', 'Mumbai', '2001-05-12', '2'
-- '103', 'Rahul', '25', '27000', 'Tester', 'Chennai', '1999-11-08', '1'
-- '104', 'Emily', '27', '32000', 'Proj Lead', 'Pune', '1998-03-15', '4'
-- '105', 'Arjun', '23', '25000', 'Intern', 'Hyderabad', '2002-07-22', '3'

SELECT dept_id, COUNT(*) AS total_employees, AVG(salary) AS average_salary, MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary
FROM Employee GROUP BY dept_id;
-- # dept_id, total_employees, average_salary, highest_salary, lowest_salary
-- '1', '1', '27000.0000', '27000', '27000'
-- '2', '1', '33000.0000', '33000', '33000'
-- '3', '2', '27500.0000', '30000', '25000'
-- '4', '1', '32000.0000', '32000', '32000'

SELECT concat(upper(emp_name),' works as ', upper(designation)) as Description FROM Employee;
-- # Description
-- 'JAMES works as TEAM HEAD'
-- 'SOPHIA works as DEVELOPER'
-- 'RAHUL works as TESTER'
-- 'EMILY works as PROJ LEAD'
-- 'ARJUN works as INTERN'

SELECT emp_name, YEAR(date_of_joining) AS joining_year, DATEDIFF(NOW(), date_of_joining) AS days_worked FROM Employee;
-- # emp_name, joining_year, days_worked
-- 'James', 2000, '9115'
-- 'Sophia', 2001, '8922'
-- 'Rahul', 1999, '9473'
-- 'Emily', 1998, '10076'
-- 'Arjun', 2002, '8486'

SELECT emp_name, salary FROM Employee WHERE salary BETWEEN 40000 AND 80000 AND dept_id NOT IN 
(SELECT dept_id FROM Department WHERE dept_name = 'Sales');
-- NULL
 
 SELECT e.emp_name, e.designation, d.dept_name, d.location FROM Employee e INNER JOIN Department d 
 ON e.dept_id = d.dept_id;
-- # emp_name, designation, dept_name, location
-- 'Rahul', 'Tester', 'Tech', 'bangalore'
-- 'Sophia', 'Developer', 'HR', 'mysore'
-- 'James', 'Team Head', 'Mangement', 'hampi'
-- 'Arjun', 'Intern', 'Mangement', 'hampi'
-- 'Emily', 'Proj Lead', 'Event', 'udupi'

SELECT e.emp_name, d.dept_name FROM Employee e LEFT JOIN Department d ON e.dept_id = d.dept_id;
-- # emp_name, dept_name
-- 'James', 'Mangement'
-- 'Sophia', 'HR'
-- 'Rahul', 'Tech'
-- 'Emily', 'Event'
-- 'Arjun', 'Mangement'

SELECT e.emp_name, d.dept_name FROM Employee e RIGHT JOIN Department d ON e.dept_id = d.dept_id;
-- # emp_name, dept_name
-- 'Rahul', 'Tech'
-- 'Sophia', 'HR'
-- 'James', 'Mangement'
-- 'Arjun', 'Mangement'
-- 'Emily', 'Event'

DELIMITER $$
CREATE PROCEDURE InsertEmployee(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_dept_id INT,
    IN p_address VARCHAR(100),
    IN p_date_of_joining DATE
)
BEGIN
    INSERT INTO Employee (emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id)
    VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_joining, p_dept_id);
END $$
DELIMITER ;
CALL InsertEmployee(110, 'Lilly', 26, 45000, 'HR Ex', 2, 'Mumbai', '2022-06-15');
select * from Employee;
-- # emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id
-- '101', 'James', '24', '30000', 'Team Head', 'Bangalore', '2000-10-31', '3'
-- '102', 'Sophia', '26', '33000', 'Developer', 'Mumbai', '2001-05-12', '2'
-- '103', 'Rahul', '25', '27000', 'Tester', 'Chennai', '1999-11-08', '1'
-- '104', 'Emily', '27', '32000', 'Proj Lead', 'Pune', '1998-03-15', '4'
-- '105', 'Arjun', '23', '25000', 'Intern', 'Hyderabad', '2002-07-22', '3'
-- '110', 'Lilly', '26', '45000', 'HR Ex', 'Mumbai', '2022-06-15', '2'

DELIMITER $$
CREATE PROCEDURE UpdateSalary(
    IN p_empid INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employee
    SET salary = p_new_salary
    WHERE emp_id = p_empid;
END $$
DELIMITER ;
CALL UpdateSalary(110, 52000);
select * from Employee;
-- # emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id
-- '101', 'James', '24', '30000', 'Team Head', 'Bangalore', '2000-10-31', '3'
-- '102', 'Sophia', '26', '33000', 'Developer', 'Mumbai', '2001-05-12', '2'
-- '103', 'Rahul', '25', '27000', 'Tester', 'Chennai', '1999-11-08', '1'
-- '104', 'Emily', '27', '32000', 'Proj Lead', 'Pune', '1998-03-15', '4'
-- '105', 'Arjun', '23', '25000', 'Intern', 'Hyderabad', '2002-07-22', '3'
-- '110', 'Lilly', '26', '52000', 'HR Ex', 'Mumbai', '2022-06-15', '2'

DELIMITER $$
CREATE PROCEDURE DeleteEmployee(
    IN p_empid INT
)
BEGIN
    DELETE FROM Employee
    WHERE emp_id = p_empid;
END $$
DELIMITER ;
CALL DeleteEmployee(110);
select * from Employee;
-- # emp_id, emp_name, age, salary, designation, address, date_of_joining, dept_id
-- '101', 'James', '24', '30000', 'Team Head', 'Bangalore', '2000-10-31', '3'
-- '102', 'Sophia', '26', '33000', 'Developer', 'Mumbai', '2001-05-12', '2'
-- '103', 'Rahul', '25', '27000', 'Tester', 'Chennai', '1999-11-08', '1'
-- '104', 'Emily', '27', '32000', 'Proj Lead', 'Pune', '1998-03-15', '4'
-- '105', 'Arjun', '23', '25000', 'Intern', 'Hyderabad', '2002-07-22', '3'

SELECT e.emp_name AS employee_name, d.dept_name, TIMESTAMPDIFF(YEAR, e.date_of_joining, CURDATE()) AS years_worked, (e.salary + 5000)
AS salary_after_increment FROM Employee e JOIN Department d ON e.dept_id = d.dept_id WHERE 
TIMESTAMPDIFF(YEAR, e.date_of_joining, CURDATE()) > 2;
-- # employee_name, dept_name, years_worked, salary_after_increment
-- 'Rahul', 'Tech', '25', '32000'
-- 'Sophia', 'HR', '24', '38000'
-- 'James', 'Mangement', '24', '35000'
-- 'Arjun', 'Mangement', '23', '30000'
-- 'Emily', 'Event', '27', '37000'