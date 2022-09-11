
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Write a query that returns a unique list of cities both customers and suppliers reside in.

Tables: Purchasing.Suppliers, Sales.Customers
Columns: PostalCityID

*/

SELECT PostalCityID FROM Purchasing.Suppliers
UNION ALL
SELECT PostalCityID FROM Sales.Customers;
