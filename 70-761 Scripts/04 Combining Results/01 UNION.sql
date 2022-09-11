
USE WideWorldImporters;
GO

-- two seperate results (no union)
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 1 AND 10;
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 5 AND 15;

-- combine results (no duplicates)
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 1 AND 10
UNION
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 5 AND 15;

-- combine results (with duplicates)
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 1 AND 10
UNION ALL
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 5 AND 15;

-- combine and order results in final query
SELECT StockItemName FROM Warehouse.StockItems WHERE StockItemID BETWEEN 1 AND 10
UNION
SELECT StockItemName FROM Warehouse.StockItems WHERE StockItemID BETWEEN 5 AND 15 ORDER BY StockItemName;

-- combine results from many tables
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 1 AND 10
UNION
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 5 AND 15
UNION
SELECT * FROM Warehouse.StockItems WHERE StockItemID BETWEEN 10 AND 20 ORDER BY StockItemID;

-- combine different columns from different tables (same data type)
SELECT CityName AS CityOrCountry FROM Application.Cities
UNION
SELECT CountryName FROM Application.Countries ORDER BY CityOrCountry;