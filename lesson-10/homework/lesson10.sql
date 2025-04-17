--EASY LEVEL HOMEWORK---

--TASK 1--
SELECT e.[Name] AS EmployeeName,  e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000

--TASK 2--
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023

--TASK 3--
SELECT e.[Name] EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID

--TASK 4--
SELECT s.SupplierName, p.ProductName
FROM Products p
RIGHT JOIN Suppliers s ON p.SupplierID = s.SupplierID

--TASK 5--
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount 
FROM Orders o
FULL JOIN Payments p ON o.OrderID = p.OrderID

--TASK 6--
SELECT e1.[Name] EmployeeName, e2.[Name] ManagerName
FROM Employees e1
INNER JOIN Employees e2 ON e2.EmployeeID = e1.ManagerID

--TASK 7--
SELECT  s.[Name] AS StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101'

--TASK 8--
SELECT c.FirstName, c.LastName, o.Quantity
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity >3;

--TASK 9--
SELECT e.[Name] AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources'

--MEDIUM LEVEL HOMEWORK---

--TASK 10--
SELECT d.DepartmentName, COUNT(e.DepartmentID) AS EmployeeCount
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID =d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.DepartmentID) > 10

--TASK 11--
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL

--TASK 12--
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >=1;

--TASK 13--
SELECT e.[Name] EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID

--TASK 14--
SELECT e1.[Name] AS Employee1, e2.[Name] AS Employee2, e1.ManagerID
FROM Employees e1
INNER JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID

--TASK 15--
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022

--TASK 16--
SELECT e.[Name] AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

--TASK 17--
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o 
INNER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.Amount IS NOT NULL

--TASK 18--
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL

--HARD LEVEL HOMEWORK---

--TASK 19--
SELECT [Name] AS EmployeeName, Salary
FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

--TASK 20--
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE YEAR(o.OrderDate) < 2020 AND p.Amount IS NULL

--TASK 21--
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON TRY_CAST(p.Category AS INT) = c.CategoryID
WHERE c.CategoryID IS NULL

--TASK 22--
SELECT e1.[Name] AS Employee1, e2.[Name] AS Employee2, e1.ManagerID, e2.Salary
FROM Employees e1
INNER JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID AND e1.Salary >60000 AND e2.Salary > 60000;

--TASK 23--
SELECT e.[Name] AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.[Name] LIKE 'M%'

--TASK 24--
SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500

--TASK 25--
SELECT s.StudentID, s.[Name] AS StudentName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
WHERE e.StudentID = s.StudentID AND c.CourseName ='Math 101';

--TASK 26--
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL

--TASK 27--
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories C ON TRY_CAST(p.Category AS INT) = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture')
