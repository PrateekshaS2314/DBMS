create database school;
use school;
create table student
( StudentID varchar(15) primary key,
 FirstName varchar(15),
 LastName varchar(15),
 DOB date,
 Class varchar(10),
 Marks int,
 City varchar(15));
 create table teacher
 ( TeacherID varchar(15) primary key,
 FirstName varchar(15),
 LastName varchar(15),
 Subject varchar(15),
 HireDate date,
 Salary int);
create table course
 ( CourseID varchar(15) primary key,
 CourseName varchar(15),
 Credits int);
create table enrollment
 (EnrollID varchar(15) primary key,
 StudentID varchar(15),
 CourseID varchar(15),
 foreign key(StudentID) references student(StudentID),
 foreign key(CourseID) references course(CourseID),
 Grade varchar(15));
 
insert into student values
 ('s100', 'Ananya', 'R', '2006-03-12', '10A', 100, 'Bangalore'),
 ('s101', 'Amrithaa', 'm', '2006-06-01', '12A', 80, 'Mysore'),
 ('s102', 'Esha', 'T', '2007-02-28', '9B', 95, 'Humpi'),
 ('s103', 'Lisa', 'Johnson', '2000-10-30', '11C', 85, 'Bangalore'),
 ('s104', 'Krish', 'G', '2006-11-23', '10B', 88, 'Udupi');
insert into teacher values
('t100', 'Kelly', 'Peter', 'History', '2020-04-30', 30000),
('t101', 'Hannah', 'Joseph', 'Math', '2023-09-11', 35000),
('t102', 'Abbi', 'Luck', 'Art', '2022-11-11', 25000),
('t103', 'Shiv', 'Ashwini', 'Physics', '2020-04-30', 40000),
('t104', 'Lily', 'Peter', 'Chemistry', '2024-04-30', 30000);
insert into course values
('c100','DBMS',4),
('c101','JAVA',4),
('c102','NumericMethods',3),
('c103','DDCA',2),
('c104','CN',4);
insert into enrollment values
('e100', 's101', 'c103', 'A'),
('e101', 's104', 'c100', 'A+'),
('e102', 's103', 'c102', 'B'),
('e103', 's102', 'c104', 'A'),
('e104', 's100', 'c101', 'B+');

select * from student;
-- # StudentID, FirstName, LastName, DOB, Class, Marks, City
-- 's100', 'Ananya', 'R', '2006-03-12', '10A', '100', 'Bangalore'
-- 's101', 'Amrithaa', 'm', '2006-06-01', '12A', '80', 'Mysore'
-- 's102', 'Esha', 'T', '2007-02-28', '9B', '95', 'Humpi'
-- 's103', 'Lisa', 'Johnson', '2000-10-30', '11C', '85', 'Bangalore'
-- 's104', 'Krish', 'G', '2006-11-23', '10B', '88', 'Udupi'

select substr(CourseName, -3,3) from course;
-- # substr(CourseName, -3,3)
-- 'BMS'
-- 'AVA'
-- 'ods'
-- 'DCA'
-- ''

select concat(FirstName, Lastname) as FullName from teacher;
-- # FullName
-- 'KellyPeter'
-- 'HannahJoseph'
-- 'AbbiLuck'
-- 'ShivAshwini'
-- 'LilyPeter'

select FirstName, LastName, length(FirstName)+length(LastName) as LengthOFName from student;
-- # FirstName, LastName, LengthOFName
-- 'Ananya', 'R', '7'
-- 'Amrithaa', 'm', '9'
-- 'Esha', 'T', '5'
-- 'Lisa', 'Johnson', '11'
-- 'Krish', 'G', '6'

select replace(CourseName, 'NumericMethods', 'Math') as UpdatedNames from course;
-- # UpdatedNames
-- 'DBMS'
-- 'JAVA'
-- 'Math'
-- 'DDCA'
-- 'CN'

select abs(max(Marks) - min(Marks)) as MarksDifference from student;
-- # MarksDifference
-- '20'

Select round(Salary) as RoundedSalary from teacher;
-- # RoundedSalary
-- '30000'
-- '35000'
-- '25000'
-- '40000'
-- '30000'

select sqrt(Credits) as SqrtOfCredits from course;
-- # SqrtOfCredits
-- '2'
-- '2'
-- '1.7320508075688772'
-- '1.4142135623730951'
-- '2'

select Marks, ceil(Marks) as CeilingMarks, floor(Marks) as FloorMarks from student;
-- # Marks, CeilingMarks, FloorMarks
-- '100', '100', '100'
-- '80', '80', '80'
-- '95', '95', '95'
-- '85', '85', '85'
-- '88', '88', '88'

select sum(Marks)%5 as Modulus from student;
-- # Modulus
-- '3'

select now() as CurrentDateAndTime;
-- # CurrentDateAndTime
-- '2025-09-10 19:45:47'

select year(HireDate) as YearOfHire, month(HireDate) as MonthOfHire from teacher;
-- # YearOfHire, MonthOfHire
-- 2020, '4'
-- 2023, '9'
-- 2022, '11'
-- 2020, '4'
-- 2024, '4'

select * from student where month(DOB)=1;
# StudentID, FirstName, LastName, DOB, Class, Marks, City
-- null

select datediff(now(), HireDate) as DifferenceInDays from teacher;
-- # DifferenceInDays
-- '1959'
-- '730'
-- '1034'
-- '1959'
-- '498'

select count(*) as TotalStudents from student;
-- # TotalStudents
-- '5'

select avg(Salary) as AvgSalary from teacher;
-- # AvgSalary
-- '32000.0000'

select Max(Marks) as HighestMarks, Min(Marks) as LowestMarks from student;
-- # HighestMarks, LowestMarks
-- '100', '80'