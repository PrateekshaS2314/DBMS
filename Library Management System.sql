CREATE DATABASE Library;
USE Library;

CREATE TABLE Members (
  member_id INT PRIMARY KEY,
  name VARCHAR(100),
  membership_date DATE,
  phone VARCHAR(20)
);

CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  author VARCHAR(100),
  isbn VARCHAR(20),
  total_copies INT,
  available_copies INT
);

CREATE TABLE Issues (
  issue_id INT PRIMARY KEY,
  book_id INT,
  member_id INT,
  issue_date DATE,
  due_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Sample data
INSERT INTO Members VALUES
(1,'Rahul Sharma','2024-01-05','9000000001'),
(2,'Sneha Iyer','2024-02-10','9000000002'),
(3,'Ayesha Khan','2024-03-12','9000000003'),
(4,'Karan Mehta','2024-01-20','9000000004'),
(5,'Pooja Rao','2024-04-01','9000000005');

INSERT INTO Books VALUES
(201,'Database Systems','Ramez Elmasri','978-013207',3,2),
(202,'Clean Code','Robert C. Martin','978-013235',2,1),
(203,'Introduction to Algorithms','Cormen','978-026203',4,4),
(204,'Design Patterns','Gamma et al.','978-020163',1,1),
(205,'Web Development with Node','Shelley Powers','978-149200',2,2);

INSERT INTO Issues VALUES
(3001,201,1,'2025-04-01','2025-04-15',NULL),
(3002,202,2,'2025-03-20','2025-04-03','2025-04-02'),
(3003,203,3,'2025-04-05','2025-04-19',NULL),
(3004,201,4,'2025-03-25','2025-04-08','2025-04-07'),
(3005,205,1,'2025-04-10','2025-04-24',NULL);

-- Queries

-- 1. Total issued books per member (currently issued, not returned)
SELECT m.member_id, m.name, COUNT(i.issue_id) AS Currently_Issued
FROM Members m
LEFT JOIN Issues i ON m.member_id = i.member_id AND i.return_date IS NULL
GROUP BY m.member_id, m.name;

-- # member_id, name, Currently_Issued
-- '1', 'Rahul Sharma', '2'
-- '2', 'Sneha Iyer', '0'
-- '3', 'Ayesha Khan', '1'
-- '4', 'Karan Mehta', '0'
-- '5', 'Pooja Rao', '0'

-- 2. Overdue books
SELECT i.issue_id, m.name, b.title, i.due_date, DATEDIFF(CURDATE(), i.due_date) AS Days_Overdue
FROM Issues i
JOIN Members m ON i.member_id = m.member_id
JOIN Books b ON i.book_id = b.book_id
WHERE i.return_date IS NULL AND i.due_date < CURDATE();

-- # issue_id, name, title, due_date, Days_Overdue
-- '3001', 'Rahul Sharma', 'Database Systems', '2025-04-15', '194'
-- '3003', 'Ayesha Khan', 'Introduction to Algorithms', '2025-04-19', '190'
-- '3005', 'Rahul Sharma', 'Web Development with Node', '2025-04-24', '185'

-- 3. Issue history with year/month
SELECT issue_id, book_id, member_id, YEAR(issue_date) AS Year, MONTH(issue_date) AS Month
FROM Issues;

-- # issue_id, book_id, member_id, Year, Month
-- '3001', '201', '1', 2025, '4'
-- '3002', '202', '2', 2025, '3'
-- '3003', '203', '3', 2025, '4'
-- '3004', '201', '4', 2025, '3'
-- '3005', '205', '1', 2025, '4'

-- 4. Total issues per book
SELECT b.title, COUNT(i.issue_id) AS Total_Issues
FROM Books b
LEFT JOIN Issues i ON b.book_id = i.book_id
GROUP BY b.book_id, b.title
ORDER BY Total_Issues DESC;

-- # title, Total_Issues
-- 'Database Systems', '2'
-- 'Clean Code', '1'
-- 'Introduction to Algorithms', '1'
-- 'Web Development with Node', '1'
-- 'Design Patterns', '0'

-- Procedure to return a book
DELIMITER //

CREATE PROCEDURE ReturnBook(
  IN issueid INT,
  IN ret_date DATE
)
BEGIN
  DECLARE bid INT;

  -- Get the book_id for the given issue
  SELECT book_id INTO bid FROM Issues WHERE issue_id = issueid;

  -- Update the return date
  UPDATE Issues
  SET return_date = ret_date
  WHERE issue_id = issueid;

  -- Increment available copies of the book
  UPDATE Books
  SET available_copies = available_copies + 1
  WHERE book_id = bid;
END //

DELIMITER ;
CALL ReturnBook(2021, '2025-10-30');
SELECT * FROM Books;
-- # book_id, title, author, isbn, total_copies, available_copies
-- '201', 'Database Systems', 'Ramez Elmasri', '978-013207', '3', '2'
-- '202', 'Clean Code', 'Robert C. Martin', '978-013235', '2', '1'
-- '203', 'Introduction to Algorithms', 'Cormen', '978-026203', '4', '4'
-- '204', 'Design Patterns', 'Gamma et al.', '978-020163', '1', '1'
-- '205', 'Web Development with Node', 'Shelley Powers', '978-149200', '2', '2'

-- Procedure to issue a book
DELIMITER //

CREATE PROCEDURE IssueBook(
  IN iissueid INT,
  IN ibookid INT,
  IN imemberid INT,
  IN iissuedate DATE,
  IN iduedate DATE
)
BEGIN
  DECLARE avail INT;

  -- Check available copies
  SELECT available_copies INTO avail FROM Books WHERE book_id = ibookid;

  IF avail > 0 THEN
    -- Issue the book
    INSERT INTO Issues (issue_id, book_id, member_id, issue_date, due_date, return_date)
    VALUES (iissueid, ibookid, imemberid, iissuedate, iduedate, NULL);

    -- Decrease available copies
    UPDATE Books
    SET available_copies = available_copies - 1
    WHERE book_id = ibookid;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No copies available to issue.';
  END IF;
END //

DELIMITER ;
CALL IssueBook(3010, 203, 2, '2025-10-26', '2025-11-05');
SELECT * FROM Issues;
-- # issue_id, book_id, member_id, issue_date, due_date, return_date
-- '3001', '201', '1', '2025-04-01', '2025-04-15', NULL
-- '3002', '202', '2', '2025-03-20', '2025-04-03', '2025-04-02'
-- '3003', '203', '3', '2025-04-05', '2025-04-19', NULL
-- '3004', '201', '4', '2025-03-25', '2025-04-08', '2025-04-07'
-- '3005', '205', '1', '2025-04-10', '2025-04-24', NULL
-- '3010', '203', '2', '2025-10-26', '2025-11-05', NULL

-- # book_id, title, author, isbn, total_copies, available_copies
-- '201', 'Database Systems', 'Ramez Elmasri', '978-013207', '3', '2'
-- '202', 'Clean Code', 'Robert C. Martin', '978-013235', '2', '1'
-- '203', 'Introduction to Algorithms', 'Cormen', '978-026203', '4', '3'
-- '204', 'Design Patterns', 'Gamma et al.', '978-020163', '1', '1'
-- '205', 'Web Development with Node', 'Shelley Powers', '978-149200', '2', '2'
