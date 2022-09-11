
USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Write a query using a subquery to return a list of products that have been ordered.

Columns: ProductID, ProductName
Outer Table: Production.Product
Inner Table: Sales.SalesOrderDetails

BONUS: Re-work the query to return products that have NOT been ordered.

*/

SELECT ProductID, Name AS ProductName
FROM Production.Product
WHERE ProductID NOT IN (SELECT ProductID FROM Sales.SalesOrderDetail);