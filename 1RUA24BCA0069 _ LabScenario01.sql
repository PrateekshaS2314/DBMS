-- Lab Experiment 01: Implementation of DDL Commands in SQL for the given scenarios
-- STUDENT NAME: PRATEEKSHA S
-- USN: 1RUA24BCA0069
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- 'root@localhost', 'RVU-PC-044', '8.4.6', '2025-08-25 11:24:04'

-- Scenario: College Student Management System

-- CREATE AND LOAD THE database
-- Write your SQL query below Codespace:

create database College;
use College;

-- Task 1: Create the Tables under this system (min 5 tables)
  -- Table 01: Departments ( DepartmentID, DepartmentName, HOD,ContactEmail,PhoneNumber,Location )
  -- Table 02: Course (CourseID, CourseName,Credits,DepartmentID,Duration,Fee )
  -- Table 03: Students (StudentID,FirstName,LastName,Email,DateOfBirth,CourseID)
  -- Table 04: Faculty FacultyID,FacultyName,DepartmentID,Qualification,Email,PhoneNumber)
  -- Table 05: Enrollments (  EnrollmentID,StudentID,CourseID,Semester,Year,Grade)
-- Specify the Key (Primary and Foreign) for each table while creating

-- Write your SQL query below Codespace:
create table Departments
( DepartmentID varchar(15) Primary key,
  DepartmentName varchar(15), 
  HOD Varchar(15),
  ContactEmail varchar(15) unique,
  PhoneNumber int unique,
  Location varchar(15));

create table Course
(CourseID varchar(15) Primary key,
 CourseName varchar(15),
 Credits int,
 DepartmentID varchar(15),
 foreign key(DepartmentID) references Departments(DepartmentID),
 Fee int);
 alter table Course
 add(Duration varchar(15));
 
create table Students
(StudentID varchar(15) primary key,
FirstName varchar(15),
LastName varchar(15),
Email varchar(15) unique,
DateOfBirth date,
CourseID varchar(15),
foreign key(CourseID) references Course(CourseID));

create table Faculty
(FacultyID varchar(15) primary key,
FacultyName varchar(15),
DepartmentID varchar(15),
foreign key(DepartmentID) references Departments(DepartmentID),
Qualification varchar(15),
Email varchar(15) unique,
PhoneNumber int unique);

create table Enrollments
(EnrollmentID varchar(15),
StudentID varchar(15),
CourseID varchar(15),
foreign key(StudentID) references Students(StudentID),
foreign key(CourseID) references Course(CourseID),
Semester varchar(15),
Year year,
Grade varchar(15));

-- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
--  describe the structure of each table and copy paste the Output 
desc Departments;
-- 'DepartmentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'DepartmentName', 'varchar(15)', 'YES', '', NULL, ''
-- 'HOD', 'varchar(15)', 'YES', '', NULL, ''
-- 'ContactEmail', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'PhoneNumber', 'int', 'YES', '', NULL, ''
-- 'Location', 'varchar(15)', 'YES', '', NULL, ''

desc Course;
-- 'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'CourseName', 'varchar(15)', 'YES', '', NULL, ''
-- 'Credits', 'int', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Fee', 'int', 'YES', '', NULL, ''
-- 'Duration', 'varchar(15)', 'YES', '', NULL, ''

desc Students;
-- 'StudentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FirstName', 'varchar(15)', 'YES', '', NULL, ''
-- 'LastName', 'varchar(15)', 'YES', '', NULL, ''
-- 'Email', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'DateOfBirth', 'date', 'YES', '', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''

desc Faculty;
-- 'FacultyID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FacultyName', 'varchar(15)', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Qualification', 'varchar(15)', 'YES', '', NULL, ''
-- 'Email', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'PhoneNumber', 'int', 'YES', 'UNI', NULL, ''

desc Enrollments;
-- 'EnrollmentID', 'varchar(15)', 'YES', '', NULL, ''
-- 'StudentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Semester', 'varchar(15)', 'YES', '', NULL, ''
-- 'Year', 'year', 'YES', '', NULL, ''
-- 'Grade', 'varchar(15)', 'YES', '', NULL, ''

-- Perform the following operations on the each of the tables
-- 01: add 2 new columns for each table
alter table Departments
add(dean varchar(15), placements varchar(15));

alter table Course
add(teacher varchar(15), category varchar(15));

alter table Students
add(PhoneNumber int unique, CGPA numeric(10,5));

alter table Faculty
add(age int, Ratings numeric(5,2));

alter table Enrollments
add(paymentMode varchar(15), Scholarship varchar(15));

-- 02: Modify the existing column from each table
alter table Departments
modify Location varchar(20);

alter table Course
modify CourseName varchar(20);

alter table Students
modify Email varchar(20);

alter table Faculty
modify Qualification varchar(20);

alter table Enrollments
modify paymentMode varchar(20);

-- 03 change the datatypes
alter table Departments
modify placements int;

alter table Course
modify Fee numeric(5,3);

alter table Students
modify CGPA int;

alter table Faculty
modify Ratings int;

alter table Enrollments
modify Scholarship numeric(10,5);

-- 04: Rename a column
alter table Departments
rename column ContactEmail to Email;

alter table Course
rename column teacher to courseIncharge;

alter table Students
rename column DateOFBirth to DOB;

alter table Faculty
rename column Email to ContactEmail;

alter table Enrollments
rename column Scholarship to Scholarship_Amt;

-- 05: Drop a column
alter table Departments
drop column HOD;

alter table Course
drop column Category;

alter table Students
drop column CGPA;

alter table Faculty
drop column Ratings;

alter table Enrollments
drop column Scholarship_Amt;

-- 06: Rename the table
alter table Departments
Rename to Schools;

