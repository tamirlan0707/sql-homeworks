---Easy Tasks--
--TASK 1 -- Create a numbers table using a recursive query from 1 to 1000.
WITH RecursiveCTE AS (
	SELECT 1 AS n

UNION ALL

	SELECT n +1
	FROM RecursiveCTE

	WHERE n < 1000
	)
SELECT n
FROM RecursiveCTE 
OPTION (MAXRECURSION 1000)

--TASK 2 Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT 
	e.EmployeeID,
	e.FirstName+ ' ' +LastName As EmpName,
	dt.TotalSales
FROM Employees e
LEFT JOIN  (
	SELECT
		EmployeeID,
		SUM(SalesAmount) AS TotalSales
	FROM Sales
	GROUP BY EmployeeID ) AS dt
	ON e.EmployeeID = dt.EmployeeID
	ORDER BY TotalSales DESC

--TASK 3 Create a CTE to find the average salary of employees.(Employees)
WITH avgsalaryCTE AS (
	SELECT 
		AVG(salary) AS avg_salary
	FROM Employees
	)
	SELECT *
	FROM avgsalaryCTE

-- TASK 4 Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT *
	FROM Products p
	JOIN (
		SELECT 
			ProductID,
			MAX(SalesAmount) AS HighestSale
		FROM Sales s
		GROUP BY ProductID ) AS dt
	ON p.ProductID = dt.ProductID

--TASK 5 Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
WITH RecCTE AS (
	SELECT 1 AS n
UNION ALL
	SELECT n *2
FROM RecCTE
	WHERE n < 10000 )
SELECT * FROM RecCTE
OPTION (MAXRECURSION 0)

--TASK 6 Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

	WITH EmpCTE AS (

	SELECT  
		EmployeeID,
		COUNT(SalesId) AS SalesCount
	FROM Sales
	GROUP BY EmployeeID )

	SELECT 
		e.EmployeeID,
		e.FirstName,
		c.SalesCount
		FROM Employees e
	JOIN EmpCTE c 	
	ON e.EmployeeID = c.EmployeeID
	WHERE c.SalesCount > 5

	--TASK 7 Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH ProdCTE AS (
		SELECT 
			SalesID,
			ProductID,
			SalesAmount
		FROM Sales 
		WHERE SalesAmount > 500)

	SELECT DISTINCT
		p.ProductID,
		p.ProductName
	FROM Products p
	JOIN ProdCTE s
	ON p.ProductID = s.ProductID

	--TASK 8 Create a CTE to find employees with salaries above the average salary.(Employees)
WITH  SalaryCTE AS (
	SELECT 
		AVG(Salary) AS avg_salary
	FROM Employees )
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.LastName,
		e.Salary
	FROM Employees e
	CROSS JOIN SalaryCTE
	WHERE e.Salary > SalaryCTE.avg_salary

---Medium Tasks--
	--TASK 1 Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT TOP 5
		e.EmployeeID,
		e.FirstName,
		e.DepartmentID,
		s.NumOfOrders
	FROM Employees e

	JOIN (

	SELECT 
		EmployeeID,
		COUNT(SalesID) AS NumOfOrders
	FROM Sales 
	GROUP BY EmployeeID
	) AS s
	ON e.EmployeeID = s.EmployeeID
	ORDER BY s.NumOfOrders DESC

	--TASK 2 Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT 
		p.CategoryID,
		dt.salescategory
	FROM Products p
	JOIN (
	
	SELECT 
		p.CategoryID,
		COUNT(SalesID) AS salescategory
	FROM Sales s
	JOIN Products p ON s.ProductID = p.ProductID
	GROUP BY p.CategoryID ) AS dt
	ON p.CategoryID = dt.CategoryID

	--TASK 3 Write a script to return the factorial of each value next to it.(Numbers1)
WITH MaxN AS ( 
	SELECT 
		MAX(number) AS max_num
	FROM Numbers1 
	),

	FactorialCTE AS (
		SELECT 
			1 AS n,
			1 AS factorial
		FROM MaxN

	UNION ALL
		SELECT
			n +1,
			factorial * (n+1) 
		FROM FactorialCTE, MaxN
		WHERE n< MaxN.max_num
		)
	SELECT 
		n.Number,
		f.factorial
	FROM Numbers1 n
	JOIN FactorialCTE f
	ON N.Number = f.n;

