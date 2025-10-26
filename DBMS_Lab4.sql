-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 02: Program 02 - Implementation of DML Commands in SQL ( INSERT , SELECT, UPDATE and DELETE )
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Prateeskha.S
-- USN: 1RUA24BCA0069
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command

-- 'root@localhost', 'RVU-PC-044', '8.4.6', '2025-09-01 11:27:07'

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Scenario: You are managing a database for a library with two tables: Books and Members.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Task 01: Create Tables [ Check the below mentioned Instructions:
-- Create the Books and Members tables with the specified structure.
-- Books Table and Member Table : 
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task with the Instructed Column in the session 
CREATE database Library;
use Library;
create table Books
(BookID varchar(15) Primary key,
Book_Name varchar(15),
Price int,
Author varchar(15));

create table Members
(MemberID varchar(15) Primary key,
Name varchar(15),
BookID varchar(15),
foreign key(BookID) references Books(BookID),
Ph_No int);




-- Paste the Output below for the given command ( DESC TableName;) 
desc Books;
-- 'BookID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'Book_Name', 'varchar(15)', 'YES', '', NULL, ''
-- 'Price', 'int', 'YES', '', NULL, ''
-- 'Author', 'varchar(15)', 'YES', '', NULL, ''

desc Members;
-- 'MemberID', 'varchar(15)', 'NO', 'PRI', NULL, ''
-- 'Name', 'varchar(15)', 'YES', '', NULL, ''
-- 'BookID', 'varchar(15)', 'YES', 'MUL', NULL, ''
-- 'Ph_No', 'int', 'YES', '', NULL, ''

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 02: Insert a New Book
-- Instructions: Insert a book titled "1984_The Black Swan" by George Orwell (published in 1949) with 04 available copies and 10 Total copies. 
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
insert into Books values
('B100', 'The Black Swan', 300, 'George Orwell'),
('B101', 'Harry potter', 200, 'JK rowling'),
('B102', 'grims fairytale', 300, 'grim brothers'),
('B103', 'Goosebumps', 200, 'R.L Stine'),
('B104', 'Romio juliet', 540, 'William.S');





-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
SELECT * FROM Books;
-- 'B100', 'The Black Swan', '300', 'George Orwell'
-- 'B101', 'Harry potter', '200', 'JK rowling'
-- 'B102', 'grims fairytale', '300', 'grim brothers'
-- 'B103', 'Goosebumps', '200', 'R.L Stine'
-- 'B104', 'Romio juliet', '540', 'William.S'

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 03: Add New Members
-- Instructions: Insert two members: David Lee (Platinum, joined 2024-04-15) and Emma Wilson (Silver, joined 2024-05-22).
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

insert into Members values
('M567', 'Lisa', 'B100', 34568),
('M764', 'Elli', 'B104', 123458),
('M678', 'Sara', 'B102', 927667);






-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
SELECT * FROM Members;
-- 'M567', 'Lisa', 'B100', '34568'
-- 'M678', 'Sara', 'B102', '927667'
-- 'M764', 'Elli', 'B104', '123458'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 04: Update Book Details 
-- Instructions: The library acquired 2 additional copies of "1984_The Black Swan". Update the Books table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

alter table Books
add(Publisher_Location Varchar(20));

update Books set Publisher_location = 'Bangalore';



-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
SELECT * FROM Books;
-- 'B100', 'The Black Swan', '300', 'George Orwell', 'Bangalore'
-- 'B101', 'Harry potter', '200', 'JK rowling', 'Bangalore'
-- 'B102', 'grims fairytale', '300', 'grim brothers', 'Bangalore'
-- 'B103', 'Goosebumps', '200', 'R.L Stine', 'Bangalore'
-- 'B104', 'Romio juliet', '540', 'William.S', 'Bangalore'

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 05: Modify a Member's Information
-- Instructions: Update a member's membership type. Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
alter table Members
add(Membership Varchar(20));

update Members set Membership = 'Gold';






-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
SELECT * FROM Members;
-- 'M567', 'Lisa', 'B100', '34568', 'Gold'
-- 'M678', 'Sara', 'B102', '927667', 'Gold'
-- 'M764', 'Elli', 'B104', '123458', 'Gold'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 06: Remove a Member
-- Instructions: Delete David Lee’s record from the Members table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.







-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 09: Borrowing Table 
-- Instructions: Create a Borrowing table with foreign keys referencing Books and Members.
-- Subtask 1: Borrow a Book
-- Scenario:Emma Wilson (member_id = 2) borrows the book "The Catcher in the Rye" (book_id = 102) on 2024-06-01. Insert this record into the Borrowing table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.








-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 10: Find the name of Borrower who book = 102 [ Advance and Optional ]
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.








-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Final Task 00: ER Diagram - Instructions:
-- Draw an ER diagram for the library database. Additional Upload the scanned copy of the created ER Daigram in the Google Classroom.



-- END of the Task -- 