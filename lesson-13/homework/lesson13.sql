--task 1 Easy --
  SELECT  CONCAT(EMPLOYEE_ID, '-' ,FIRST_NAME,' ',  LAST_NAME) emp_id_full_nama
FROM Employees
  
--task 2 Easy --
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE PHONE_NUMBER LIKE '%124%';

--task 3 Easy --
SELECT FIRST_NAME firstname, LEN(FIRST_NAME) name_length 
FROM Employees
WHERE FIRST_NAME LIKE 'A%'
	OR FIRST_NAME LIKE 'J%'
	OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME
  
--task 4 Easy --
SELECT  MANAGER_ID manager_id, 
		SUM(SALARY) total_salary
FROM Employees
GROUP BY MANAGER_ID

--task 5 Easy --
SELECT t.Year1, v.MaxValue 
FROM TestMax t
CROSS APPLY (
	SELECT MAX(val) MaxValue
	FROM (VALUES (t.Max1), (t.Max2), (t.Max3)) X(val)) v
  
--task 6 Easy --
SELECT id movie_id, movie,  [description] 
FROM Cinema
WHERE id % 2 = 1 AND [description] <> 'boring'
  
--task 7 Easy --
  SELECT id, Vals
FROM SingleOrder
ORDER BY CASE WHEN id=0 THEN 1 ELSE 0 END, id;

--task 8 Easy --
  SELECT COALESCE (id, ssn, passportid, itin) first_non_null
FROM Person

--task 1 Medium --
  SELECT 
	SUBSTRING(Fullname,1,CHARINDEX(' ', FullName)-1) FirstName,
	SUBSTRING(Fullname,
	CHARINDEX(' ', Fullname)+1,
	CHARINDEX(' ', Fullname, CHARINDEX(' ', Fullname)+1) - CHARINDEX(' ', Fullname)-1) MiddleName,
	SUBSTRING(Fullname, CHARINDEX(' ', Fullname, CHARINDEX(' ', Fullname)+1)+1,
	LEN(Fullname)) LastName
FROM Students;

--task 2 Medium --
SELECT OrderID, CustomerID, DeliveryState
FROM Orders
WHERE DeliveryState = 'TX'
AND CustomerID IN (
	SELECT DISTINCT CustomerID
	FROM Orders
	WHERE DeliveryState = 'CA'
	)

--task 3 Medium --
  SELECT STRING_AGG(LTRIM (RTRIM (REPLACE(REPLACE(String, ',',' '),'>',' '))), ',') AS QueryText
FROM DMLTable;

--task 4 Medium --
  SELECT FIRST_NAME, LAST_NAME
FROM Employees
WHERE (
		LEN(LOWER(FIRST_NAME + LAST_NAME))
		-LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a',''))
		) >=3

  --task 5 Medium --
  SELECT 
	DEPARTMENT_ID AS depID,
	COUNT(*) AS TotalEmp,
	100.0 * SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*) AS Over3year
FROM Employees
	GROUP BY DEPARTMENT_ID

--task 6 Medium --
  SELECT 
	p.JobDescription, 
	(SELECT TOP 1 SpacemanID 
	FROM Personal
	WHERE JobDescription = p.JobDescription
	ORDER BY MissionCount DESC) AS MostExperienced,
	(SELECT TOP 1 SpacemanID
	FROM Personal
	WHERE JobDescription=p.JobDescription
	ORDER BY MissionCount) AS LeastExperienced
FROM Personal p
GROUP BY p.JobDescription;

--task 1 Hard --
  WITH Rec AS (
    SELECT 1 AS pos,
           SUBSTRING('tf56sd#%OqH', 1, 1) AS ch,
           LEN('tf56sd#%OqH') AS str_len
    UNION ALL
    SELECT pos + 1,
           SUBSTRING('tf56sd#%OqH', pos + 1, 1),
           str_len
    FROM Rec
    WHERE pos < str_len
)
SELECT 
    STRING_AGG(CASE WHEN ch COLLATE Latin1_General_CS_AS LIKE '[A-Z]' THEN ch END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN ch COLLATE Latin1_General_CS_AS LIKE '[a-z]' THEN ch END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS SpecialChars
FROM Rec
OPTION (MAXRECURSION 100);

---TASK 2 HARD---
  SELECT 
    StudentID,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Students;

---TASK 3 HARD---
  DECLARE @expr NVARCHAR(100);
DECLARE @sql NVARCHAR(MAX);
DECLARE @res FLOAT;

DECLARE cur CURSOR FOR
SELECT Equation FROM Equations;

OPEN cur;
FETCH NEXT FROM cur INTO @expr;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Построим SQL для вычисления выражения
    SET @sql = N'SELECT @r_out = ' + @expr;

    -- Выполним его, результат сохраним в @res
    EXEC sp_executesql @sql, N'@r_out FLOAT OUTPUT', @res OUTPUT;

    -- Обновим строку в таблице
    UPDATE Equations
    SET TotalSum = @res
    WHERE Equation = @expr;

    FETCH NEXT FROM cur INTO @expr;
END

CLOSE cur;
DEALLOCATE cur;

---TASK 4 HARD---
  SELECT BIrthday, COUNT(*) AS cnt  FROM Student
GROUP BY Birthday
HAVING COUNT(*) >1

---TASK 5 HARD---
SELECT 
    Player1,
    Player2,
    SUM(Score) AS TotalScore
FROM (
    SELECT 
        CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
        CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
        Score
    FROM PlayerScores
) AS pairs
GROUP BY Player1, Player2;
