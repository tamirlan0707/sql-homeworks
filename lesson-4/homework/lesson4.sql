------Easy-Level Tasks-----

SELECT TOP 5 *
FROM Employees;

SELECT DISTINCT ProductName
FROM Products;

SELECT *
FROM Products
WHERE Price > 100;

SELECT CustomerName
FROM Customers
WHERE CustomerName LIKE 'A%';

SELECT *
FROM Products
ORDER BY Price ASC;

SELECT *
FROM Employees
ORDER BY Salary >= 5000 AND Department = 'HR';

SELECT ISNULL (Email, 'noemail@example.com') AS email
FROM Employees;

SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100;

SELECT DISTINCT Category,  ProductName
FROM Products;

SELECT *
FROM Products
ORDER BY ProductName DESC;


------Medium-Level Tasks-----

SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;

SELECT COALESCE(FirstName, LastName) AS DisplayName
FROM Employees;

SELECT DISTINCT Category, Price
FROM Products;

SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';

SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM Products
WHERE Price <= 1000 AND Stock > 50
ORDER BY Stock ASC;

SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

SELECT *
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');

SELECT *
FROM Employees
WHERE Salary > ANY (
    SELECT AVG(Salary)
    FROM Employees
    GROUP BY Department
);

SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;

------Hard-Level Tasks-----

SELECT TOP(10) ProductName, SalesAmount
FROM Products
ORDER BY SalesAmount DESC;

SELECT COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName
FROM Employees;


SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 
    (SELECT AVG(Price) * 0.9 FROM Products) AND 
    (SELECT AVG(Price) * 1.1 FROM Products);

SELECT *
FROM Employees
WHERE Age < 30
  AND Department IN ('HR', 'IT');

SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com';

SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE Department = 'Sales'
);

SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM Orders
WHERE OrderDate BETWEEN CURRENT_DATE - INTERVAL 30 DAY AND CURRENT_DATE;

SELECT *
FROM Employees e
WHERE Salary > ANY (
    SELECT AVG(Salary)
    FROM Employees
    GROUP BY Department
);
