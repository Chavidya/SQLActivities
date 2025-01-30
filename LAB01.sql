CREATE DATABASE TechStore_DB;
USE TechStore_DB;

/* Create the supplier table */
CREATE TABLE supplier (
    supID VARCHAR(10) PRIMARY KEY,
    supName VARCHAR(100) NOT NULL,
    supEmail VARCHAR(100) NOT NULL,
    contactNo VARCHAR(15)
);

/* Create the product table */
CREATE TABLE product (
    prodID INT PRIMARY KEY AUTO_INCREMENT,
    prodName VARCHAR(100) NOT NULL,
    prodDescription TEXT,
    stockQty INT NOT NULL,
    purchasePrice DECIMAL(10, 2)
);

/* Create the customer table */
CREATE TABLE customer (
    custID VARCHAR(10) PRIMARY KEY,
    custName VARCHAR(100) NOT NULL,
    custEmail VARCHAR(100) NOT NULL,
    custCity varchar(45) NOT NULL,
    custAddress VARCHAR(255),
    prodID INT,
    FOREIGN KEY (prodID) REFERENCES product(prodID)
);

/* Create the orderDetails table */
CREATE TABLE orderDetails (
    orderID INT PRIMARY KEY AUTO_INCREMENT,
    orderDate DATE NOT NULL,
    orderStatus VARCHAR(20),
    custID VARCHAR(10),
    supID VARCHAR(10),
    FOREIGN KEY (custID) REFERENCES customer(custID),
    FOREIGN KEY (supID) REFERENCES supplier(supID)
);

/* Insert data into supplier table */
INSERT INTO supplier (supID, supName, supEmail, contactNo) 
VALUES ('s92073225', 'H.C. Nawodani', 's92073225@ousl.lk', '0771234567'), 
       ('S002', 'Supplier 2', 'supplier2@example.com', '0771234568'),
       ('S003', 'Supplier 3', 'supplier3@example.com', '0771234569');

/* Insert data into product table */
INSERT INTO product (prodName, prodDescription, stockQty, purchasePrice)
VALUES ('Product A', 'Description of Product A', 10, 100.00),
       ('Product B', 'Description of Product B', 3, 200.00),
       ('Product C', 'Description of Product C', 15, 300.00);

/* Insert data into customer table */
INSERT INTO customer (custID, custName, custEmail,custCity, custAddress, prodID)
VALUES ('321433225', 'H.C. Nawodani', 'nawodani@example.com','wattala' 'Sethsiri Garden', 1),
       ('C002', 'Customer 2', 'customer2@example.com','colombo', '456 Avenue', 2),
       ('C003', 'Customer 3', 'customer3@example.com','kandy', '789 Boulevard', 3);

/* Insert data into orderDetails table */
INSERT INTO orderDetails (orderDate, orderStatus, custID, supID) 
VALUES ('2024-09-01', 'Pending', '321433225', 's92073225'),
       ('2024-09-02', 'Pending', 'C002', 'S002'),
       ('2024-09-03', 'Shipped', 'C003', 'S003');
       
ALTER TABLE customer ADD zipCode VARCHAR(10);

ALTER TABLE customer DROP COLUMN custCity;

TRUNCATE TABLE orderDetails;

UPDATE orderDetails
SET orderStatus = 'Shipped'
WHERE orderDate = '2024-09-01';

DELETE FROM product
WHERE stockQty < 5;

SELECT * FROM supplier;

SELECT product.prodName, product.prodDescription, customer.custName FROM product
LEFT JOIN customer ON product.prodID = customer.prodID;

SELECT supName, supEmail FROM supplier 
JOIN orderDetails ON supplier.supID = orderDetails.supID
GROUP BY supplier.supID
HAVING COUNT(orderDetails.prodID) >= 3;

SELECT prodName, purchasePrice, stockQty AS 'Available Stock'FROM product
ORDER BY stockQty ASC
LIMIT 1;

SELECT customer.custName, customer.custEmail FROM customer
JOIN orderDetails ON customer.custID = orderDetails.custID
WHERE orderDetails.orderStatus = 'Pending';

SELECT * FROM orderDetails
ORDER BY orderDate DESC
LIMIT 5;

SELECT customer.custName, SUM(product.purchasePrice) AS 'Total Purchase Price'FROM customer
JOIN product ON customer.prodID = product.prodID
WHERE customer.custID = '321433225';
