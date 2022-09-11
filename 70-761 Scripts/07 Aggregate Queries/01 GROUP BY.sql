
USE WideWorldImporters;
GO

-- raw data without GROUP BY for reference
SELECT	si.StockItemID, ol.OrderLineID, ol.OrderID, c.ColorName, 
		ol.Quantity, 
		ol.UnitPrice
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID;

-- GROUP BY with a single grouping
SELECT	c.ColorName, 
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
GROUP BY c.ColorName
ORDER BY TotalSales DESC;

-- GROUP BY with multiple groupings
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
GROUP BY YEAR(OrderDate), c.ColorName
ORDER BY OrderYear DESC, TotalSales DESC;

-- GROUP BY with multiple groupings and a HAVING filter
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
GROUP BY YEAR(OrderDate), c.ColorName
HAVING COUNT(*) > 5000
ORDER BY OrderYear DESC, TotalSales DESC;

-- GROUP BY with multiple groupings, a WHERE clause, and a HAVING filter
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
WHERE OrderDate >= '20150101' AND OrderDate <= '20161231'
GROUP BY YEAR(OrderDate), c.ColorName
--HAVING COUNT(*) > 5000
ORDER BY OrderYear DESC, TotalSales DESC;