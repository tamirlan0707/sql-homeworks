---EASY LEVEL LESSON 9---

---TASK 1 -----
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s

---TASK 2 -----
SELECT e.[Name], d.DepartmentName
FROM Employees e
CROSS JOIN Departments d

---TASK 3 -----
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID

---TASK 4 -----
SELECT c.CustomerID, CONCAT(c.FirstName,' ',c.LastName) CustomerFullName, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID

---TASK 5 -----
SELECT s.StudentID, s.[Name], c.[CourseName]
FROM Courses c
CROSS JOIN Students s

---TASK 6 -----
SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID

---TASK 7 -----
SELECT e.[Name], d.DepartmentID
FROM Departments d
INNER JOIN Employees e ON d.DepartmentID = e.DepartmentID

---TASK 8 -----
SELECT s.[Name], e.CourseID
FROM Students s 
INNER JOIN Enrollments e ON s.StudentID = e.StudentID

---TASK 9 -----
SELECT o.OrderID, p.PaymentID, p.Amount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID

---TASK 10 -----
SELECT p.ProductName, o.OrderID, p.Price
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price >100

---MEDIUM LEVEL LESSON 9---


---TASK 11 -----
SELECT e.[Name], d.DepartmentName, e.DepartmentID, d.DepartmentID
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID

---TASK 12 -----
SELECT o.OrderID, p.ProductName, o.Quantity, p.StockQuantity
FROM Orders o 
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity


---TASK 13 -----
SELECT CONCAT(c.FirstName, ' ', c.LastName), s.ProductID, s.SaleAmount
FROM Customers c
INNER JOIN Sales s On c.CustomerID = s.CustomerID
WHERE s.SaleAmount >=500

---TASK 14 -----
SELECT s.[Name], c.CourseName
FROM Courses c
INNER JOIN Enrollments e ON c.CourseID = e.CourseID
INNER JOIN Students s ON s.StudentID = e.StudentID

---TASK 15 -----
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID
WHERE s.SupplierName LIKE '%Tech%'

---TASK 16 -----
SELECT o.OrderID, o.TotalAmount, p.Amount
FROM Orders o 
INNER JOIN Payments p ON p.OrderID = o.OrderID
WHERE p.Amount < o.TotalAmount

---TASK 17 -----
SELECT e.[Name] EmpName, e.Salary EmpSalary, m.[Name] ManagerName, m.Salary ManagerSalary
FROM Employees e
INNER JOIN Employees m ON m.EmployeeID = e.ManagerID
WHERE e.Salary > m.Salary;

---TASK 18 -----
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryName = 'Electronics' OR c.CategoryName = 'Furniture';

---TASK 19 -----
SELECT s.SaleID, c.FirstName, c.Country
FROM Sales s 
INNER JOIN Customers c ON c.CustomerID = s.CustomerID
WHERE c.Country = 'USA'

---TASK 20 -----
SELECT o.OrderID, c.FirstName, c.Country, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100

---HARD LEVEL LESSON 9---
  
--TASK 21 ---
SELECT e1.[Name] EmpName1, e1.DepartmentID DepName1, e2.[Name] EmpName2, e2.DepartmentID DepName2
FROM Employees e1
INNER JOIN Employees e2 ON e1.EmployeeID < e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID

--TASK 22 ---
SELECT p.PaymentID, o.OrderID, p.Amount, o.Quantity, pr.Price, (o.Quantity * pr.Price) CalculatedAmount
FROM Payments p
INNER JOIN Orders o ON p.OrderID = o.OrderID
INNER JOIN Products pr ON pr.ProductID = o.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price)

--TASK 23 ---
SELECT s.StudentID, s.[Name], e.EnrollmentID
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL

--TASK 24 ---
SELECT e1.[Name] AS EmployeeName, e1.Salary AS EmployeeSalary, e2.[Name] AS ManagerName, e2.Salary AS ManagerSalary
FROM Employees e1
INNER JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID
WHERE e1.Salary <= e2.Salary;

--TASK 25 ---
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;
