
USE WideWorldImporters;
GO

-- return records from a specific supplier
SELECT *
FROM Warehouse.StockItems
WHERE SupplierID = 5;

-- return records from a specific supplier and of a specific color
SELECT StockItemName
FROM Warehouse.StockItems
WHERE SupplierID = 5 AND ColorID = 3;

-- combining predicates, unintended result
SELECT StockItemName
FROM Warehouse.StockItems
WHERE SupplierID = 4 OR SupplierID = 5 AND ColorID = 3;

-- combining predicates, controlling order (precendence: NOT > AND > OR)
SELECT StockItemName
FROM Warehouse.StockItems
WHERE (SupplierID = 4 OR SupplierID = 5) AND ColorID = 3;

-- character predicates, XL or XXL records
SELECT *
FROM Warehouse.StockItems
WHERE Size = 'XL' OR Size = 'XXL';

-- LIKE predicate, anything that starts with X
SELECT *
FROM Warehouse.StockItems
WHERE Size LIKE 'X%';

-- LIKE predicate, anything that starts with X, NOT containing an S
SELECT *
FROM Warehouse.StockItems
WHERE Size LIKE 'X%' AND Size NOT LIKE '%S%';

-- datetime predicate
SELECT * 
FROM Sales.Orders 
WHERE OrderDate = '20160101';

-- datetime range, be careful with BETWEEN!
SELECT OrderID, OrderDate 
FROM Sales.Orders 
WHERE OrderDate BETWEEN '20160101' AND '20160131'
ORDER BY OrderDate;

-- datetime range, open-ended date range
SELECT OrderID, OrderDate 
FROM Sales.Orders 
WHERE OrderDate >= '20160101' AND OrderDate < '20160201'
ORDER BY OrderDate;