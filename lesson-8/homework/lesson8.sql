CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, Name, Position, Department, HireDate) VALUES
(1, 'John Doe',         'Sales Manager',    'Sales',    '2020-03-15'),
(2, 'Jane Smith',       'HR Specialist',    'HR',       '2019-07-01'),
(3, 'Emily Johnson',    'Software Engineer','IT',       '2021-01-10'),
(4, 'Michael Brown',    'Accountant',       'Finance',  '2018-11-25'),
(5, 'Chris Davis',      'Sales Rep',        'Sales',    '2020-06-20'),
(6, 'Sarah Miller',     'Developer',        'IT',       '2022-02-05'),
(7, 'David Wilson',     'HR Manager',       'HR',       '2017-09-30'),
(8, 'Laura Moore',      'Financial Analyst','Finance',  '2016-12-12'),
(9, 'Daniel Taylor',    'Sales Rep',        'Sales',    '2023-04-01'),
(10,'Sophia Anderson',  'Lead Developer',   'IT',       '2021-08-18');

CREATE TABLE EmployeesDetail (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);
INSERT INTO EmployeesDetail (EmployeeID, FirstName, LastName, Department, HireDate, Salary) VALUES
(1, 'John',     'Doe',       'Sales',     '2020-03-15', 55000.00),
(2, 'Jane',     'Smith',     'HR',        '2019-07-01', 60000.00),
(3, 'Emily',    'Johnson',   'IT',        '2021-01-10', 72000.00),
(4, 'Michael',  'Brown',     'Finance',   '2018-11-25', 68000.00),
(5, 'Chris',    'Davis',     'Sales',     '2020-06-20', 54000.00),
(6, 'Sarah',    'Miller',    'IT',        '2022-02-05', 75000.00),
(7, 'David',    'Wilson',    'HR',        '2017-09-30', 63000.00),
(8, 'Laura',    'Moore',     'Finance',   '2016-12-12', 70000.00),
(9, 'Daniel',   'Taylor',    'Sales',     '2023-04-01', 52000.00),
(10,'Sophia',   'Anderson',  'IT',        '2021-08-18', 77000.00);

---EASY LEVEL----
--TASK 1 --
SELECT c.FirstName CustomerName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
;

--TASK 2 --
SELECT * FROM Employees;

SELECT * FROM EmployeesDetail;

SELECT e.[Name] AS EmpName, e.Department, ed.Salary
FROM EmployeesDetail ed
INNER JOIN Employees e ON ed.EmployeeID =e.EmployeeID
;

--TASK 3 --
SELECT * FROM Products;

SELECT * FROM category;

SELECT p.ProductName, c.name CategoryName
FROM Products p 
INNER JOIN Categories c ON p.CategoryID = c.ID

--TASK 4 --

SELECT * FROM sales.Customer;

SELECT * FROM [Sales].[SalesOrderHeader]

SELECT c.CustomerID, o.CustomerID, o.OrderDate
FROM sales.Customer c
LEFT JOIN [Sales].[SalesOrderHeader] o ON c.CustomerID = o.CustomerID;

--TASK 5 --
SELECT * FROM [Sales].[SalesOrderHeader]

SELECT * FROM [Sales].[SalesOrderDetail]

SELECT * FROM [Production].[Product]

SELECT TOP 100 p.ProductID, p.[Name],oh.OrderDate, od.ModifiedDate
FROM [Sales].[SalesOrderHeader] oh
INNER JOIN [Sales].[SalesOrderDetail] od ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN [Production].[Product] p ON p.ProductID = od.ProductID

--TASK 6 --
SELECT * FROM [Production].[Product]
SELECT * FROM [Production].[ProductCategory]

SELECT p.[Name] ProductName, c.[Name] CategoryName
FROM [Production].[Product] p
CROSS JOIN [Production].[ProductCategory] c 
WHERE p.ProductSubcategoryID = c.ProductCategoryID

--TASK 7 --

SELECT c.CustomerID CusID, o.CustomerID OrCusID, o.ModifiedDate
FROM [Sales].[Customer] c
INNER JOIN [Sales].[SalesOrderHeader] o ON c.CustomerID = o.CustomerID

--TASK 8 --
SELECT * FROM [Production].[Product]
SELECT * FROM [Sales].[SalesOrderDetail]

SELECT p.[Name], o.LineTotal
FROM [Production].[Product] p
CROSS JOIN [Sales].[SalesOrderDetail] o
WHERE o.LineTotal > 500

--TASK 9 --
SELECT e.Name, d.DepName
FROM Employees e
INNER JOIN Department d ON e.DepID = d.DepID;

--TASK 10 --
SELECT * FROM [Employee].[department]
SELECT * FROM [Employee].[employees]

SELECT e.dep_id EmpDepID, d.dep_id DepID, e.emp_name EmpName, d.dep_name DepName
FROM [Employee].[employees] e
JOIN [Employee].[department] d ON e.dep_id <> d.dep_id

---MEDIUM LEVEL TASK---
--TASK 11--
SELECT * FROM [Inventory].[Customer]
SELECT * FROM [Inventory].[Orders]


SELECT c.customer_id, c.cust_name CustomerName, COUNT(o.ord_no) TotalOrders
FROM [Inventory].[Customer] c
JOIN [Inventory].[Orders] o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.cust_name



--TASK 12--
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM StudentCourses;

SELECT s.[Name], c.Title Courses
FROM Students s
INNER JOIN StudentCourses sc ON s.StudentID = sc.StudentID
INNER JOIN Courses c ON c.CourseID = sc.CourseID

--TASK 13--

SELECT * FROM [HR].[Employees]
SELECT * FROM [HR].[Departments]

SELECT d.department_name DepName, e.salary
FROM [HR].[Employees] e
CROSS JOIN [HR].[Departments] d
WHERE salary >5000

--TASK 14--


SELECT e.emp_id, d.emp_fname, d.emp_lname, d.emp_dept
FROM Employees e
INNER JOIN emp_details d ON e.emp_id = d.emp_id;

--TASK 15--

SELECT * FROM Suppliers
SELECT * FROM Products

SELECT p.ProductName, s.SupplierName
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE s.SupplierName = 'Supplier A'

--TASK 16--
SELECT p.ProductName, s.Sales 
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID

--TASK 17--

SELECT * FROM [HR].[Employees]
SELECT * FROM [HR].[Departments]

SELECT e.first_name EmpName, d.department_name DepName, e.Salary
FROM [HR].[Employees] e
INNER JOIN [HR].[Departments] d ON e.department_id = d.department_id
WHERE e.salary >4000 AND d.department_name = 'IT'

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
