CREATE DATABASE IF NOT EXISTS MiniStoreDB;
USE MiniStoreDB;

-- Customers table
CREATE TABLE customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    City VARCHAR(100),
    Registration_Date DATE,
    Age INT CHECK (Age BETWEEN 1 AND 119)
);

-- Products table
CREATE TABLE products (
    Product_ID VARCHAR(10) PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    Supplier VARCHAR(100),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Quantity_In_Stock INT CHECK (Quantity_In_Stock >= 0),
    Reorder_Level INT,
    Rating DECIMAL(3,1) CHECK (Rating BETWEEN 0 AND 5)
);

-- Orders table
CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID VARCHAR(10) NOT NULL,
    Order_Date DATE,
    Payment_Method ENUM('Cash','Credit','Installment'),
    Employee_ID VARCHAR(10),
    Total_Amount DECIMAL(10,2) CHECK (Total_Amount >= 0),
    Discount DECIMAL(10,2) CHECK (Discount >= 0),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Order Items table
CREATE TABLE order_items (
    Order_Item_ID VARCHAR(10) PRIMARY KEY,
    Order_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10,2) CHECK (Unit_Price > 0),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
