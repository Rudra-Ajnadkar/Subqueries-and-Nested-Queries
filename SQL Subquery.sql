create database sale;



-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetail Table
CREATE TABLE OrderDetail (
    DetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers VALUES
(1, 'Ravi Shah', 'ravi@example.com'),
(2, 'Sneha Patil', 'sneha@example.com'),
(3, 'Amit Kulkarni', 'amit@example.com');

-- Orders
INSERT INTO Orders VALUES
(101, '2025-06-01', 1),
(102, '2025-06-02', 1),
(103, '2025-06-03', 2);

-- Products
INSERT INTO Products VALUES
(201, 'Laptop', 50000),
(202, 'Mouse', 1000),
(203, 'Keyboard', 1500);

-- OrderDetail
INSERT INTO OrderDetail VALUES
(1, 101, 201, 1, 50000),
(2, 101, 202, 2, 2000),
(3, 102, 203, 1, 1500),
(4, 103, 202, 3, 3000);





-- Subquery in WHERE
SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders
);

-- EXISTS subquery
SELECT Name
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID
);

-- Scalar subquery
SELECT Name,
    (SELECT COUNT(*) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Customers c;

-- Subquery in FROM
SELECT ProductID, AVG(Quantity) AS AvgQuantity
FROM (
    SELECT ProductID, Quantity
    FROM OrderDetail
) AS sub
GROUP BY ProductID;

-- Correlated subquery in HAVING
SELECT ProductID, SUM(Quantity) AS TotalSold
FROM OrderDetail
GROUP BY ProductID
HAVING SUM(Quantity) > (
    SELECT AVG(Quantity) FROM OrderDetail
);
