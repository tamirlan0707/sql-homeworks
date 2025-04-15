
---EASY LEVEL----
--TASK 1 --
SELECT c.FirstName CustomerName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
;

--TASK 2 --
SELECT e.[Name] AS EmpName, e.Department, ed.Salary
FROM EmployeesDetail ed
INNER JOIN Employees e ON ed.EmployeeID =e.EmployeeID
;

--TASK 3 --
SELECT p.ProductName, c.name CategoryName
FROM Products p 
INNER JOIN Categories c ON p.CategoryID = c.ID

--TASK 4 --
SELECT c.CustomerID, o.CustomerID, o.OrderDate
FROM sales.Customer c
LEFT JOIN [Sales].[SalesOrderHeader] o ON c.CustomerID = o.CustomerID;

--TASK 5 --
SELECT TOP 100 p.ProductID, p.[Name],oh.OrderDate, od.ModifiedDate
FROM [Sales].[SalesOrderHeader] oh
INNER JOIN [Sales].[SalesOrderDetail] od ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN [Production].[Product] p ON p.ProductID = od.ProductID

--TASK 6 --
SELECT p.[Name] ProductName, c.[Name] CategoryName
FROM [Production].[Product] p
CROSS JOIN [Production].[ProductCategory] c 
WHERE p.ProductSubcategoryID = c.ProductCategoryID

--TASK 7 --
SELECT c.CustomerID CusID, o.CustomerID OrCusID, o.ModifiedDate
FROM [Sales].[Customer] c
INNER JOIN [Sales].[SalesOrderHeader] o ON c.CustomerID = o.CustomerID

--TASK 8 --
SELECT p.[Name], o.LineTotal
FROM [Production].[Product] p
CROSS JOIN [Sales].[SalesOrderDetail] o
WHERE o.LineTotal > 500

--TASK 9 --
SELECT e.Name, d.DepName
FROM Employees e
INNER JOIN Department d ON e.DepID = d.DepID;

--TASK 10 --
SELECT e.dep_id EmpDepID, d.dep_id DepID, e.emp_name EmpName, d.dep_name DepName
FROM [Employee].[employees] e
JOIN [Employee].[department] d ON e.dep_id <> d.dep_id

---MEDIUM LEVEL TASK---
--TASK 11--
SELECT c.customer_id, c.cust_name CustomerName, COUNT(o.ord_no) TotalOrders
FROM [Inventory].[Customer] c
JOIN [Inventory].[Orders] o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.cust_name

--TASK 12--
SELECT s.[Name], c.Title Courses
FROM Students s
INNER JOIN StudentCourses sc ON s.StudentID = sc.StudentID
INNER JOIN Courses c ON c.CourseID = sc.CourseID

--TASK 13--
SELECT d.department_name DepName, e.salary
FROM [HR].[Employees] e
CROSS JOIN [HR].[Departments] d
WHERE salary >5000

--TASK 14--
SELECT e.emp_id, d.emp_fname, d.emp_lname, d.emp_dept
FROM Employees e
INNER JOIN emp_details d ON e.emp_id = d.emp_id;

--TASK 15--
SELECT p.ProductName, s.SupplierName
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE s.SupplierName = 'Supplier A'

--TASK 16--
SELECT p.ProductName, s.Sales 
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID

--TASK 17--
SELECT e.first_name EmpName, d.department_name DepName, e.Salary
FROM [HR].[Employees] e
INNER JOIN [HR].[Departments] d ON e.department_id = d.department_id
WHERE e.salary >4000 AND d.department_name = 'IT'
--TASK 17--ONE MORE SOLUTION---
SELECT e.first_name EmpName, d.department_name DepName, e.Salary
FROM [HR].[Employees] e,[HR].[Departments] d
WHERE e.department_id = d.department_id
AND e.salary >4000 
AND d.department_name = 'IT'

--TASK 18--
SELECT o.OrderID, o.OrderAmount, p.PaymentAmount
FROM Orders o
INNER JOIN Payments p ON p.PaymentAmount >= o.OrderAmount;

--TASK 19--
SELECT p.ProductName, p.Price, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.Price >= 50;

--TASK 20--
SELECT s.SalesAmount, r.RegionName
FROM Sales s
CROSS JOIN Regions r
WHERE s.SalesAmount > 1000;
