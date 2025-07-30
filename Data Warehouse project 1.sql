-- Drop tables if they exist (for re-runs)
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS dim_date;

-- Create dimension tables

CREATE TABLE dim_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    month INT,
    quarter INT,
    year INT
);

-- Create fact table

CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    date_id INT,
    quantity_sold INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- Insert into dim_products
INSERT INTO dim_products VALUES
(1, 'Laptop', 'Electronics', 800.00),
(2, 'Headphones', 'Electronics', 150.00),
(3, 'Office Chair', 'Furniture', 200.00),
(4, 'Standing Desk', 'Furniture', 400.00);

-- Insert into dim_customers
INSERT INTO dim_customers VALUES
(101, 'Alice Smith', 'New York'),
(102, 'Bob Johnson', 'San Francisco'),
(103, 'Carol Lee', 'Chicago');

-- Insert into dim_date
INSERT INTO dim_date VALUES
(1, '2024-06-01', 6, 2, 2024),
(2, '2024-06-15', 6, 2, 2024),
(3, '2024-07-01', 7, 3, 2024),
(4, '2024-07-20', 7, 3, 2024);

-- Insert into fact_sales
INSERT INTO fact_sales VALUES
(1001, 1, 101, 1, 1, 800.00),
(1002, 2, 102, 2, 2, 300.00),
(1003, 3, 103, 3, 1, 200.00),
(1004, 1, 103, 4, 1, 800.00),
(1005, 4, 102, 3, 1, 400.00);
select * from fact_sales;
select * from  dim_products;
select * from dim_customers;
select * from  dim_date;




-- Total sales per product
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM fact_sales s
JOIN dim_products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Top customer by revenue
SELECT c.customer_name, SUM(s.total_amount) AS total_spent
FROM fact_sales s
JOIN dim_customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- Sales by month
SELECT d.month, SUM(s.total_amount) AS monthly_sales
FROM fact_sales s
JOIN dim_date d ON s.date_id = d.date_id
GROUP BY d.month;
