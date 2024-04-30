# Task 1 : Database Design:
### 2. Define the schema for the Customers, Products, Orders, OrderDetails and Inventory tables based on the provided schema.
```sql
CREATE TABLE Customers(
CustomerID VARCHAR(20),
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(255),
Phone VARCHAR(10),
Address VARCHAR(255),
PRIMARY KEY (CustomerID)
);

CREATE TABLE Products(
ProductID VARCHAR(20),
ProductName VARCHAR(50),
Description VARCHAR(255),
Price INT,
Category INT,
PRIMARY KEY (ProductID)
);

CREATE TABLE Orders(
OrderID VARCHAR(20),
CustomerID VARCHAR(20),
OrderDate DATE,
TotalAmount INT,
Status VARCHAR(10),
PRIMARY KEY (OrderID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails(
OrderDetailID VARCHAR(20),
OrderID VARCHAR(20),
ProductID VARCHAR(20),
Quantity INT,
PRIMARY KEY (OrderDetailID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory(
InventoryID VARCHAR(20),
ProductID VARCHAR(20),
QuantityInStock INT,
LastStockUpdate DATE,
PRIMARY KEY (InventoryID),
FOREIGN KEY (ProductID) REFERENCES ProductS(ProductID)
);
```

### 3. Create an ERD (Entity Relationship Diagram) for the database.
![](./Images/Screenshot%202024-04-30%20205511.png)

### 4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
![](./Images/ERD%20with%20keys.png)

### 5. Insert at least 10 sample records into each of the following tables. (Customers, Products, Orders, OrderDetails, Inventory)
```sql
INSERT INTO Customers
VALUES('C001','Naruto','Uzumaki','naruto@gmail.com','8778000000','Address 1'),
	('C002','Sasuke','Uchiha','sasuke@gmail.com','8778000001','Address 2'),
	('C003','Sakura','Haruno','sakura@gmail.com','8778000002','Address 3'),
	('C004','Hinata','Hyuga','hinata@gmail.com','8778000003','Address 4'),
	('C005','Shikamaru','Nara','shikamaru@gmail.com','8778000004','Address 5'),
	('C006','Zoro','Roronoa','zoro@gmail.com','8778000005','Address 6'),
	('C007','Yoruichi','Shihouin','yoruichi@gmail.com','8778000006','Address 7'),
	('C008','Takumi','Usui','takumi@gmail.com','8778000007','Address 8'),
	('C009','Heewon','Jung','heewon@gmail.com','8778000008','Address 9'),
	('C010','Rudeus','Greyrat','rudeus@gmail.com','8778000009','Address 10');
	
INSERT INTO Products
VALUES('P001','Mouse','Description 1',500,1),
	('P002','Keyboard','Description 2',1000,1),
	('P003','Laptop','Description 3',50000,1),
	('P004','Power bank','Description 4',1000,3),
	('P005','Earphone','Description 5',1000,3),
	('P006','Charger','Description 6',500,3),
	('P007','Smart watch','Description 7',1000,2),
	('P008','Mobile','Description 8',20000,2),
	('P009','Monitor','Description 9',10000,1),
	('P010','Smart TV','Description 10',30000,2);

INSERT INTO Orders
VALUES('OR01','C005','2024-05-12',1500,'Shipped'),
	('OR02','C008','2024-05-16',80000,'Shipped'),
	('OR03','C001','2024-05-12',100000,'Shipped'),
	('OR04','C010','2024-05-16',2000,'Pending'),
	('OR05','C004','2024-04-15',3000,'Pending'),
	('OR06','C001','2024-05-10',50000,'Shipped'),
	('OR07','C008','2024-05-12',5000,'Pending'),
	('OR08','C006','2024-04-03',5000,'Pending'),
	('OR09','C002','2024-05-02',6000,'Shipped'),
	('OR10','C009','2024-05-05',1000,'Shipped');

INSERT INTO OrderDetails
VALUES('OD01','OR01','P001',3),
	('OD02','OR02','P008',4),
	('OD03','OR03','P003',2),
	('OD04','OR04','P001',4),
	('OD05','OR05','P002',3),
	('OD06','OR06','P003',1),
	('OD07','OR07','P007',5),
	('OD08','OR08','P004',5),
	('OD09','OR09','P005',6),
	('OD10','OR10','P006',2);

INSERT INTO Inventory
VALUES('IV01','P001',20,'2024-04-10'),
	('IV02','P002',25,'2024-04-20'),
	('IV03','P003',5,'2024-04-10'),
	('IV04','P004',10,'2024-04-01'),
	('IV05','P005',15,'2024-04-10'),
	('IV06','P006',10,'2024-04-01'),
	('IV07','P007',20,'2024-04-10'),
	('IV08','P008',15,'2024-04-20'),
	('IV09','P009',20,'2024-04-10'),
	('IV10','P010',10,'2024-04-30');

```


