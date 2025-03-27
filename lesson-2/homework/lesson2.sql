-- ===============================
-- 🟢 EASY-LEVEL TASKS (10)
-- ===============================

-- 1. Определение DDL и DML с примерами
-- DDL (Data Definition Language) — язык определения данных, изменяет структуру базы данных.
-- Примеры: CREATE, ALTER, DROP
-- DML (Data Manipulation Language) — язык управления данными, изменяет данные в таблицах.
-- Примеры: INSERT, UPDATE, DELETE

-- 2. Создание таблицы Employees
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 3. Вставка трех записей в Employees
INSERT INTO Employees (EmpID, Name, Salary) VALUES 
    (1, 'John Doe', 5000.00),
    (2, 'Jane Smith', 6000.00),
    (3, 'Robert Brown', 5500.00);

-- 4. Обновление зарплаты сотрудника с EmpID = 1
UPDATE Employees 
SET Salary = 5200.00 
WHERE EmpID = 1;

-- 5. Удаление записи из Employees, где EmpID = 2
DELETE FROM Employees
WHERE EmpID = 2;

-- 6. Разница между DELETE, DROP и TRUNCATE:
-- DELETE удаляет данные, но оставляет структуру.
-- TRUNCATE удаляет все данные без логирования, но оставляет структуру.
-- DROP удаляет таблицу полностью.

-- 7. Изменение типа данных Name в Employees
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 8. Добавление нового столбца Department
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 9. Использование SSMS для создания CompanyDB (сделать вручную, затем сделать скриншот).

-- 10. Описание TRUNCATE TABLE:
-- TRUNCATE TABLE Employees; -- очищает все записи, но не удаляет структуру.

-- ===============================
-- 🟠 MEDIUM-LEVEL TASKS (10)
-- ===============================

-- 1. Создание таблицы Departments с внешним ключом на Employees
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID)
);

-- 2. Вставка данных в Departments из другой таблицы
INSERT INTO Departments (DeptID, DeptName, ManagerID)
SELECT DepartmentID, DepartmentName, HeadID FROM OtherTable
WHERE DepartmentID <= 5;

-- 3. Обновление отдела сотрудников с зарплатой > 5000
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 4. Удаление всех записей из Employees без удаления структуры
TRUNCATE TABLE Employees;

-- 5. Разница между VARCHAR и NVARCHAR:
-- VARCHAR хранит строки в однобайтовом формате (ANSI), NVARCHAR — в Unicode (UTF-16).
-- NVARCHAR рекомендуется для мультиязычных данных.

-- 6. Изменение типа данных Salary на FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 7. Удаление столбца Department из Employees
ALTER TABLE Employees
DROP COLUMN Department;

-- 8. Использование SSMS для добавления JoinDate (сделать вручную, затем скриншот).

-- 9. Создание временной таблицы и вставка записей
CREATE TABLE #TempEmployees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50)
);

INSERT INTO #TempEmployees (EmpID, Name) VALUES 
    (1, 'Alice Johnson'),
    (2, 'Michael White');

-- 10. Полное удаление таблицы Departments
DROP TABLE Departments;

-- ===============================
-- 🔴 HARD-LEVEL TASKS (10)
-- ===============================

-- 1. Создание таблицы Customers с CHECK (возраст > 18)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age > 18)
);

-- 2. Удаление сотрудников без повышения зарплаты за 2 года
DELETE FROM Employees
WHERE EmpID IN (
    SELECT EmpID 
    FROM SalaryHistory
    WHERE LastIncreaseDate <= DATEADD(YEAR, -2, GETDATE())
);

-- 3. Хранимая процедура для добавления сотрудника
CREATE PROCEDURE InsertEmployee
    @EmpID INT,
    @Name VARCHAR(100),
    @Salary DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Employees (EmpID, Name, Salary)
    VALUES (@EmpID, @Name, @Salary);
END;

-- Вызов процедуры
EXEC InsertEmployee 4, 'Alice Johnson', 7000.00;

-- 4. Создание резервной копии таблицы Employees
SELECT * INTO Employees_Backup
FROM Employees;

-- 5. Вставка нескольких строк через MERGE INTO
MERGE INTO Employees AS Target
USING NewEmployees AS Source
ON Target.EmpID = Source.EmpID
WHEN MATCHED THEN 
    UPDATE SET Target.Salary = Source.Salary
WHEN NOT MATCHED THEN
    INSERT (EmpID, Name, Salary) VALUES (Source.EmpID, Source.Name, Source.Salary);

-- 6. Удаление и воссоздание базы данных CompanyDB
DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;

-- 7. Переименование Employees в StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- 8. Разница между CASCADE DELETE и CASCADE UPDATE
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

-- 9. Сброс IDENTITY после удаления всех записей
DBCC CHECKIDENT ('Employees', RESEED, 1);

-- 10. Создание таблицы с PRIMARY KEY и UNIQUE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    Price DECIMAL(10,2)
);
