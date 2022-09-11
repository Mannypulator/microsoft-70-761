
USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Return sales information on orders with a quantity greater than 30 using a derived table.

Columns: SalesOrderID, OrderDate, ProductID, OrderQty
Tables: Sales.SalesOrderHeader, Sales.SalesOrderDetail


BONUS: Re-write the query using a Common Table Expression.

*/

-- derived table
SELECT soh.SalesOrderID, OrderDate, ProductID, OrderQty
FROM Sales.SalesOrderHeader soh
JOIN (SELECT SalesOrderID, ProductID, OrderQty 
	  FROM Sales.SalesOrderDetail 
	  WHERE OrderQty > 30) so ON soh.SalesOrderID = so.SalesOrderID;

-- CTE
WITH SOD_CTE AS (
	SELECT SalesOrderID, ProductID, OrderQty
	FROM Sales.SalesOrderDetail
	WHERE OrderQty > 30
)

SELECT SOH.SalesOrderID, ProductID, OrderQty
FROM Sales.SalesOrderHeader SOH
JOIN SOD_CTE ON SOH.SalesOrderID = SOD_CTE.SalesOrderID;