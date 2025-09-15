--TASK 1 Easy --
SELECT id,
	LTRIM(RTRIM(SUBSTRING([Name],1,CHARINDEX(',',[Name])-1))) AS FirstName,
	LTRIM(RTRIM(SUBSTRING([Name],CHARINDEX(',',[Name])+1,LEN([Name])))) AS Lastname
FROM TestMultipleColumns

--TASK 2 Easy --
SELECT strs, CHARINDEX('%',strs)
AS Procent
FROM TestPercent
WHERE CHARINDEX('%',strs) > 0

--TASK 3 Easy --
SELECT 
    Vals,
    -- часть до первой точки
    LEFT(Vals, CHARINDEX('.', Vals + '.') - 1) AS split1,

    -- часть после первой точки:
    -- если есть вторая точка → берём промежуток
    -- если нет второй точки → остаток строки
    CASE 
        WHEN CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) > 0 
        THEN SUBSTRING(
                 Vals,
                 CHARINDEX('.', Vals) + 1,
                 CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) - CHARINDEX('.', Vals) - 1
             )
        ELSE SUBSTRING(Vals, CHARINDEX('.', Vals) + 1, LEN(Vals))
    END AS split2,

    -- остаток после второй точки (если она есть)
    CASE 
        WHEN CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) > 0
        THEN SUBSTRING(
                 Vals,
                 CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) + 1,
                 LEN(Vals)
             )
    END AS split3
FROM Splitter;

--TASK 4 Easy --
SELECT TRANSLATE('1234ABC123456XYZ1234567890ADS', 
                 '0123456789', 
                 'XXXXXXXXXX') AS Result;

--TASK 5 Easy --
SELECT *
FROM testDots
WHERE Vals LIKE '%.%.%.%'

--TASK 6 Easy --
SELECT texts,
	LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces

--TASK 7 Easy --
SELECT *
FROM  Employee e1
JOIN Employee e2 ON e1.ManagerID = e2.Id
WHERE e1.Salary > e2.Salary

--TASK 8 Easy --
SELECT 
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	HIRE_DATE,
	DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10
	AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 15;

--TASK 1 Medium --
SELECT 
    'rtcfvty34redt',
    -- Собираем только цифры
    (
        SELECT STRING_AGG(SUBSTRING('rtcfvty34redt', n, 1), '')
        FROM (
            SELECT TOP (LEN('rtcfvty34redt')) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
            FROM sys.all_objects
        ) AS nums
        WHERE SUBSTRING('rtcfvty34redt', n, 1) LIKE '[0-9]'
    ) AS Integers,

    -- Собираем только буквы/символы
    (
        SELECT STRING_AGG(SUBSTRING('rtcfvty34redt', n, 1), '')
        FROM (
            SELECT TOP (LEN('rtcfvty34redt')) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
            FROM sys.all_objects
        ) AS nums
        WHERE SUBSTRING('rtcfvty34redt', n, 1) NOT LIKE '[0-9]'
    ) AS Characters

--TASK 2 Medium --
SELECT w1.Id 
	FROM weather w1
	JOIN weather w2 ON w1.RecordDate = DATEADD(DAY, 1, w2.RecordDate)
	WHERE w1.Temperature > w2.Temperature

--TASK 3 Medium --
SELECT 
		player_id,
		MIN(event_date) AS firs_login
	FROM Activity
	GROUP BY player_id

--TASK 4 Medium --
WITH FruitsCTE AS (
    SELECT 
        value AS fruit,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM fruits
    CROSS APPLY STRING_SPLIT(fruit_list, ',')
)
SELECT fruit
FROM FruitsCTE
WHERE rn = 3;

--TASK 5 Medium --
DECLARE @str NVARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT TOP (LEN(@str)) 
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
SELECT SUBSTRING(@str, n, 1) AS ch
FROM Numbers;

--TASK 6 Medium --
SELECT p1.id,
	CASE WHEN p1.code = 0 THEN  p2.code 
	ELSE p1.code
	END AS Code
FROM p1
JOIN p2 ON p1.id = p2.id


--TASK 7 Medium --
ELECT 
	EMPLOYEE_ID,
	HIRE_DATE,
	CASE 
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire' 
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior'
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'Mid-Level'
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
		ELSE 'Veteran'
		END AS EmploymentStage
FROM Employees

--TASK 8 Medium --
SELECT 
    Vals,
    CAST(
        LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) 
        AS INT
    ) AS StartInteger
FROM GetIntegers;

--TASK 1 HARD --SELECT 
    Vals,
    SecondVal + ',' + FirstVal 
        + CASE WHEN Rest <> '' THEN ',' + Rest ELSE '' END AS SwappedVals
FROM MultipleVals
CROSS APPLY (
    SELECT 
        LEFT(Vals, CHARINDEX(',', Vals)-1) AS FirstVal,
        SUBSTRING(
            Vals,
            CHARINDEX(',', Vals)+1,
            CHARINDEX(',', Vals, CHARINDEX(',', Vals)+1) - CHARINDEX(',', Vals) - 1
        ) AS SecondVal,
        SUBSTRING(
            Vals,
            CHARINDEX(',', Vals, CHARINDEX(',', Vals)+1)+1,
            LEN(Vals)
        ) AS Rest
) t;

--TASK 2 HARD --

SELECT player_id, device_id
FROM (
	SELECT player_id, device_id,
	ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY event_date) AS rn
FROM Activity
) AS t
WHERE rn = 1;

--TASK 3 HARD --
SELECT
    Area,
    Date,
    SalesLocal,
    SalesRemote,
    DayName,
    DayOfWeek,
    FinancialWeek,
    MonthName,
    FinancialYear,
    (SalesLocal + SalesRemote) AS TotalSales,
    CAST(
        (SalesLocal + SalesRemote) * 100.0 
        / SUM(SalesLocal + SalesRemote) OVER (PARTITION BY FinancialYear, FinancialWeek)
        AS DECIMAL(5,2)
    ) AS PercentageOfWeek
FROM WeekPercentagePuzzle
WHERE SalesLocal IS NOT NULL OR SalesRemote IS NOT NULL
ORDER BY FinancialYear, FinancialWeek, Date, Area;
