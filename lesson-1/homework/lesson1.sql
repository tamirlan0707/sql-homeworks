



CREATE TABLE Employees(
EmpID INT IDENTITY(1,1) PRIMARY KEY,
[Name] VARCHAR(50),
Salary DECIMAL(10,2),
);
ALTER TABLE Employees
ADD Department VARCHAR(50);

SELECT * FROM Employees;

INSERT INTO Employees ([Name],Salary)
VALUES 

('Ozodbek',50000.00),
('Timur',40000.00),
('Xudoyor',95000.00);

UPDATE Employees SET Salary = 52000.00 WHERE EmpID = 1;	

DELETE FROM Employees WHERE EmpID = 2;


TRUNCATE TABLE Employees;

DROP TABLE Employees;

ALTER TABLE Employees
ALTER COLUMN NAME VARCHAR(100);

TRUNCATE TABLE Employees;
