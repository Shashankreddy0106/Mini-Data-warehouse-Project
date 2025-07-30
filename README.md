# 📦 Mini Data Warehouse: Sales Analytics Project

### 👋 Overview
This is a **Mini Data Warehouse project** designed to simulate a retail business's sales data. It uses a **star schema** with one fact table and three dimension tables. The project demonstrates how to design a simple analytical database for reporting, trends, and insights — a great fit for SQL, BI, and data analytics roles.

---

## 🗂 Schema Design (Star Schema)

### 🟦 Dimension Tables
- `dim_products` – product details
- `dim_customers` – customer info
- `dim_date` – date breakdown (day, month, quarter, year)

### 🟥 Fact Table
- `fact_sales` – each sales transaction with foreign keys

---

## 🛠 Tech Stack
- SQL (MySQL or PostgreSQL)
- GitHub (for code and documentation)

---

## 🧱 Database Schema Diagram  
*(Insert screenshot from draw.io here if available)*


---

## 🔍 Sample SQL Queries

### 1. Total sales per product:
```sql
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM fact_sales s
JOIN dim_products p ON s.product_id = p.product_id
GROUP BY p.product_name;

### 2. Top coustomer by revenue:

SELECT c.customer_name, SUM(s.total_amount) AS total_spent
FROM fact_sales s
JOIN dim_customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

### 3.Sales by month

SELECT d.month, SUM(s.total_amount) AS monthly_sales
FROM fact_sales s
JOIN dim_date d ON s.date_id = d.date_id
GROUP BY d.month;
