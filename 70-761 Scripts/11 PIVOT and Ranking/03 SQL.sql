
USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Transform the following detail query into a matrix by adding a pivot on ProductCategoryName 
and aggregating the SubTotal by OrderYear, sort the results by OrderYear.

BONUS: Add OrderMonth into the detail data and sort order.

*/

SELECT * FROM
(
	SELECT pc.Name as ProductCategoryName, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) as OrderMonth, CAST(SubTotal as decimal(10,2)) as SubTotal
	FROM Production.Product p
	JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
	JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
) src
PIVOT
(
	SUM(SubTotal)
	FOR ProductCategoryName IN ([Accessories],[Bikes],[Components],[Clothing])
) pvt
ORDER BY OrderYear, OrderMonth;