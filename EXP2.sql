CREATE TABLE Time_dw ( 
time_id INT PRIMARY KEY, 
quarter INT, 
day INT , 
month char(40), 
year INT 
) 
 
CREATE TABLE Branch ( 
branch_id INT PRIMARY KEY, 
name char(50), 
state char(50), 
country char(50) 
) 
 
CREATE TABLE Location ( 
location_id INT PRIMARY KEY, 
CITY CHAR(50), 
state char(50), 
country char(50) 
) 
 
CREATE TABLE Product ( 
product_id INT PRIMARY KEY, 
quantity INT, 
price INT, 
model_number INT, 
type VARCHAR(50), 
name VARCHAR(100) 
) 
 
create table Sales_Fact ( 
sales_id INT PRIMARY KEY, 
time_id INT, 
product_id INT, 
branch_id INT, 
location_id INT, 
quantity INT, 
sales_amount DECIMAL(10,2), 
revenue DECIMAL(10,2), 
FOREIGN KEY (time_id) REFERENCES Time_dw(time_id), 
FOREIGN KEY (product_id) REFERENCES Product(product_id), 
FOREIGN KEY (branch_id) REFERENCES Branch(branch_id), 
FOREIGN KEY (location_id) REFERENCES Location(location_id) 
);

CREATE TABLE Time_dw ( 
time_id INT PRIMARY KEY, 
quarter INT, 
day INT , 
month char(40), 
year INT 
);

CREATE TABLE Branch ( 
branch_id INT PRIMARY KEY, 
name char(50), 
state char(50), 
country char(50) 
);

CREATE TABLE Location ( 
location_id INT PRIMARY KEY, 
CITY CHAR(50), 
state char(50), 
country char(50) 
);

CREATE TABLE Product ( 
product_id INT PRIMARY KEY, 
quantity INT, 
price INT, 
model_number INT, 
type VARCHAR(50), 
name VARCHAR(100) 
);

create table Sales_Fact ( 
sales_id INT PRIMARY KEY, 
time_id INT, 
product_id INT, 
branch_id INT, 
location_id INT, 
quantity INT, 
sales_amount DECIMAL(10,2), 
revenue DECIMAL(10,2), 
FOREIGN KEY (time_id) REFERENCES Time_dw(time_id), 
FOREIGN KEY (product_id) REFERENCES Product(product_id), 
FOREIGN KEY (branch_id) REFERENCES Branch(branch_id), 
FOREIGN KEY (location_id) REFERENCES Location(location_id) 
);

INSERT INTO Time_dw VALUES (1, 1, 5, 'January', 2025);

INSERT INTO Time_dw VALUES (2, 2, 7, 'May', 2025);

INSERT INTO Time_dw VALUES (3, 1, 18, 'March', 2025);

INSERT INTO Time_dw VALUES (4, 1, 14, 'February', 2025);

INSERT INTO Time_dw VALUES (5 , 2, 1, 'June', 2025);

INSERT INTO product VALUES (1, 10, 80000, 105, 'Electronics - Gadgets', 'Tablet');

INSERT INTO product VALUES (2, 12, 1700, 105, 'Electronics - wearables', 'smartwatch');

INSERT INTO product VALUES (3, 16, 12000, 105, 'Electronics - Gadgets', 'Tablet');

INSERT INTO product VALUES (4, 18, 2000, 105, 'Electronics - accesories', 'Airdopes');

INSERT INTO product VALUES (5, 11, 45000, 105, 'Electronics - appliances', 'TV');

INSERT INTO Branch VALUES (5, 'Branch E', 'Maharashtra', 'India');

INSERT INTO Branch VALUES (6, 'Branch F', 'Delhi', 'India');

INSERT INTO Branch VALUES (7, 'Branch G', 'Karnataka', 'India');

INSERT INTO Branch VALUES (8, 'Branch H', 'West Bengal', 'India');

INSERT INTO Branch VALUES (9, 'Branch I', 'Tamil Nadu', 'India');

INSERT INTO Location VALUES (1, 'Mumbai', 'Maharashtra', 'India');

INSERT INTO Location VALUES (2, 'Delhi', 'Delhi', 'India');

INSERT INTO Location VALUES (3, 'Bangalore', 'Karnataka', 'India');

INSERT INTO Location VALUES (4, 'Kolkata', 'West Bengal', 'India');

INSERT INTO Location VALUES (5, 'Chennai', 'Tamil Nadu', 'India');

ALTER TABLE Sales_Fact DROP COLUMN sales_id;

ALTER TABLE Sales_Fact 
ADD (sales_id NUMBER GENERATED ALWAYS AS IDENTITY 
(START WITH 1 INCREMENT BY 1));

INSERT INTO Location VALUES (6, 'Chennai', 'Tamil Nadu', 'India');

ALTER TABLE Sales_Fact 
ADD (sales_id NUMBER GENERATED ALWAYS AS IDENTITY 
(START WITH 1 INCREMENT BY 1));

ALTER TABLE Sales_Fact 
ADD (sales_id NUMBER GENERATED ALWAYS AS IDENTITY 
(START WITH 1 INCREMENT BY 1));

INSERT INTO Sales_Fact ( 
time_id, 
product_id, 
branch_id, 
location_id, 
quantity, 
sales_amount, 
revenue 
) 
SELECT 
t.time_id, 
p.product_id, 
b.branch_id, 
l.location_id, 
FLOOR(DBMS_RANDOM.VALUE(1, 100)), -- Random quantity between 1 and 100 
(FLOOR(DBMS_RANDOM.VALUE(1, 100)) * p.price), -- Random sales amount 
(FLOOR(DBMS_RANDOM.VALUE(1, 100)) * p.price * 0.8) -- Random revenue 
FROM 
Time_dw t 
CROSS JOIN 
Product p 
CROSS JOIN 
Branch b 
CROSS JOIN 
Location l;

SELECT * 
FROM Sales_Fact 
WHERE time_id = '3';

SELECT * 
FROM Sales_Fact 
WHERE time_id = '2' 
AND branch_id = 7;

SELECT branch_id, location_id, 
SUM(sales_amount) AS total_sales, 
SUM(revenue) AS total_revenue 
FROM Sales_Fact;

SELECT location_id, 
SUM(sales_amount) AS location_sales, 
SUM(revenue) AS location_revenue 
FROM Sales_Fact 
WHERE branch_id = 7 
GROUP BY location_id;

SELECT * 
FROM ( 
SELECT branch_id, sales_amount 
FROM Sales_Fact 
WHERE time_id = '4' 
) 
PIVOT ( 
SUM(sales_amount) AS total 
FOR branch_id IN (6 AS branch_6, 7 AS branch_7, 8 AS branch_8) 
);

