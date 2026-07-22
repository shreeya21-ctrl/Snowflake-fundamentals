USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

CREATE OR REPLACE DATABASE MYDB;

CREATE OR REPLACE SCHEMA MYDB.MYSCHEMA;

CREATE TABLE MYDB.MYSCHEMA.toys(
    toy_name STRING,
    toy_type STRING,
    price NUMBER
);

INSERT INTO MYDB.MYSCHEMA.toys(toy_name, toy_type, price) VALUES
    ('Robot', 'Action Figure', 15),
    ('Teddy Bear', 'Plush', 10),
    ('Race Car', 'Vehicle', 8),
    ('Dragon', 'Action Figure', 20),
    ('Puzzle', 'Game', 25);

-- SELECT * FROM toys ORDER BY price DESC LIMIT 1;

SELECT toy_type, ROUND(AVG(price), 2) AS avg_price, COUNT(*) AS num_toys
FROM toys 
GROUP BY toy_type
HAVING avg_price > 12;


-- Second table;
CREATE TABLE MYDB.MYSCHEMA.sales(
    sale_id  NUMBER AUTOINCREMENT PRIMARY KEY,
    toy_name STRING,
    quantity NUMBER,
    sale_date DATE
);

INSERT INTO sales(toy_name, quantity, sale_date) VALUES 
('Robot', 3, '2026-01-05'),
('Teddy Bear', 5, '2026-01-06'),
('Dragon', 2, '2026-01-07'),
('Race Car', 4, '2026-01-10'),
('Robot', 1, '2026-01-15');

SELECT sales.toy_name, quantity, price 
FROM SALES
JOIN toys ON sales.toy_name = toys.toy_name;

-- Calculate actual revenue per sale
SELECT sales.toy_name, (quantity * price) AS revenue
FROM SALES
JOIN toys ON sales.toy_name = toys.toy_name
ORDER BY revenue DESC;


-- Total revenue per toy
SELECT sales.toy_name, SUM(quantity * price) AS revenue
FROM SALES
JOIN toys ON sales.toy_name = toys.toy_name
GROUP BY sales.toy_name
ORDER BY revenue DESC;
