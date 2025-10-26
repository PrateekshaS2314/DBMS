CREATE DATABASE SchoolDB;
USE SchoolDB;

CREATE TABLE Classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50),
  teacher_in_charge VARCHAR(100)
);

CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  name VARCHAR(100),
  dob DATE,
  class_id INT,
  FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

CREATE TABLE Marks (
  mark_id INT PRIMARY KEY,
  student_id INT,
  subject VARCHAR(100),
  marks INT,
  exam_date DATE,
  FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Sample data
INSERT INTO Classes VALUES
(1,'Grade 10 - A','Ms. Sharma'),
(2,'Grade 10 - B','Mr. Kumar'),
(3,'Grade 9 - A','Ms. Das'),
(4,'Grade 8 - A','Mr. Roy'),
(5,'Grade 12 - Science','Dr. Sen');

INSERT INTO Students VALUES
(1,'Isha Patel','2009-05-12',1),
(2,'Kunal Verma','2009-07-23',1),
(3,'Ria Sinha','2009-09-01',2),
(4,'Aman Gupta','2010-02-10',3),
(5,'Sana Khan','2008-12-20',5);

INSERT INTO Marks VALUES
(8001,1,'Math',88,'2025-03-20'),
(8002,1,'Science',92,'2025-03-21'),
(8003,2,'Math',76,'2025-03-20'),
(8004,3,'Math',85,'2025-03-20'),
(8005,5,'Physics',95,'2025-03-22');

-- Queries

-- 1. Class-wise average marks
SELECT c.class_id, c.class_name, AVG(m.marks) AS Avg_Marks
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Marks m ON s.student_id = m.student_id
GROUP BY c.class_id, c.class_name;
-- # class_id, class_name, Avg_Marks
-- '1', 'Grade 10 - A', '85.3333'
-- '2', 'Grade 10 - B', '85.0000'
-- '5', 'Grade 12 - Science', '95.0000'

-- 2. Class-wise student marks list
SELECT c.class_name, s.student_id, s.name, m.subject, m.marks
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Marks m ON s.student_id = m.student_id
ORDER BY c.class_name, s.name;
-- # class_name, student_id, name, subject, marks
-- 'Grade 10 - A', '1', 'Isha Patel', 'Math', '88'
-- 'Grade 10 - A', '1', 'Isha Patel', 'Science', '92'
-- 'Grade 10 - A', '2', 'Kunal Verma', 'Math', '76'
-- 'Grade 10 - B', '3', 'Ria Sinha', 'Math', '85'
-- 'Grade 12 - Science', '5', 'Sana Khan', 'Physics', '95'

-- 3. Students who scored above 90
SELECT s.student_id, s.name, m.subject, m.marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
WHERE m.marks > 90;
-- # student_id, name, subject, marks
-- '1', 'Isha Patel', 'Science', '92'
-- '5', 'Sana Khan', 'Physics', '95'

-- Procedure to insert a new student
DELIMITER //
CREATE PROCEDURE InsertStudent(
  IN sid INT, IN sname VARCHAR(100), IN sdob DATE, IN sclass INT
)
BEGIN
  INSERT INTO Students VALUES (sid, sname, sdob, sclass);
END //
DELIMITER ;
CALL InsertStudent(6, 'Ravi Menon', '2009-08-15', 2);
-- SELECT * FROM Students;
-- # student_id, name, dob, class_id
-- '1', 'Isha Patel', '2009-05-12', '1'
-- '2', 'Kunal Verma', '2009-07-23', '1'
-- '3', 'Ria Sinha', '2009-09-01', '2'
-- '4', 'Aman Gupta', '2010-02-10', '3'
-- '5', 'Sana Khan', '2008-12-20', '5'
-- '6', 'Ravi Menon', '2009-08-15', '2'

-- Procedure to update marks
DELIMITER //
CREATE PROCEDURE UpdateMarks(
  IN mid INT, IN new_marks INT
)
BEGIN
  UPDATE Marks SET marks = new_marks WHERE mark_id = mid;
END //
DELIMITER ;
CALL UpdateMarks(8003, 85);
SELECT * FROM Marks;
-- # mark_id, student_id, subject, marks, exam_date
-- '8001', '1', 'Math', '88', '2025-03-20'
-- '8002', '1', 'Science', '92', '2025-03-21'
-- '8003', '2', 'Math', '85', '2025-03-20'
-- '8004', '3', 'Math', '85', '2025-03-20'
-- '8005', '5', 'Physics', '95', '2025-03-22'
