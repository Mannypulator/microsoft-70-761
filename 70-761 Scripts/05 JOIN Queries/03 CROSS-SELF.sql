
USE WideWorldImporters;
GO

-- 8 items from supplier
SELECT * FROM Warehouse.StockItems WHERE SupplierID = 1;

-- 36 colors
SELECT * FROM Warehouse.Colors;

-- cross join : 288 results (every color for every item from supplier)
SELECT i.StockItemName, c.ColorName
FROM Warehouse.StockItems i
CROSS JOIN Warehouse.Colors c
WHERE SupplierID = 1;

-- self join : customers billed by other customers
SELECT c.CustomerName as Customer, b.CustomerName as BilledToCustomer
FROM Sales.Customers b
JOIN Sales.Customers c ON b.CustomerID = c.BillToCustomerID;