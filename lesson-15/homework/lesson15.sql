--Task 1: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
SELECT 
	id,
	[name],
	salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)

--Task 2: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
SELECT 
	id,
	product_name,
	price
FROM products
WHERE price > (SELECT AVG(price) FROM products)

--Task 3: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

SELECT 
	e.id AS empID,
	d.id AS depID,
	e.name AS EmpName,
	d.department_name AS DepName
FROM departments d
JOIN employees e ON d.id = e.department_id
WHERE d.department_name = 'Sales'

--Task 4: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)  
SELECT 
	c.customer_id,
	c.name,
	o.order_id,
	o.customer_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL

--Task 5:Find Products with Max Price in Each Category
--Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT 
	id,
	product_name,
	price,
	category_id
FROM products p
WHERE price = (
	SELECT MAX(price) AS max_price
	FROM products
	WHERE category_id = p.category_id
	) ORDER BY price DESC

--Task 6: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

SELECT
		e.id,
		e.[name],
		e.salary,
		d.department_name
	FROM employees e
	JOIN departments d ON e.department_id = d.id
	WHERE e.department_id IN (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		HAVING AVG(salary) = (
			SELECT MAX(avg_salary)
			FROM (
				SELECT AVG(salary) AS avg_salary
				FROM employees
				GROUP BY department_id
			) t
		)
	);

--Task 7: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT 
	e.id,
	e.salary,
	e.department_id
FROM employees e
WHERE e.salary > (

SELECT 
	AVG(e1.salary) AS avg_salary
FROM employees e1
WHERE e.department_id = e1.department_id
)

--Task 8 : Retrieve students who received the highest grade in each course. 
--Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

SELECT 
	s.Student_id,
	s.name,
	g.Course_id,
	g.grade
FROM Students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade = (
	SELECT
		MAX(g2.grade) AS max_grade
	FROM grades g2
	WHERE g2.course_id = g.course_id
	)

--TASK 9 Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)

SELECT 
	id,
	product_name,
	price,
	category_id
FROM products p
WHERE 2 = (

SELECT COUNT(DISTINCT p2.price)
FROM products p2
WHERE p2.category_id = p.category_id
AND p2.price > p.price
)

--Task 10: Retrieve employees with salaries above the company average but below the maximum in their department. ,
--Tables: employees (columns: id, name, salary, department_id)

SELECT 
	e.id,
	e.name,
	e.salary,
	e.department_id
FROM  employees e
WHERE e.salary > (
	SELECT AVG(salary) AS avg_salary FROM employees )
	AND e.salary < (
	SELECT MAX(e2.salary) AS max_salary 
	FROM employees e2
	WHERE e2.department_id = e.department_id
	)
