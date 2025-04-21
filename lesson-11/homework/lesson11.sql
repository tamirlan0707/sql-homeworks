

----EASY-LEVEL HW 11----

--TASK 1---
SELECT o.OrderID, c.FirstName+ ' ' +c.LastName  AS CustomerName, OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022

--TASK 2---
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')

---TASK 3---
SELECT d.DepartmentName, e.Name AS TopEmployeeName, mx.MaxSalary
FROM (
      SELECT DepartmentID, MAX(Salary) AS MaxSalary
	  FROM Employees 
	  GROUP BY DepartmentID
	 -- ORDER BY MaxSalary DESC
	  ) AS mx
JOIN Employees e ON mx.DepartmentID = e.DepartmentID
JOIN Departments d ON mx.DepartmentID = d.DepartmentID
WHERE e.Salary = mx.MaxSalary
ORDER BY mx.MaxSalary DESC

---TASK 4---
SELECT 
      c.FirstName+ ' ' +c.LastName  AS CustomerName,
	  o.OrderID, 
	  o.OrderDate
	  FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023

---TASK 5---
SELECT 
    c.FirstName+ ' ' +c.LastName  AS CustomerName,
	co.TotalOrders
FROM 
(SELECT CustomerID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID) AS co
JOIN Customers c ON co.CustomerID = c.CustomerID

---TASK 6---
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies','Clothing Mart')

  ---TASK 7---
SELECT c.FirstName+ ' ' +c.LastName  AS CustomerName, ro.MostRecentOrderDate, o.OrderID
FROM Customers c
LEFT JOIN  
(SELECT CustomerID, MAX(OrderDate) AS MostRecentOrderDate
FROM Orders
GROUP BY CustomerID) AS ro ON c.CustomerID = ro.CustomerID
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
AND o.OrderDate = ro.MostRecentOrderDate

----MEDIUM-LEVEL HW 11----
  
--TASK 8--
SELECT c.FirstName+ ' ' +c.LastName  AS CustomerName, o.OrderID, o.TotalAmount AS OrderTotal
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500

  --TASK 9--
SELECT p.ProductName, s.SaleDate, s.SaleAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;

--TASK 10--
SELECT p.ProductName, ta.TotalSalesAmount
FROM(
SELECT ProductID, SUM(SaleAmount) AS TotalSalesAmount
FROM Sales
GROUP BY ProductID
) AS ta
JOIN Products p ON ta.ProductID = p.ProductID

--TASK 11--
SELECT e.[Name] AS EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' AND e.Salary > 50000

--TASK 12--
SELECT p.ProductName, s.SaleDate, p.StockQuantity
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 50

--TASK 13--
SELECT e.[Name] AS EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020;

--Hard-Level Tasks--

--TASK 14--
SELECT 
    c.FirstName+ ' ' +c.LastName  AS CustomerName, 
	o.OrderID,
	c.Address, o.OrderDate
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    c.Country = 'USA' 
	AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';
	
--TASK 15--
SELECT p.ProductName, 
       c.CategoryName, 
	   s.SaleAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
JOIN Categories c ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR s.SaleAmount > 350

--TASK 16--
SELECT c.CategoryName, pc.ProductCount
FROM Categories c
JOIN
   (SELECT Category AS CategoryID, COUNT(ProductID) AS ProductCount
    FROM Products
    GROUP BY Category) AS pc 
	ON c.CategoryID = pc.CategoryID

--TASK 17--
SELECT
    c.FirstName+ ' ' +c.LastName  AS CustomerName, 
	c.City,
	o.OrderID, 
	o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300

--TASK 18--
SELECT
    e.[Name] AS EmployeeName, 
	d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN('HR','Finance') 
          OR (
       LEN(e.[Name]) - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
           LOWER(e.[Name]), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')) >= 4 );

--TASK 19--
SELECT 
     p.ProductName, 
	 COUNT(s.ProductID) AS QuantitySold, 
	 p.Price
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Price >500
GROUP BY p.ProductName, p.Price
HAVING COUNT(s.ProductID) >100

--TASK 20--
SELECT 
    e.[Name] AS EmployeeName, 
	d.DepartmentName, 
	e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN('Sales', 'Marketing') AND e.Salary > 60000
;