# Task 2 : Select, Where, Between, AND, LIKE:
### 1. Write an SQL query to retrieve the names and emails of all customers. 
```sql
SELECT FirstName,LastName,Email 
FROM Customers;
```

### 2. Write an SQL query to list all orders with their order dates and corresponding customer names.
```sql
SELECT OrderID,OrderDate,FirstName,LastName
FROM Orders o INNER JOIN Customers c
ON o.CustomerID=c.CustomerID;
```

### 3. Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
```sql
INSERT INTO Customers
VALUES('C011','Hashirama','Senju','hashirama@gmail.com','8778000010','Address 11');
```

### 4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%
```sql
UPDATE Products
SET Price = (Price*1.1);
```

### 5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
```sql
DECLARE @o VARCHAR(20) = 'OR05';
DELETE FROM OrderDetails
where OrderID=@o
DELETE FROM Orders
where OrderID=@o
```

### 6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
```sql
INSERT INTO Orders
VALUES('OR11','C011','2024-05-18',50000,'Shipped');
```

### 7. Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
```sql
UPDATE Customers
SET Email='usui@gmail.com',
	Address='Address Usui'
where CustomerID='C008';
```

### 8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
```sql
UPDATE orders
SET Orders.TotalAmount = (SELECT (o.Quantity*p.price) 
						FROM Orderdetails o INNER JOIN Products p
						on o.Productid = p.Productid
						where o.OrderID = orders.OrderID);
```

### 9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
```sql
DECLARE @c VARCHAR(20)='C005';
DELETE FROM OrderDetails
where OrderID=(SELECT OrderID
					FROM Orders
					where CustomerID=@c);
DELETE FROM Orders
WHERE CustomerID=@c;
```

### 10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
```sql
INSERT INTO Products
VALUES('P011','Router','Description 11',1000,3);
```

### 11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
```sql
DECLARE @i VARCHAR(20) ='OR09';
DECLARE @s VARCHAR(20) ='Shipped';

UPDATE Orders
SET Status=@s
WHERE OrderID=@i
```

### 12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
```sql
SELECT c.CustomerID,COUNT(OrderID) AS TotalOrder
FROM Customers c LEFT JOIN Orders o
on c.CustomerID=o.CustomerID
GROUP BY c.CustomerID;
```

# Task 3 : Aggregate function, Having, Order By, Group By, and Joins:

### 1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
```sql
SELECT o.OrderID,c.FirstName,c.LastName
FROM Orders o INNER JOIN Customers c
ON c.CustomerID=o.CustomerID;
```

### 2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
```sql
SELECT ProductName,SUM(Price*Quantity)
FROM Products p LEFT JOIN OrderDetails o
on p.ProductID=o.ProductID
GROUP BY ProductName;
```

### 3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
```sql
SELECT * FROM Customers
WHERE CustomerID IN (SELECT CustomerID
				FROM Orders
				GROUP BY CustomerID
				HAVING COUNT(OrderID)>=1);
```


### 4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
```sql
SELECT p.ProductName,p.productID,o.TotalQuantity
FROM Products p INNER JOIN (select ProductID, sum(Quantity) as TotalQuantity
							FROM OrderDetails
							GROUP BY ProductID
							ORDER BY sum(Quantity) desc
							OFFSET 0 ROWS
							FETCH NEXT 1 ROWS ONLY) o
ON p.ProductID=o.ProductID
;
```
### 5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
```sql
SELECT ProductName,Category
FROM Products
order by category
```

### 6.  Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Name,o.AverageOrderValue
FROM Customers c INNER JOIN(SELECT CustomerID,AVG(TotalAmount) AS AverageOrderValue
							FROM Orders
							GROUP BY CustomerID) o
