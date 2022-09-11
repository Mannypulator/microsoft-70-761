
USE WideWorldImporters;
GO


/*
-- SQL QUERY CHALLENGE --

Write a query that returns the 10 most expensive stock items, 
include a column that calculates sales tax.

Table: Warehouse.StockItems
Columns: StockItemName, UnitPrice, TaxRate, SalesTax
Sort: UnitPrice

*/

SELECT StockItemName, UnitPrice, TaxRate, (UnitPrice * (TaxRate / 100)) as SalesTax
FROM Warehouse.StockItems
ORDER BY UnitPrice DESC;