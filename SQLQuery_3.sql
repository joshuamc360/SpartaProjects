USE Northwind

SELECT * FROM Customers

SELECT SUM (UnitsOnOrder) AS "Totoal On Order", 
AVG(UnitsOnOrder) AS "Avg On Order",
MIN(UnitsOnOrder) AS "Min On Order", 
MAX(UnitsOnOrder) AS  "Max on order "
FROM Products
GROUP BY SupplierID

--Group sections together
SELECT p.CategoryID, AVG(p.ReorderLevel) AS "Highest Average Reorder Level" FROM Products p
GROUP BY p.CategoryID
ORDER BY "Highest Average Reorder Level" DESC

--Multiple inner join from 3 tables 
SELECT * FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od on od.OrderID = o.OrderID
INNER JOIN Products p On p.ProductID = od.ProductID

--Homework
SELECT s.CompanyName FROM Products p INNER JOIN Suppliers s ON  p.SupplierID= s.SupplierID
GROUP BY s.CompanyName

SELECT o.OrderID, c.CompanyName, e.FirstName+ ' '+e.LastName  FROM Orders o INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON E.EmployeeID= o.EmployeeID

--Two ways of formatting dates

SELECT OrderID, CONVERT(VARCHAR(10), OrderDate,103) AS [dd/MM/yyyy]
FROM Orders; --Before 2012

SELECT OrderID, FORMAT(OrderDate,'dd/MM/yyyy') 
FROM Orders; --Before 2012

--Subquery to show all records that does'nt meet a specific condition
SELECT c.CompanyName AS "Customer"
FROM Customers c 
WHERE c.CustomerID NOT IN 
(SELECT c.CustomerID FROM Orders o)

--JOIN ON LEFT 
SELECT c.CompanyName AS "Customer"
FROM Customers c 
LEFT JOIN Orders o 
ON o.CustomerID = c.CustomerID
WHERE o.CustomerID IS NULL

--Same QUERY BUT WITH RIGHT JOIN 
SELECT c.CompanyName AS "Customer"
FROM Orders o
RIGHT JOIN Customers c  
ON o.CustomerID = c.CustomerID
WHERE o.CustomerID IS NULL

SELECT OrderID, productID, UnitPrice, Quantity, Discount,
(SELECT MAX(UnitPrice)FROM [Order Details]od) AS  "Max Price"
FROM [Order Details]

SELECT od.ProductID, sq1.Totalamt AS "Total Sold for this Product",
UnitPrice, UnitPrice*Quantity/Totalamt*100 AS "% of Total"
FROM [Order Details]od
INNER JOIN 
(SELECT ProductID , SUM(UnitPrice * Quantity) AS Totalamt
FROM [Order Details]
GROUP BY ProductID)sq1 ON sq1.ProductID = od.ProductID

SELECT * FROM [Order Details]
SELECT * FROM Products

--Same query using an Sub query 
SELECT od.OrderID, od.ProductID, od.UnitPrice, od.Quantity, od.Discount 
FROM [Order Details] od
WHERE od.ProductID IN (SELECT P.ProductID FROM Products P WHERE p.Discontinued = 1 )

--Same query using an INNER JOIN 
SELECT od.OrderID, od.ProductID, od.UnitPrice, od.Quantity, od.Discount 
FROM [Order Details] od
INNER JOIN Products p 
on od.ProductID = p.ProductID
WHERE P.Discontinued=1

--The UNION operator is used to combine the result-set of two or more SELECT statements.
SELECT e.EmployeeID AS "Employee/Supplier"
FROM Employees e
UNION ALL 
SELECT SupplierID
FROM Suppliers s