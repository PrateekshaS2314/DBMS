CREATE DATABASE Banking;
USE Banking;

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  phone VARCHAR(20),
  address VARCHAR(200)
);

CREATE TABLE Accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type VARCHAR(50),
  balance DECIMAL(14,2),
  opened_date DATE,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
  txn_id INT PRIMARY KEY,
  account_id INT,
  txn_date DATE,
  amount DECIMAL(12,2),
  txn_type VARCHAR(10), -- 'CR' or 'DR'
  description VARCHAR(255),
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Sample data
INSERT INTO Customers VALUES
(1,'Anand Kapoor','9000001111','Mumbai'),
(2,'Neeta Rao','9000002222','Pune'),
(3,'Ramesh Iyer','9000003333','Chennai'),
(4,'Sonal Gupta','9000004444','Delhi'),
(5,'Mohan Das','9000005555','Kolkata');

INSERT INTO Accounts VALUES
(9001,1,'Savings',50000.00,'2020-01-10'),
(9002,2,'Savings',75000.00,'2019-05-20'),
(9003,3,'Current',150000.00,'2021-07-15'),
(9004,4,'Savings',25000.00,'2022-03-01'),
(9005,5,'Savings',10000.00,'2023-11-05');

INSERT INTO Transactions VALUES
(11001,9001,'2025-04-10',10000.00,'CR','Salary'),
(11002,9001,'2025-04-11',2000.00,'DR','ATM Withdrawal'),
(11003,9002,'2025-04-12',5000.00,'CR','Deposit'),
(11004,9003,'2025-04-13',15000.00,'DR','Payment'),
(11005,9004,'2025-04-14',2000.00,'CR','Refund');

-- Queries

-- 1. Balance sums and max/min transaction amounts per account
SELECT a.account_id, c.name, a.balance,
       (SELECT SUM(CASE WHEN txn_type='CR' THEN amount WHEN txn_type='DR' THEN -amount ELSE 0 END) FROM Transactions t 
       WHERE t.account_id = a.account_id) AS Net_Transactions
FROM Accounts a
JOIN Customers c ON a.customer_id = c.customer_id;
-- # account_id, name, balance, Net_Transactions
-- '9001', 'Anand Kapoor', '50000.00', '8000.00'
-- '9002', 'Neeta Rao', '75000.00', '5000.00'
-- '9003', 'Ramesh Iyer', '150000.00', '-15000.00'
-- '9004', 'Sonal Gupta', '25000.00', '2000.00'
-- '9005', 'Mohan Das', '10000.00', NULL

-- 2. Total credits and debits in a date range
SELECT account_id,
       SUM(CASE WHEN txn_type='CR' THEN amount ELSE 0 END) AS Total_Credits,
       SUM(CASE WHEN txn_type='DR' THEN amount ELSE 0 END) AS Total_Debits
FROM Transactions
WHERE txn_date BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY account_id;
-- # account_id, Total_Credits, Total_Debits
-- '9001', '10000.00', '2000.00'
-- '9002', '5000.00', '0.00'
-- '9003', '0.00', '15000.00'
-- '9004', '2000.00', '0.00'

-- 3. Recent transactions with customer
SELECT t.txn_id, t.txn_date, t.amount, t.txn_type, t.description, c.name
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
ORDER BY t.txn_date DESC
LIMIT 20;
-- # txn_id, txn_date, amount, txn_type, description, name
-- '11005', '2025-04-14', '2000.00', 'CR', 'Refund', 'Sonal Gupta'
-- '11004', '2025-04-13', '15000.00', 'DR', 'Payment', 'Ramesh Iyer'
-- '11003', '2025-04-12', '5000.00', 'CR', 'Deposit', 'Neeta Rao'
-- '11002', '2025-04-11', '2000.00', 'DR', 'ATM Withdrawal', 'Anand Kapoor'
-- '11001', '2025-04-10', '10000.00', 'CR', 'Salary', 'Anand Kapoor'

-- Procedure to insert transaction and update account balance
DELIMITER //
CREATE PROCEDURE InsertTransaction(
  IN tid INT, IN accid INT, IN tdate DATE, IN amt DECIMAL(12,2), IN ttype VARCHAR(10), IN desc_in VARCHAR(255)
)
BEGIN
  INSERT INTO Transactions VALUES (tid, accid, tdate, amt, ttype, desc_in);
  IF ttype = 'CR' THEN
    UPDATE Accounts SET balance = balance + amt WHERE account_id = accid;
  ELSEIF ttype = 'DR' THEN
    UPDATE Accounts SET balance = balance - amt WHERE account_id = accid;
  END IF;
END //
DELIMITER ;
CALL InsertTransaction(11006, 9001, '2025-10-26', 5000.00, 'CR', 'Bonus');
SELECT * FROM Transactions;
-- # txn_id, account_id, txn_date, amount, txn_type, description
-- '11001', '9001', '2025-04-10', '10000.00', 'CR', 'Salary'
-- '11002', '9001', '2025-04-11', '2000.00', 'DR', 'ATM Withdrawal'
-- '11003', '9002', '2025-04-12', '5000.00', 'CR', 'Deposit'
-- '11004', '9003', '2025-04-13', '15000.00', 'DR', 'Payment'
-- '11005', '9004', '2025-04-14', '2000.00', 'CR', 'Refund'
-- '11006', '9001', '2025-10-26', '5000.00', 'CR', 'Bonus'

SELECT * FROM Accounts;
-- # account_id, customer_id, account_type, balance, opened_date
-- '9001', '1', 'Savings', '55000.00', '2020-01-10'
-- '9002', '2', 'Savings', '75000.00', '2019-05-20'
-- '9003', '3', 'Current', '150000.00', '2021-07-15'
-- '9004', '4', 'Savings', '25000.00', '2022-03-01'
-- '9005', '5', 'Savings', '10000.00', '2023-11-05'

-- Procedure to update a transaction (simple example)
DELIMITER //
CREATE PROCEDURE UpdateTransactionAmount(
  IN tid INT, IN new_amt DECIMAL(12,2)
)
BEGIN
  UPDATE Transactions SET amount = new_amt WHERE txn_id = tid;
END //
DELIMITER ;
CALL UpdateTransactionAmount(11002, 2500.00);
SELECT * FROM Transactions;
-- # txn_id, account_id, txn_date, amount, txn_type, description
-- '11001', '9001', '2025-04-10', '10000.00', 'CR', 'Salary'
-- '11002', '9001', '2025-04-11', '2500.00', 'DR', 'ATM Withdrawal'
-- '11003', '9002', '2025-04-12', '5000.00', 'CR', 'Deposit'
-- '11004', '9003', '2025-04-13', '15000.00', 'DR', 'Payment'
-- '11005', '9004', '2025-04-14', '2000.00', 'CR', 'Refund'
-- '11006', '9001', '2025-10-26', '5000.00', 'CR', 'Bonus'