ON c.CustomerID=o.customerID
```

### 7.  Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
```sql
SELECT OrderID,FirstName,TotalAmount AS TotalRevenue
FROM Customers c INNER JOIN Orders o
ON c.CustomerID=o.CustomerID
where c.CustomerID = (Select CustomerID
					FROM Orders
					where TotalAmount=(SELECT MAX(TotalAmount)
									FROM Orders))
	  AND TotalAmount = (SELECT MAX(TotalAmount)
									FROM Orders)
```


### 8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
```sql
SELECT ProductName,COUNT(o.ProductID)
FROM Products p LEFT JOIN OrderDetails o
ON p.ProductID=o.ProductID
GROUP BY ProductName
```

### 9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
```sql
DECLARE @p VARCHAR(50) ='Laptop';

SELECT CONCAT(FirstName,' ',LastName) AS Name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
				FROM Orders
				WHERE OrderID IN (SELECT OrderID
								FROM OrderDetails
								where ProductID=(SELECT ProductID
												FROM Products
												WHERE ProductName=@p)))
```

### 10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
```sql
DECLARE @s DATE ='2024-04-15';
DECLARE @e DATE ='2024-05-05';

SELECT SUM(TotalAmount)
FROM Orders
WHERE OrderDate BETWEEN @s AND @e
```


# Task 4

### 1. Write an SQL query to find out which customers have not placed any orders.
```sql
SELECT *  
FROM Customers 
WHERE CustomerID NOT IN (SELECT CustomerID
						FROM Orders)
```

### 2. Write an SQL query to find the total number of products available for sale.
```sql
SELECT SUM(QuantityInStock)
FROM Inventory;
```

### 3. Write an SQL query to calculate the total revenue generated by TechShop. 
```sql
SELECT SUM(TotalAmount) AS TotalRevenueGenerated FROM Orders;
```

### 4. Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
```sql
DECLARE @c INT =1;
SELECT ProductName,AVG(Quantity)
FROM OrderDetails o INNER JOIN (select productName,ProductID,Category
							FROM Products
							WHERE Category=@c) p
ON o.ProductID=p.ProductID
GROUP BY ProductName

```

### 5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
```sql
DECLARE @i VARCHAR(20) ='C001';
SELECT CONCAT(FirstName,' ',LastName) AS Name, (SELECT SUM(TotalAmount) 
												FROM Orders
												WHERE CustomerID=@i) AS RevenueGenerated
FROM Customers
WHERE CustomerID=@i;
```


### 6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
```sql
SELECT CONCAT(FirstName,' ', LastName) AS Name, p.TotalOrders as TotalOrders 
FROM Customers c INNER JOIN (SELECT TOP 1 CustomerID, od.Quantity AS TotalOrders
							FROM Orders o INNER JOIN OrderDetails od 
							ON o.OrderID = od.OrderID 
							ORDER BY od.Quantity DESC) p 
ON c.CustomerID = p.CustomerID ;

```

### 7. Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders
```sql
SELECT TOP 1 Category AS FamousCategory,SUM(Quantity) AS TotalQuantityOrdered
FROM Products p INNER JOIN Orderdetails o
ON p.ProductID=o.ProductID
GROUP BY category
ORDER BY SUM(Quantity) DESC
```

### 8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Name, HighestRevenue
FROM Customers c INNER JOIN (SELECT customerID,SUM(TotalAmount) AS HighestRevenue
						FROM Orders
						GROUP BY CustomerID
						ORDER BY SUM(TotalAmount) DESC
						OFFSET 0 ROWS
						FETCH NEXT 1 ROWS ONLY) o
ON c.CustomerID=o.customerID

```

### 9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Name,o.AverageOrderValue
FROM Customers c INNER JOIN(SELECT CustomerID,AVG(TotalAmount) AS AverageOrderValue
							FROM Orders
							GROUP BY CustomerID) o
ON c.CustomerID=o.customerID
```


### 10. Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count
```sql
SELECT CONCAT(FirstName,' ',LastName) AS Name,ISNULL(TotalOrderswithNull,0) AS TotalOrders
FROM Customers c LEFT JOIN (SELECT CustomerID,COUNT(OrderID) AS TotalOrderswithNull
						FROM Orders
						GROUP BY customerID) o
ON c.CustomerID=o.CustomerID
```
