
USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Write a query that returns the total amount due for each salesperson by year.

Table: Sales.SalesOrderHeader
Columns: SalesPersonID, OrderYear, TotalDue (Summed)
Grouping: SalesPersonID, OrderYear
Filter: Do not include NULL SalesPersonIDs
Sort: SalesPersonID ascending, OrderYear descending

BONUS: include subtotals and grand totals
*/
SELECT SalesPersonID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader;

SELECT SalesPersonID, YEAR(OrderDate) AS OrderYear, SUM(TotalDue) as TotalDue
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, YEAR(OrderDate)
ORDER BY SalesPersonID, OrderYear DESC;
