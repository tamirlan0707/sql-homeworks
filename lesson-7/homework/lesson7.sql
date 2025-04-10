CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Region VARCHAR(50),
    OrderAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerID, Region, OrderAmount)
VALUES
(1, 1, 'North', 100),
(2, 2, 'South', 150),
(3, 3, 'East', 200),
(4, 4, 'West', 50),
(5, 1, 'North', 120),
(6, 2, 'South', 180),
(7, 5, 'East', 160),
(8, 6, 'West', 90),
(9, 5, 'North', 110),
(10, 7, 'South', 130);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Smartphone', 'Electronics', 800.00),
(3, 'Desk Chair', 'Furniture', 150.00),
(4, 'Coffee Table', 'Furniture', 220.00),
(5, 'Water Bottle', 'Accessories', 25.00),
(6, 'Backpack', 'Accessories', 45.00),
(7, 'Monitor', 'Electronics', 300.00);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    Age INT,
    JobTitle VARCHAR(100)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, Age, JobTitle) VALUES
(1, 'Alice', 'Johnson', 'HR', 50000.00, 29, 'Software Engineer'),
(2, 'Bob', 'Smith', 'IT', 75000.00, 35, 'Data Analyst'),
(3, 'Carol', 'White', 'IT', 72000.00, 32, 'HR Manager'),
(4, 'David', 'Brown', 'Finance', 68000.00, 41, 'Software Engineer'),
(5, 'Eva', 'Green', 'HR', 52000.00, 27, 'Data Analyst'),
(6, 'Frank', 'Moore', 'Finance', 70000.00, 38, 'HR Manager'),
(7, 'Grace', 'Taylor', 'Marketing', 48000.00, 30, 'Sales Representative');


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, City) VALUES
(1, 'John', 'Doe', 'johndoe@email.com', '123-456-7890', 'New York'),
(2, 'Jane', 'Smith', 'janesmith@email.com', '987-654-3210', 'Los Angeles'),
(3, 'Alice', 'Johnson', 'alicejohnson@email.com', '456-789-0123', 'Chicago'),
(4, 'Bob', 'Williams', 'bobwilliams@email.com', '321-654-9870', 'Houston'),
(5, 'Charlie', 'Brown', 'charliebrown@email.com', '654-321-8765', 'Phoenix');

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    TotalAmount DECIMAL(10, 2)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate, TotalAmount) VALUES
(1, 1, 2, '2025-04-01', 2400.00),  -- 2 Лaptops по 1200
(2, 2, 3, '2025-04-02', 2400.00),  -- 3 Smartphones по 800
(3, 3, 5, '2025-04-03', 750.00),   -- 5 Desk Chairs по 150
(4, 4, 2, '2025-04-04', 440.00),   -- 2 Coffee Tables по 220
(5, 5, 10, '2025-04-05', 250.00),  -- 10 Water Bottles по 25
(6, 6, 4, '2025-04-06', 180.00),   -- 4 Backpacks по 45
(7, 7, 1, '2025-04-07', 300.00);   -- 1 Monitor за 300

ALTER TABLE Sales
ADD Region VARCHAR(50);

UPDATE Sales
SET Region = 'North America'
WHERE SaleID = 1;

UPDATE Sales
SET Region = 'Europe'
WHERE SaleID = 2;

UPDATE Sales
SET Region = 'Asia'
WHERE SaleID = 3;

UPDATE Sales
SET Region = 'Europe'
WHERE SaleID = 4;

UPDATE Sales
SET Region = 'North America'
WHERE SaleID = 5;

UPDATE Sales
SET Region = 'Asia'
WHERE SaleID = 6;

UPDATE Sales
SET Region = 'North America'
WHERE SaleID = 7;


----TASK 1------
SELECT MIN(price)
FROM Products;

----TASK 2------
SELECT MAX(Salary)
FROM Employees;

----TASK 3------
SELECT COUNT(*)
FROM Customers;

----TASK 4------
SELECT COUNT(DISTINCT category)
FROM Products;

----TASK 5------
SELECT SUM(TotalAmount)
FROM Sales
WHERE ProductID = 1;

----TASK 6------
SELECT AVG(age)
FROM Employees;

----TASK 7------
SELECT Department, COUNT(EmployeeID)
FROM Employees
GROUP BY Department;

----TASK 8------
SELECT Category, MIN(price) AS MP, MAX(price) AS MX
FROM Products
GROUP BY Category;

----TASK 9------
SELECT Region, SUM(TotalAmount) AS TotalSales
FROM Sales
GROUP BY Region;

----TASK 10------
SELECT Department, COUNT(*) AS EmpCount
FROM Employees
GROUP BY Department 
HAVING COUNT(*) >=5;

-------Medium-Level Tasks-----
----TASK 11------
SELECT category, SUM(TotalAmount) TotalSales, AVG(TotalAmount) AvgSales
FROM Sales s
JOIN Products p 
ON
s.ProductID = p.ProductID
GROUP BY p.Category

----TASK 12------

SELECT JobTitle, COUNT(JobTitle) SpecificJobTitle
FROM Employees
GROUP BY JobTitle;

----TASK 13------
SELECT Department, MAX(Salary) MaxSalary, MIN(Salary) MinSalary
FROM Employees
GROUP BY Department;

----TASK 14------
SELECT Department, AVG(Salary) AvgDep
FROM Employees
GROUP BY Department;

----TASK 15------
SELECT Department, AVG(Salary) AvgSalary, COUNT(*) EmpDep
FROM Employees
GROUP BY Department;

----TASK 16------
SELECT Category, AVG(Price) AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) >100

----TASK 17------
SELECT * FROM Products;
SELECT * FROM Sales;
----"Write a query to count how many products have sales above 100 units using COUNT(DISTINCT ProductID)."
SELECT COUNT(DISTINCT s.ProductID) AS ProductCount
FROM Products p
JOIN Sales s 
ON p.ProductID = s.ProductID
HAVING SUM(s.Quantity) >3

----TASK 18------
SELECT YEAR(SaleDate), SUM(TotalAmount)
FROM Sales
GROUP BY YEAR(SaleDate);

----TASK 19------
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT o.Region, COUNT(DISTINCT o.CustomerID) NumCust
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY o.Region;

----TASK 20------
SELECT * FROM Employees;
SELECT Department, SUM(Salary)
FROM Employees
GROUP BY Department
HAVING SUM(Salary) >100000
