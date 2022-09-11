
USE AdventureWorks;
GO

-- scalar subquery (SELECT clause)
SELECT ProductID, ProductNumber, Name AS ProductName, 
	   Weight,
	   (SELECT AVG(Weight) FROM Production.Product) AS AverageWeight,
	   Weight - (SELECT AVG(Weight) FROM Production.Product) AS WeightDifference,
	   ListPrice,
	   (SELECT AVG(ListPrice) FROM Production.Product) AS AverageListPrice,
	   DaysToManufacture - (SELECT AVG(ListPrice) FROM Production.Product) AS ListPriceDifference
FROM Production.Product
WHERE ListPrice > 0 AND Weight > 0;

-- scalar subquery (WHERE clause)
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice >= (SELECT AVG(ListPrice) FROM Production.Product);

-- multi-value subquery (WHERE clause)
SELECT ProductID, Name AS ProductName, ListPrice, ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name LIKE '%bikes%');

-- multi-value subquery (FROM clause, derived table)
SELECT ProductID, P.Name AS ProductName, ps.Name AS SubcategoryName, ListPrice
FROM Production.Product p 
JOIN (SELECT ProductSubcategoryID, Name FROM Production.ProductSubcategory WHERE Name LIKE '%bikes%') ps 
ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

--SELECT ProductID, Name AS ProductName, ListPrice, Color
--FROM (SELECT * FROM Production.Product WHERE ListPrice > 100) p
--ORDER BY ListPrice DESC, ProductName;

-- correlated subqueries
SELECT ProductID, Name AS ProductName
FROM Production.Product p
WHERE EXISTS (SELECT * FROM Production.ProductSubcategory psc 
			  WHERE p.ProductSubcategoryID = psc.ProductSubcategoryID AND psc.Name LIKE '%Bikes%');