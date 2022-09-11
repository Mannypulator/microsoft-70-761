
USE WideWorldImporters;
GO

-- except (unused item colors)
SELECT ColorID FROM Warehouse.Colors
EXCEPT
SELECT ColorID FROM Warehouse.StockItems;

-- intersect (used item colors)
SELECT ColorID FROM Warehouse.Colors
INTERSECT
SELECT ColorID FROM Warehouse.StockItems;