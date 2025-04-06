--------Easy-Level ------

BULK INSERT Products
FROM 'C:\data\products.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

---CSV (Comma-Separated Values)
---TXT (Text file)
---Excel (XLS, XLSX)
---JSON (JavaScript Object Notation)

CREATE TABLE Products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(50),
   Price DECIMAL(10,2)
   );

   INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (1, 'Laptop', 999.99),
    (2, 'Smartphone', 699.50),
    (3, 'Headphones', 149.99);


	CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NULL
);

-- Работает: есть имя, но email пустой (NULL)
INSERT INTO Employees (EmployeeID, Name, Email)
VALUES (1, 'Anna Ivanova', NULL);

-- Ошибка: имя обязательно (NOT NULL)
INSERT INTO Employees (EmployeeID, Name, Email)
VALUES (2, NULL, 'test@example.com');

ALTER TABLE Products ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE
);
INSERT INTO Categories (CategoryID, CategoryName)
VALUES
    (1, 'Electronics'),
    (2, 'Furniture'),
    (3, 'Clothing');

CREATE TABLE Employees (
    EmpID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);

INSERT INTO Employees (Name, Age) VALUES ('John Doe', 30);
INSERT INTO Employees (Name, Age) VALUES ('Jane Smith', 25);


-----Medium-Level-----

BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2)
);

SELECT ProductID, ProductName, Price
FROM Products
FOR XML PATH('Product'), ROOT('Products');

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(100) UNIQUE
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Price DECIMAL DECIMAL(10,2),
CategoryID INT,
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Categories (CategoryID, CategoryName)
VALUES (1, 'Electronics'), (2, 'Furniture');

INSERT INTO Products (ProductID, ProductName, Price, CategoryID)
VALUES (1, 'Laptop', 999.99, 1),
       (2, 'Sofa', 499.99, 2);

	   CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    SKU VARCHAR(50) UNIQUE
);

ALTER TABLE Products
ADD CONSTRAINT chk_Price CHECK (Price > 0);

SELECT ProductID, ProductName, Price
FROM Products
FOR JSON AUTO;

SELECT ProductID AS ID, ProductName AS Name, Price AS Cost
FROM Products
FOR JSON PATH;


ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);


-------Hard-Level Task --------

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Age INT,
	CONSTRAINT chk_age CHECK (Age >=18);

	CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INT
);

INSERT INTO Orders (OrderID, OrderDate, CustomerID)
SELECT OrderID, OrderDate, CustomerID
FROM OPENROWSET(
    BULK 'C:\path\to\your\file.json', 
    SINGLE_CLOB
) AS jsonData
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    OrderID INT,
    OrderDate DATETIME,
    CustomerID INT
);


CREATE TABLE Employees (
    EmployeeID INT IDENTITY(100, 10) PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
	CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderId, ProductID)
	);

	SELECT COALESCE(NULL, NULL, 'Hello', 'World') AS Result;

	SELECT COALESCE(EmployeeName, 'Не указано') AS EmployeeName
FROM Employees;

SELECT ISNULL(NULL, 'Default Value') AS Result;

SELECT ISNULL(MiddleName, 'Не указано') AS MiddleName
FROM Employees;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

MERGE INTO Products AS target
USING (SELECT ProductID, ProductName, Price FROM Products) AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET target.ProductName = source.ProductName, target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price) 
    VALUES (source.ProductID, source.ProductName, source.Price);

	CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,         -- Primary key на EmpID
    EmpName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,     -- Unique key на Email
    HireDate DATE
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    CONSTRAINT FK_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Managers (
    ManagerID INT PRIMARY KEY,
    ManagerName VARCHAR(100)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ManagerID INT,
	CONSTRAINT FK_ManagerID 
	FOREIGN KEY (ManagerID)
	REFERENCES Managers(ManagerID)
	ON DELETE SET NULL
	);

