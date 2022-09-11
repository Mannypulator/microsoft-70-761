USE WideWorldImporters;
GO

-- DELETE
DELETE FROM Sales.OrderLines 
WHERE OrderID = 1;

-- DELETE with JOIN
DELETE FROM ol
FROM Sales.OrderLines ol
JOIN Warehouse.StockItemStockGroups sig ON ol.StockItemID = sig.StockItemID
WHERE StockGroupID = 4;

-- DELETE with OUTPUT
DELETE ol
OUTPUT deleted.*
INTO Sales.OrderLines_bak
FROM Sales.OrderLines ol
JOIN Warehouse.StockItemStockGroups sig ON ol.StockItemID = sig.StockItemID
WHERE StockGroupID = 3;


