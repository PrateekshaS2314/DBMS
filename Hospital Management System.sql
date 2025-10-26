-- Create Database
CREATE DATABASE Hospital;
USE Hospital;

-- Tables
CREATE TABLE Patients (
  patient_id INT PRIMARY KEY,
  name VARCHAR(100),
  gender VARCHAR(10),
  dob DATE,
  phone VARCHAR(20)
);

CREATE TABLE Doctors (
  doctor_id INT PRIMARY KEY,
  name VARCHAR(100),
  specialization VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Appointments (
  appointment_id INT PRIMARY KEY,
  patient_id INT,
  doctor_id INT,
  appointment_date DATE,
  appointment_time TIME,
  remarks VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Sample data
INSERT INTO Patients VALUES
(1,'Anita Desai','Female','1986-03-12','9999000011'),
(2,'Vikram Rao','Male','1979-11-05','9999000022'),
(3,'Meera Nair','Female','1992-07-22','9999000033'),
(4,'Aditya Singh','Male','2000-01-10','9999000044'),
(5,'Ritu Patel','Female','1988-09-30','9999000055');

INSERT INTO Doctors VALUES
(101,'Dr. S. Kulkarni','Cardiology','8888000011'),
(102,'Dr. P. Menon','Neurology','8888000022'),
(103,'Dr. R. Iyer','General Physician','8888000033'),
(104,'Dr. L. Shah','Orthopedics','8888000044'),
(105,'Dr. K. Bhat','Pediatrics','8888000055');

INSERT INTO Appointments VALUES
(1001,1,101,'2025-04-10','10:30:00','Follow-up'),
(1002,2,103,'2025-04-11','09:00:00','New patient'),
(1003,3,105,'2025-04-12','11:15:00','Vaccination'),
(1004,4,104,'2025-04-13','14:00:00','Knee pain'),
(1005,5,102,'2025-04-14','15:30:00','Headache');

-- Queries

-- 1. Total patients per doctor
SELECT d.doctor_id, d.name, COUNT(a.patient_id) AS Total_Patients
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name
ORDER BY Total_Patients DESC;

-- # doctor_id, name, Total_Patients
-- '101', 'Dr. S. Kulkarni', '1'
-- '102', 'Dr. P. Menon', '1'
-- '103', 'Dr. R. Iyer', '1'
-- '104', 'Dr. L. Shah', '1'
-- '105', 'Dr. K. Bhat', '1'

-- 2. Upcoming appointments with patient & doctor details
SELECT a.appointment_id, a.appointment_date, a.appointment_time,
       p.name AS patient_name, d.name AS doctor_name, d.specialization
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= CURDATE()
ORDER BY a.appointment_date, a.appointment_time;

-- appointment_id, appointment_date, appointment_time, patient_name, doctor_name, specialization
-- null

-- 3. Patients older than 40
SELECT name, dob, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS Age
FROM Patients
WHERE TIMESTAMPDIFF(YEAR, dob, CURDATE()) > 40;

-- # name, dob, Age
-- 'Vikram Rao', '1979-11-05', '45'

-- Create procedure to insert appointment
DELIMITER //

CREATE PROCEDURE InsertAppointment(
  IN aid INT,
  IN pid INT,
  IN did INT,
  IN adate DATE,
  IN atime TIME,
  IN remarks_in VARCHAR(255)
)
BEGIN
  INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, remarks)
  VALUES (aid, pid, did, adate, atime, remarks_in);
END //

DELIMITER ;
CALL InsertAppointment(1010, 2, 104, '2025-11-02', '15:30:00', 'Follow-up visit');
SELECT * FROM Appointments;

-- # appointment_id, patient_id, doctor_id, appointment_date, appointment_time, remarks
-- '1001', '1', '101', '2025-04-10', '10:30:00', 'Follow-up'
-- '1002', '2', '103', '2025-04-11', '09:00:00', 'New patient'
-- '1003', '3', '105', '2025-04-12', '11:15:00', 'Vaccination'
-- '1004', '4', '104', '2025-04-13', '14:00:00', 'Knee pain'
-- '1005', '5', '102', '2025-04-14', '15:30:00', 'Headache'
-- '1010', '2', '104', '2025-11-02', '15:30:00', 'Follow-up visit'

-- Create procedure to update appointment date and time
DELIMITER //

CREATE PROCEDURE UpdateAppointmentDateTime(
  IN aid INT,
  IN new_date DATE,
  IN new_time TIME
)
BEGIN
  UPDATE Appointments
  SET appointment_date = new_date,
      appointment_time = new_time
  WHERE appointment_id = aid;
END //

DELIMITER ;
CALL UpdateAppointmentDateTime(1007, '2025-11-03', '16:00:00');
SELECT * FROM Appointments;

-- # appointment_id, patient_id, doctor_id, appointment_date, appointment_time, remarks
-- '1001', '1', '101', '2025-04-10', '10:30:00', 'Follow-up'
-- '1002', '2', '103', '2025-04-11', '09:00:00', 'New patient'
-- '1003', '3', '105', '2025-04-12', '11:15:00', 'Vaccination'
-- '1004', '4', '104', '2025-04-13', '14:00:00', 'Knee pain'
-- '1005', '5', '102', '2025-04-14', '15:30:00', 'Headache'
-- '1010', '2', '104', '2025-11-02', '15:30:00', 'Follow-up visit'
