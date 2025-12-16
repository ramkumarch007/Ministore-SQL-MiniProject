-- ============================================
-- Data Import Script for MiniStoreDB
-- Data Source: CSV files (synthetic data)
-- ============================================

USE MiniStoreDB;

-- Import Customers
LOAD DATA LOCAL INFILE 'data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Customer_ID, Name, Email, City, Registration_Date, Age,Total_Spent);

-- Import Products
LOAD DATA LOCAL INFILE 'data/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Product_ID, Product_Name, Category, Supplier, Price, Quantity_In_Stock, Reorder_Level, Rating);

-- Import Orders
LOAD DATA LOCAL INFILE 'data/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Order_Date, Payment_Method, Employee_ID, Total_Amount, Discount);

-- Import Order Items
LOAD DATA LOCAL INFILE 'data/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Order_Item_ID, Order_ID, Product_ID, Quantity, Unit_Price,Total_Price);
