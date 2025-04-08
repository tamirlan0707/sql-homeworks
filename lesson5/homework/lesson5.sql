SELECT ProductName AS Name
FROM Products;

SELECT Client.CustomerName, Client.Country
FROM Customers AS Client;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discontinued;

SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discontinued;

SELECT ProductID, ProductName, Price
FROM Products

UNION ALL

SELECT ProductID, ProductName, Price
FROM Orders;

SELECT DISTINCT CustomerName, Country
FROM Customers;

SELECT ProductName,
       Price,
       CASE
           WHEN Price > 100 THEN 'High'
           ELSE 'Low'
       END AS PriceLevel
FROM Products;

SELECT Department, Country, COUNT(*) AS EmployeeCount
FROM Employees
WHERE Department IN ('HR', 'IT')
GROUP BY Department, Country;

SELECT Category, COUNT(ProductID) AS ProductCount
FROM Products
GROUP BY Category;

SELECT ProductName,
       Stock,
       IIF(Stock > 100, 'Yes', 'No') AS StockStatus
FROM Products;

SELECT o.OrderID, o.OrderDate, CustomerName AS ClientName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;

SELECT ProductName
FROM Products
EXCEPT
SELECT ProductName
FROM DiscontinuedProducts;

SELECT CustomerID,
       CASE
           WHEN COUNT(OrderID) > 5 THEN 'Eligible'
           ELSE 'Not Eligible'
       END AS EligibilityStatus
FROM Orders
GROUP BY CustomerID;

SELECT ProductName,
       Price,
       IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

SELECT CustomerID,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 6000;

SELECT Region, 
  SUM(SalesAmount) AS TotalSales
  FROM sales
GROUP BY Region;

SELECT c.CustomerName,
       o.OrderID,
       o.OrderDate AS DateOfOrder
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

IF EXISTS (SELECT * FROM Employees WHERE Department = 'HR')
BEGIN
    UPDATE Employees
    SET Salary = Salary * 1.10
    WHERE Department = 'HR';
END
