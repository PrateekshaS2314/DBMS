-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: PRATEEKSHA S
-- USN: 1RUA24BCA0069
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- 'root@localhost', 'RVU-PC-044', '8.4.6', '2025-08-18 11:37:01'

-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:

create database DBLab001;
use DBLab001;

-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth

-- Write your SQL query below Codespace:

create table Students
( StudentID varchar(15) primary key,
 FirstName varchar(15),
 LastName varchar(15),
 Email varchar(20) UNIQUE,
 DateOfBirth date);

DESC STUDENTS; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

/*'StudentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(15)', 'YES', '', NULL, ''
'LastName', 'varchar(15)', 'YES', '', NULL, ''
'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''
*/

-- Alter the table and 2 new columns

alter table Students
add(gender varchar(10), age int);
desc Students;

/* 'StudentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(15)', 'YES', '', NULL, ''
'LastName', 'varchar(15)', 'YES', '', NULL, ''
'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''
'gender', 'varchar(10)', 'YES', '', NULL, ''
'age', 'int', 'YES', '', NULL, ''
*/

-- Modify a column data type

alter table Students
modify Firstname varchar(20);
desc Students;

-- Rename a column

alter table Students
rename column StudentID to USN;
desc Students;

-- Drop a column

alter table Students
drop column LastName;

-- Rename the table

alter table Students
Rename to Student_details;
desc Student_details;

/* 'USN', 'varchar(15)', 'NO', 'PRI', NULL, ''
'Firstname', 'varchar(20)', 'YES', '', NULL, ''
'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''
'gender', 'varchar(10)', 'YES', '', NULL, ''
'age', 'int', 'YES', '', NULL, ''
*/

-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits

-- Write your SQL query below Codespace:

create table courses
( CourseID varchar(15) primary key,
  CourseName varchar(15),
  Credits int);

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- OUTPUT :

/* 'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'CourseName', 'varchar(15)', 'YES', '', NULL, ''
'Credits', 'int', 'YES', '', NULL, ''
*/

-- Alter the table and 2 new columns
alter table Courses
add(course_incharge varchar(15), course_fees int);

-- Modify a column data type
alter table courses
modify Coursename varchar(20);

-- Rename a column
alter table courses
rename column credits to CGPA;

/* 'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'Coursename', 'varchar(20)', 'YES', '', NULL, ''
'CGPA', 'int', 'YES', '', NULL, ''
'course_incharge', 'varchar(15)', 'YES', '', NULL, ''
'course_fees', 'int', 'YES', '', NULL, ''
*/

-- Drop a column
alter table Courses
drop column course_fees;
desc Courses;

/*'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'Coursename', 'varchar(20)', 'YES', '', NULL, ''
'CGPA', 'int', 'YES', '', NULL, ''
'course_incharge', 'varchar(15)', 'YES', '', NULL, ''
*/

-- Rename the table
alter table Courses
Rename to Programs;

-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - EnrollmentDate

-- Write your SQL query below Codespace:
create table Enrollments
( EnrollmentID varchar(15) primary key,
  USN varchar(15),
  CourseID varchar(15),
  foreign key(USN) references Student_details(USN),
  foreign key(CourseID) references Programs(CourseID),
  EnrollmentDate date);

DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT :

/*'EnrollmentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
'USN', 'varchar(15)', 'YES', 'MUL', NULL, ''
'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
'EnrollmentDate', 'date', 'YES', '', NULL, ''
*/

-- Alter the table and 2 new columns
alter table Enrollments
add(course varchar(15), name varchar(15));

-- Modify a column data type
alter table Enrollments
modify USN varchar(20);

-- Rename a column
alter table Enrollments
rename column course to Course_Name;

-- Drop a column
alter table Enrollments
drop column name;

-- Rename the table
alter table Enrollments
Rename to Admissions;

-- Task 4: Alter the Students Table
-- Add a column 'PhoneNumber' to store student contact numbers.

-- Write your SQL query below Codespace:
alter table student_details
add(PhoneNumber int);

DESC STUDENT_details; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]
/*'USN', 'varchar(15)', 'NO', 'PRI', NULL, ''
'Firstname', 'varchar(20)', 'YES', '', NULL, ''
'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''
'gender', 'varchar(10)', 'YES', '', NULL, ''
'age', 'int', 'YES', '', NULL, ''
'PhoneNumber', 'int', 'YES', '', NULL, ''
*/

-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.
-- Write your SQL query below Codespace:
alter table Programs
modify CGPA decimal(5,3);

-- Task 6: Drop Tables

SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table Programs;
drop table Admissions;

SHOW TABLES; -- After dropping the table Enrollement and Course

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01