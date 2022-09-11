
USE AdventureWorks;
GO

-- product sales aggregate query
SELECT 
	ProductID,
	SUM(LineTotal) AS TotalSales, 
	COUNT(*) AS NumberSales,
	MIN(OrderDate) AS FirstOrderDate,
	MAX(OrderDate) AS LastOrderDate
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
GROUP BY ProductID
ORDER BY TotalSales DESC;


-- aggregate query turned into a derived table and joined against
SELECT p.Name as ProductName, psc.Name as ProductSubcategory, soa.*
FROM Production.Product p
JOIN
	(SELECT 
		ProductID,
		SUM(LineTotal) AS TotalSales, 
		COUNT(*) AS NumberSales,
		MIN(OrderDate) AS FirstOrderDate,
		MAX(OrderDate) AS LastOrderDate
	FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
	GROUP BY ProductID) soa ON p.ProductID = soa.ProductID
JOIN
	Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubCategoryID
ORDER BY TotalSales DESC;