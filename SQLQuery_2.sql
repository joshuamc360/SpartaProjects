USE Northwind
SELECT * FROM Customers c WHERE c.City = 'London'
SELECT * FROM Customers

SELECT * FROM Employees e WHERE e.TitleOfCourtesy='Dr.'

SELECT COUNT(*) AS "Products Discontinued" FROM Products p --p is an alise for products
WHERE p.Discontinued =1

--Find Comanyname in multiple cities
SELECT c.CompanyName, C.City
FROM Customers c
WHERE C.Region In ('BC', 'SP')

--Limits the number of entries returned to 100
SELECT TOP 100 CompanyName, City From Customers
WHERE Country = 'France'

SELECT ProductName, UnitPrice FROM Products
WHERE UnitsInStock >0 OR UnitPrice >29.99

SELECT COUNT(ProductName) FROM Products
WHERE UnitsInStock >0 OR UnitPrice >29.99

SELECT DISTINCT Country FROM Customers
WHERE ContactTitle = 'Owner'

--fIND product name starting with A
SELECT * FROM Products p where p.ProductName LIKE  'A%'

--Find product name with the second character as H
SELECT * FROM Products p where p.ProductName LIKE  '_H%'

--finds all products ending in A
SELECT * FROM Products p where p.ProductName LIKE  '_A%'

SELECT ProductName, ProductId FROM Products
WHERE UnitPrice < 5.00

SELECT * FROM Categories WHERE CategoryName LIKE '[BS]%'

SELECT C.CompanyName AS "Company Name", 
CONCAT (C.City, C.Country) 
AS "City " 
From Customers C

--Find record with not null values 
SELECT DISTINCT Country FROM Customers c 
WHERE c.Region IS NOT NULL

--Multiplication of fields in new column
SELECT UnitPrice, Quantity, Discount, UnitPrice*Quantity 
AS "Gross Total", UnitPrice*Quantity-Discount 
AS "Net Total"
FROM [Order Details]

--Presents Fields in decending order
SELECT TOP 5 od.UnitPrice, od.Quantity, od.Discount, od.UnitPrice*od.Quantity 
AS "Gross Total"
FROM [Order Details] od
ORDER BY "Gross Total" DESC

--Substring of a postal adress string 
SELECT c.PostalCode "Post Code", 
LEFT(c.PostalCode, CHARINDEX(' ', c.PostalCode)-1) AS "Post Code Region", 
CHARINDEX('',PostalCode) AS "Space Found", Country 
FROM Customers c
WHERE Country= 'UK'

--'''' This is an escape sequence for '
SELECT ProductName FROM Products
WHERE ProductName LIKE '%''%'
--WHERE CHARINDEX('''', ProductName)!=0

-- DATEADD has 3 arguements dd mm yy , the date to be added, how many units to add
SELECT DATEADD(D,5,OrderDate) AS "Due Date",
DATEDIFF(d,OrderDate,ShippedDate)AS "Ship Days"
FROM Orders

SELECT e.FirstName, DATEDIFF(DAY, e.BirthDate, GetDate()) / 365.25 AS "AGE"
FROM Employees e

SELECT CASE
WHEN DATEDIFF(d, OrderDate, ShippedDate)<10 Then 'On Time'
ELSE 'Overdue'
END AS "Status"
FROM Orders

-- Case is used to as an if statement to show multiple conditions 
SELECT CASE
WHEN DATEDIFF(d, e.BirthDate, GetDate())/ 365.25 >65 Then 'Retired'
WHEN DATEDIFF(d, e.BirthDate, GetDate())/ 365.25>60 Then 'Retirement due'
WHEN DATEDIFF(d, e.BirthDate, GetDate())/ 365.25<60 Then 'More than 5 years to go'
END AS "Retirement"
FROM Employees e