alter table Course
Rename to Programs;

alter table Students
Rename to Pupils;

alter table Faculty
Rename to Staff;

alter table Enrollments
Rename to Addmissions;

-- 07: describe the structure of the new table
desc Schools;
-- 'DepartmentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'DepartmentName', 'varchar(15)', 'YES', '', NULL, ''
-- 'Email', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'PhoneNumber', 'int', 'YES', '', NULL, ''
-- 'Location', 'varchar(20)', 'YES', '', NULL, ''
-- 'dean', 'varchar(15)', 'YES', '', NULL, ''
-- 'placements', 'int', 'YES', '', NULL, ''

desc Programs;
-- 'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'CourseName', 'varchar(20)', 'YES', '', NULL, ''
-- 'Credits', 'int', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Fee', 'decimal(5,3)', 'YES', '', NULL, ''
-- 'teacher', 'varchar(15)', 'YES', '', NULL, ''
-- 'Duration', 'varchar(15)', 'YES', '', NULL, ''

desc Pupils;
-- 'StudentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FirstName', 'varchar(15)', 'YES', '', NULL, ''
-- 'LastName', 'varchar(15)', 'YES', '', NULL, ''
-- 'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
-- 'DOB', 'date', 'YES', '', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'PhoneNumber', 'int', 'YES', 'UNI', NULL, ''

desc Staff;
-- 'FacultyID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FacultyName', 'varchar(15)', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Qualification', 'varchar(20)', 'YES', '', NULL, ''
-- 'Email', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'PhoneNumber', 'int', 'YES', 'UNI', NULL, ''
-- 'age', 'int', 'YES', '', NULL, ''

desc Addmissions;
-- 'EnrollmentID', 'varchar(15)', 'YES', '', NULL, ''
-- 'StudentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Semester', 'varchar(15)', 'YES', '', NULL, ''
-- 'Year', 'year', 'YES', '', NULL, ''
-- 'Grade', 'varchar(15)', 'YES', '', NULL, ''
-- 'paymentMode', 'varchar(20)', 'YES', '', NULL, ''

  -- Additional set of questions 
-- 1 Add a new column Address (VARCHAR(100)) to the Students table.
alter table Pupils
add(Address varchar(100));

-- 2 Add a column Gender (CHAR(1)) to the Students table.
alter table Pupils
add(Gender char(1));

-- 3 Add a column JoiningDate (DATE) to the Faculty table.
alter table Staff
add(JoiningDate Date);

-- 4 Modify the column CourseName in the Courses table to increase its size from VARCHAR(50) to VARCHAR(100).
alter table Programs
modify CourseName varchar(100);

-- 5 Modify the column Location in the Departments table to VARCHAR(80).
alter table Schools
modify Location varchar(80);

-- 6 Rename the column Qualification in the Faculty table to Degree.
alter table Staff
rename column Qualification to Degree;

-- 7 Rename the table Faculty to Teachers.
alter table Staff
Rename to Teachers;

-- 8 Drop the column PhoneNumber from the Departments table.
alter table Schools
drop column PhoneNumber;
-- 9 Drop the column Email from the Students table.
alter table Pupils
drop column Email;
-- 10 Drop the column Duration from the Courses table.
alter table Programs
drop column Duration;

SHOW TABLES; -- Before dropping the table
-- 'programs'
-- 'pupils'
-- 'schools'
-- 'teachers'
-- 'Addmissions'
desc Schools;
-- 'DepartmentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'DepartmentName', 'varchar(15)', 'YES', '', NULL, ''
-- 'Email', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'Location', 'varchar(80)', 'YES', '', NULL, ''
-- 'dean', 'varchar(15)', 'YES', '', NULL, ''
-- 'placements', 'int', 'YES', '', NULL, ''

desc Programs;
-- 'CourseID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'CourseName', 'varchar(100)', 'YES', '', NULL, ''
-- 'Credits', 'int', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Fee', 'decimal(5,3)', 'YES', '', NULL, ''
-- 'courseIncharge', 'varchar(15)', 'YES', '', NULL, ''

desc Pupils;
-- 'StudentID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FirstName', 'varchar(15)', 'YES', '', NULL, ''
-- 'LastName', 'varchar(15)', 'YES', '', NULL, ''
-- 'DOB', 'date', 'YES', '', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'PhoneNumber', 'int', 'YES', 'UNI', NULL, ''
-- 'Address', 'varchar(100)', 'YES', '', NULL, ''
-- 'Gender', 'char(1)', 'YES', '', NULL, ''

desc teachers;
-- 'FacultyID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'FacultyName', 'varchar(15)', 'YES', '', NULL, ''
-- 'DepartmentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Degree', 'varchar(20)', 'YES', '', NULL, ''
-- 'ContactEmail', 'varchar(15)', 'YES', 'UNI', NULL, ''
-- 'PhoneNumber', 'int', 'YES', 'UNI', NULL, ''
-- 'age', 'int', 'YES', '', NULL, ''
-- 'JoiningDate', 'date', 'YES', '', NULL, ''

desc Addmissions;
-- 'EnrollmentID', 'varchar(15)', 'YES', '', NULL, ''
-- 'StudentID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'CourseID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Semester', 'varchar(15)', 'YES', '', NULL, ''
-- 'Year', 'year', 'YES', '', NULL, ''
-- 'Grade', 'varchar(15)', 'YES', '', NULL, ''
-- 'paymentMode', 'varchar(20)', 'YES', '', NULL, ''

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table Programs;
drop table Addmissions;

SHOW TABLES; -- After dropping the table Enrollement and Course
-- 'pupils'
-- 'schools'
-- 'teachers'

-- Note: Perform the specified operations on all the 5 tables in the system
-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabScenario01