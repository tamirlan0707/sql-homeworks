--HW12--
--TASK 1--

SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId

	--TASK 2--

SELECT e.name
FROM Employee e
JOIN Employee m ON e.managerid = m.id
WHERE e.salary > m.salary

	--TASK 3--

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1

	--TASK 4--

DELETE p
FROM Person p 
JOIN(
SELECT MIN(id) AS min_id, email
FROM Person
GROUP BY email
) AS DupMin
ON p.email = DupMin.email
WHERE p.id > DupMin.min_id

--TASK 5--

SELECT DISTINCT g.ParentName
FROM Boys b
RIGHT JOIN Girls g ON b.ParentName = g.ParentName
WHERE b.ParentName IS NULL

--TASK 6--

WITH 
SalesOver50 AS (
SELECT CustomerID, SUM(SalesAmount) TotalAmount
FROM [Sales.Orders] 
WHERE Weight > 50
GROUP BY CustomerID),

MinWeight AS (
SELECT CustomerID, MIN(Weight) AS MinWeight
FROM [Sales.Orders] 
GROUP BY CustomerID )

SELECT s.CustomerID, s.TotalAmount, m.MinWeight
FROM SalesOver50 s 
JOIN MinWeight m ON s.CustomerID = m.CustomerID

--TASK 7--
  
WITH 
	c1 AS (
SELECT item AS item1, 
	ROW_NUMBER() OVER (ORDER BY item) AS rn
FROM cart1),

	c2 AS (
SELECT item AS item2, 
	ROW_NUMBER() OVER (ORDER BY item) AS rn
FROM cart2)

SELECT c1.item1, c2.item2
FROM c1
FULL JOIN c2 ON c1.item1 = c2.item2

--TASK 8--

SELECT *,
	CASE 
	WHEN CAST(LEFT(Score, CHARINDEX(':', Score) -1) AS INT) >
		 CAST(RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) AS INT)
	THEN LEFT(Match, CHARINDEX('-', Match) -1)

	WHEN CAST(LEFT(Score, CHARINDEX(':', Score) -1) AS INT) <
		 CAST(RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) AS INT)
	THEN RIGHT(Match, LEN(Match) - CHARINDEX('-', Match))
	ELSE 'DRAW'
	END AS Result
FROM match1

--TASK 9--
  
SELECT c.Name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerid
WHERE o.Customerid IS NULL


--TASK 10--

WITH attended_sub AS (
SELECT  student_id, subject_name, COUNT(*) AS attended_exams 
FROM Examinations
GROUP BY student_id, subject_name

	WITH 
	all_pairs AS (
	SELECT s.student_id, s.student_name, sub.subject_name
	FROM students s
	CROSS JOIN Subjects sub
	),
	attended_count AS (
	SELECT student_id, subject_name, COUNT(*) AS attended_exams
	FROM Examinations e
	GROUP BY student_id, subject_name
	)
	SELECT a.student_id, a.student_name, a.subject_name, COALESCE(ac.attended_exams,0) AS attended_exams
	FROM all_pairs a
	LEFT JOIN attended_count ac 
	ON a.student_id=ac.student_id AND a.subject_name = ac.subject_name 
	ORDER BY a.student_id, a.student_name
