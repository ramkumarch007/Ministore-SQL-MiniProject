# MiniStoreDB 🛒📊

MiniStoreDB is a SQL-based mini project that simulates a retail store database.  
The project focuses on database design, data loading from CSV files, and solving real-world business questions using SQL.

This project is intended for **learning, practice, and portfolio demonstration**.

---

## 🛠️ Tech Stack
- MySQL
- SQL (DDL, DML, Joins, Aggregations, Window Functions)

---

## 📂 Project Structure

MiniStoreDB/
│
├── schema.sql # Database & table creation
├── insert_data.sql # CSV data import scripts
├── queries.sql # Business-focused SQL queries
├── README.md
└── data/
├── customers.csv
├── products.csv
├── orders.csv
└── order_items.csv


---

## 🗄️ Database Schema

The database consists of four main tables:

### 1️⃣ customers
Stores customer details such as name, city, age, registration date and total_spent.

### 2️⃣ products
Stores product information including category, supplier, price, stock quantity, reorder level, and rating.

### 3️⃣ orders
Contains order-level details such as order date, payment method, employee handling the order, total amount, and discount.

### 4️⃣ order_items
Represents individual items within an order, linking products and orders along with quantity and unit price.

---

## 📥 Data Import

Data is loaded from CSV files using MySQL’s `LOAD DATA LOCAL INFILE` command.

- The datasets are **synthetic** and created for learning purposes.
- CSV files are included to allow full reproducibility.
- File paths may need adjustment based on the local system.

Example:
```sql
LOAD DATA LOCAL INFILE 'data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