--TASK 4 This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
WITH SplitString AS (
	SELECT 
		e.id,
		1 AS pos,
		SUBSTRING(e.string,1,1) AS ch,
		LEN(e.string) AS totallen
	FROM Example e

	UNION ALL 

		SELECT 
			s.id,
			s.pos +1,
			SUBSTRING(e.string, s.pos + 1,1),
			s.totallen
		FROM SplitString s
		JOIN example e ON e.id = s.id
		WHERE s.pos < s.totallen
		)
		SELECT id, ch FROM SplitString
		ORDER BY id, pos;

--TASK 5 Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH SalesCTE AS (
	SELECT 
		YEAR(s.SaleDate) AS SaleYear,
		MONTH(s.SaleDate) AS SaleMonth,
		SUM(s.SalesAmount) AS TotalSales
	FROM Sales s
	GROUP BY MONTH(SaleDate), YEAR(SaleDate)
	)
		SELECT 
			cur.SaleYear,
			cur.SaleMonth,
			cur.TotalSales,
			cur.TotalSales - prev.TotalSales AS DiffFromPrevMonth
		FROM SalesCTE cur
		LEFT JOIN SalesCTE prev
		ON prev.SaleYear = cur.SaleYear
		AND prev.SaleMonth = cur.SaleMonth -1;

	--TASK 6 Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT
		e.EmployeeID,
		e.FirstName+ ' '+ e.LastName AS FullName
		
	FROM Employees e
	JOIN (
	SELECT 
		s.EmployeeID,
		YEAR(s.SaleDate) AS SaleYear,
		DATEPART(QUARTER,s.SaleDate) AS SaleQuarter,
		SUM(s.SalesAmount) AS QuarterSales
	FROM Sales s
	GROUP BY s.EmployeeID, YEAR(SaleDate), DATEPART(QUARTER,SaleDate)
	 ) AS dt
	ON e.EmployeeID = dt.EmployeeID
	GROUP BY e.EmployeeID, e.FirstName, e.LastName
	HAVING MIN(dt.QuarterSales) > 4500;

---HARD TASK ---
	--TASK 1 This script uses recursion to calculate Fibonacci numbers
WITH Fibonacci (n, a, b) AS (
    -- стартовые значения
    SELECT 1, 0, 1
    UNION ALL
    -- рекурсивная часть
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 20   -- ограничение (20 чисел)
)
SELECT n, a AS FibonacciNumber
FROM Fibonacci;

---TASK 2 Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT 
	Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1 AND Vals = REPLICATE(LEFT(Vals,1), LEN(Vals));

--TASK 3 Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;

WITH NumbersCTE AS (
    -- базовый случай
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS seq
    UNION ALL
    -- рекурсивная часть
    SELECT num + 1, seq + CAST(num + 1 AS VARCHAR)
    FROM NumbersCTE
    WHERE num < @n
)
SELECT seq
FROM NumbersCTE;

--TASK 4 Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT 
        s.EmployeeID,
        SUM(s.SalesAmount) AS TotalSales
    FROM Sales s
    WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY s.EmployeeID
) AS dt
    ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT 
            s.EmployeeID,
            SUM(s.SalesAmount) AS TotalSales
        FROM Sales s
        WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY s.EmployeeID
    ) AS sub
);

--TASK 5 Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
WITH SplitChars AS (
    SELECT 
        t.ID,
        SUBSTRING(t.StringValue, v.number, 1) AS ch
    FROM RemoveDuplicateIntsFromNames t
    JOIN master.dbo.spt_values v 
        ON v.type = 'P' AND v.number BETWEEN 1 AND LEN(t.StringValue)
),
DigitsOnly AS (
    SELECT 
        ID,
        ch
    FROM SplitChars
    WHERE ch BETWEEN '0' AND '9'
),
Counts AS (
    SELECT 
        ID,
        ch,
        COUNT(*) AS cnt
    FROM DigitsOnly
    GROUP BY ID, ch
),
Filtered AS (
    SELECT 
        ID,
        ch
    FROM Counts
    WHERE cnt > 1   -- оставляем только цифры, которые встречаются более одного раза
)
SELECT 
    t.ID,
    t.StringValue AS OriginalString,
    ISNULL((
        SELECT DISTINCT f.ch
        FROM Filtered f
        WHERE f.ID = t.ID
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), '') AS CleanedString
FROM RemoveDuplicateIntsFromNames t;

