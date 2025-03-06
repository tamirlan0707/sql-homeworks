SELECT * FROM sys.databases;


CREATE DATABASE example_db;

USE example_db;

CREATE SCHEMA sales;

CREATE SCHEMA marketing;

SELECT * FROM sys.schemas;

GO
SELECT * FROM example_db.INFORMATION_SCHEMA.TABLES;

CREATE TABLE example_db.marketing.customers (
custumer_id INT IDENTITY(1, 1) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
email VARCHAR(100) UNIQUE,
phone_number CHAR(10) UNIQUE,
birh_date DATE,
account_balance DECIMAL(10, 2) DEFAULT 0.00,
created_at DATETIME2 DEFAULT GETDATE(),
)
ALTER TABLE example_db.marketing.customers
ADD middle_name VARCHAR(50);

SELECT * FROM example_db.marketing.customers;
ALTER TABLE example_db.marketing.customers
DROP COLUMN middle_name;

INSERT INTO example_db.marketing.customers
(first_name,last_name,email,phone_number,birh_date,account_balance)
VALUES
('John','Doe','example3@gmail.com','+9989998',NULL,12)	

