
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Refactor the WHERE clause of this query to make it SARGable.

HINT: View the execution plan and create the necessary index!

*/

-- Not SARG-able =[
SELECT OrderID, OrderDate, YEAR(OrderDate) as OrderYear
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2016;

-- SARG-able? =]
SELECT OrderID, OrderDate, YEAR(OrderDate) as OrderYear
FROM Sales.Orders
WHERE OrderDate >= '20160101' AND OrderDate <= '20161231';