create database student;
use student;
create table MarksCard
( Student_ID varchar(20) primary key,
    USN varchar(20) ,
    name varchar(20),
    class varchar(10),
    section varchar(5),
    marks1 int,
    marks2 int,
    marks3 int);

desc MarksCard;
-- 'Student_ID', 'varchar(20)', 'NO', 'PRI', NULL, ''
-- 'USN', 'varchar(20)', 'YES', '', NULL, ''
-- 'name', 'varchar(20)', 'YES', '', NULL, ''
-- 'class', 'varchar(10)', 'YES', '', NULL, ''
-- 'section', 'varchar(5)', 'YES', '', NULL, ''
-- 'marks1', 'int', 'YES', '', NULL, ''
-- 'marks2', 'int', 'YES', '', NULL, ''
-- 'marks3', 'int', 'YES', '', NULL, ''

insert into MarksCard values
(1000,'1234xyz','Lisa','12','A',45,66,89),
(1001,'3455xyz','Albert','11','B',67,66,88),
(1002,'5756xyz','Eliza','10','C',90,98,100),
(1003,'3544xyz','Kruthi','9','A',97,100,90),
(1004,'3456xyz','Inchara','11','A',100,97,99),
(1005,'2346xyz','Ananya','12','D',90,95,100),
(1006,'6789xyz','Esha','12','B',85,90,89),
(1007,'3786xyz','Elli','10','C',45,66,89),
(1008,'7688xyz','Sara','11','C',12,33,40),
(1009,'2574xyz','Lilly','9','B',45,65,56);

select * from MarksCard;
-- '1000', '1234xyz', 'Lisa', '12', 'A', '45', '66', '89'
-- '1001', '3455xyz', 'Albert', '11', 'B', '67', '66', '88'
-- '1002', '5756xyz', 'Eliza', '10', 'C', '90', '98', '100'
-- '1003', '3544xyz', 'Kruthi', '9', 'A', '97', '100', '90'
-- '1004', '3456xyz', 'Inchara', '11', 'A', '100', '97', '99'
-- '1005', '2346xyz', 'Ananya', '12', 'D', '90', '95', '100'
-- '1006', '6789xyz', 'Esha', '12', 'B', '85', '90', '89'
-- '1007', '3786xyz', 'Elli', '10', 'C', '45', '66', '89'
-- '1008', '7688xyz', 'Sara', '11', 'C', '12', '33', '40'
-- '1009', '2574xyz', 'Lilly', '9', 'B', '45', '65', '56'

alter table MarksCard
add(Total int, Average int);
alter table MarksCard
add (Percentage varchar(15));

update MarksCard set Total = marks1+marks2+marks3;
update MarksCard set Average = Total/3;
update MarksCard set Percentage = (Total/300)*100;

select * from MarksCard;
-- '1000', '1234xyz', 'Lisa', '12', 'A', '45', '66', '89', '200', '67', '66.666666600'
-- '1001', '3455xyz', 'Albert', '11', 'B', '67', '66', '88', '221', '74', '73.666666600'
-- '1002', '5756xyz', 'Eliza', '10', 'C', '90', '98', '100', '288', '96', '96.000000000'
-- '1003', '3544xyz', 'Kruthi', '9', 'A', '97', '100', '90', '287', '96', '95.666666600'
-- '1004', '3456xyz', 'Inchara', '11', 'A', '100', '97', '99', '296', '99', '98.666666600'
-- '1005', '2346xyz', 'Ananya', '12', 'D', '90', '95', '100', '285', '95', '95.000000000'
-- '1006', '6789xyz', 'Esha', '12', 'B', '85', '90', '89', '264', '88', '88.000000000'
-- '1007', '3786xyz', 'Elli', '10', 'C', '45', '66', '89', '200', '67', '66.666666600'
-- '1008', '7688xyz', 'Sara', '11', 'C', '12', '33', '40', '85', '28', '28.333333300'
-- '1009', '2574xyz', 'Lilly', '9', 'B', '45', '65', '56', '166', '55', '55.333333300'