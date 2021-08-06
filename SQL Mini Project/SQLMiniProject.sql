USE Northwind

SELECT * FROM Customers

--Exercise 1
--1.1 Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all address fields. 
SELECT c.CustomerID, c.CompanyName, c.Address
FROM Customers c
WHERE c.City in ('Paris','London')

--1.2 List all products stored in bottles. 
SELECT * 
FROM Products p 
WHERE p.QuantityPerUnit LIKE '%bottles'

--1.3 Repeat question above, but add in the Supplier Name and Country. 
SELECT p.* ,s.ContactName AS 'Supplier Contact', s.Country AS 'Supplier Contact'
FROM Products p INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.QuantityPerUnit LIKE '%bottles'

--1.4 Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first. 
SELECT COUNT(*) AS "Products per Category", c.CategoryName FROM Categories c INNER JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY p.CategoryID, c.CategoryName 
ORDER BY COUNT(p.CategoryID) DESC

--1.5 List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence. 
SELECT e.TitleOfCourtesy+ ' '+e.FirstName+ ' '+e.LastName, e.City
FROM Employees e
WHERE Country= 'UK'

--1.6 List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers.
SELECT FORMAT(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)),'N') AS "Sales Totals", r.RegionDescription FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID=o.OrderID
INNER JOIN EmployeeTerritories et ON o.EmployeeID=et.EmployeeID 
INNER JOIN Territories t ON t.TerritoryID=et.TerritoryID
INNER JOIN Region r ON r.RegionID=t.RegionID
GROUP BY r.RegionDescription
HAVING SUM(od.Quantity*(od.UnitPrice-od.Discount)) > 1000000

--1.7 Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country. 
SELECT COUNT(o.Freight )FROM Orders o 
WHERE o.ShipCountry IN ('USA' , 'UK' ) 
AND o.Freight > 100

--1.8 Write an SQL Statement to identify the Order Number of the Order with the highest amount(value) of discount applied to that order. 
SELECT OrderID, SUM(UnitPrice*Quantity*Discount) AS "Discounted Value"
FROM [Order Details]
GROUP BY OrderID
ORDER BY "Discounted Value" DESC

--Excersize 2
--2.1 Write the coreect sql statement to create the following table 
CREATE TABLE Spartans (
    firtst_name VARCHAR(20) NOT NULL, 
    last_name VARCHAR(20) NOT NULL, 
    university VARCHAR(20) NOT NULL, 
    course_taken VARCHAR(20) NOT NULL, 
    mark_achieved DECIMAL(2,1) NOT NULL, 
)


--2.2 Write Write SQL statements to add the details of the Spartans in your course to the table you have created.
INSERT INTO Spartans(firtst_name, last_name, university,course_taken, mark_achieved) 
VALUES('twiddle', 'dee', 'pen state', 'computer science', 2.1)

INSERT INTO Spartans(firtst_name, last_name, university,course_taken, mark_achieved) 
VALUES('millie', 'myles', 'ohio state', 'science', 2.1),('twiddle', 'dum', 'utah', 'robotics', 2.2)

SELECT * FROM Spartans

--Excercise 3
--3.1 List all Employees from the Employees table and who they report to. No Excel required. Please mention the Employee Names and the ReportTo names. 
SELECT e1.FirstName, e1.lastname, e2.FirstName AS 'Supervisior' 
FROM Employees e1 
INNER JOIN Employees e2
ON e2.EmployeeID = e1.ReportsTo

--3.2 List all Suppliers with total sales over $10,000 in the Order Details table. 
--Include the Company Name from the Suppliers Table and present as a bar chart as below:


SELECT s.CompanyName,
SUM((od.UnitPrice * od.Quantity)*(1-od.Discount)) AS "Total Sales"
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID
JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY s.CompanyName
HAVING SUM((od.UnitPrice * od.Quantity)*(1-od.Discount)) > 10000
ORDER BY "Total Sales" DESC

--3.3
SELECT TOP 10 c.CompanyName, ROUND(SUM(od.Quantity*(od.UnitPrice-od.Discount)),2) AS "Total" FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate)=(SELECT MAX(YEAR(o.OrderDate)) FROM Orders o)
GROUP BY c.CompanyName
ORDER BY "Total" DESC

--3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below.

--Solution 1
SELECT FORMAT("Date",'MM/yyyy') AS "Month/Year",
 AVG("ShipTime") AS "AverageShipTimeByMonth"
FROM 
    (SELECT o.OrderDate AS "Date", MONTH(o.OrderDate) AS "Month", YEAR(o.OrderDate) AS "Year",
    DATEDIFF(DAY, o.OrderDate, o.ShippedDate) AS "ShipTime" 
    FROM Orders o) AS "ShipTimes"
GROUP BY FORMAT("Date",'MM/yyyy'), "Month", "Year"
ORDER BY "Year" ASC, "Month" ASC

--Solution 2
SELECT CONCAT(MONTH(o.OrderDate),'-',YEAR(o.OrderDate)) AS "MONTH-YEAR", 
AVG(CAST(DATEDIFF(d, o.OrderDate, o.ShippedDate) AS DECIMAL(10,2))) AS "Ship Time By Month" --get the ship time converted to a int then calculate the average
FROM Orders o
WHERE o.ShippedDate IS NOT NULL
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY YEAR(o.OrderDate) DESC, MONTH(o.OrderDate) ASC
