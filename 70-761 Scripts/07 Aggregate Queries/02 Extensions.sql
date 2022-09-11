
USE WideWorldImporters;
GO

-- ROLLUP for subtotals and totals
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
GROUP BY ROLLUP(YEAR(OrderDate), c.ColorName)
ORDER BY OrderYear DESC, TotalSales DESC;

-- GROUPING SETS for combining grouped queries (alternative to UNION ALL)
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
GROUP BY GROUPING SETS
(
	(YEAR(OrderDate)),
	(c.ColorName),
	(YEAR(OrderDate), c.ColorName)
)
ORDER BY OrderYear;

-- CUBE for all possible combinations
SELECT	YEAR(OrderDate) AS OrderYear,
		c.ColorName,
		SUM(ol.Quantity * ol.UnitPrice) AS TotalSales, 
		AVG(ol.Quantity * ol.UnitPrice) AS AverageSales,
		COUNT(*) AS NumberSales
FROM Warehouse.Colors c
JOIN Warehouse.StockItems si ON c.ColorID = si.ColorID
JOIN Sales.OrderLines ol ON si.StockItemID = ol.StockItemID
JOIN Sales.Orders o ON ol.OrderID = o.OrderID
GROUP BY CUBE(YEAR(OrderDate), c.ColorName)
ORDER BY OrderYear DESC, TotalSales DESC;