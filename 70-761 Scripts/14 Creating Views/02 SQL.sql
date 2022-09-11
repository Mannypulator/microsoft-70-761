USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Create a view containing quantity sold since last quantity take and total cost of quantity on hand,
create a query against the view and sort by QuantityOnHandTotalCost descending.

View: Warehouse.vItemQuantity
Columns: StockGroupID, StockGroupName, QuantitySold, QuantityOnHandTotalCost
Tables: Warehouse.StockGroups, Warehouse.StockItemStockGroup, Warehouse.StockItemHoldings

BONUS: Turn it into an indexed view!

*/

CREATE VIEW Warehouse.vItemQuantity
AS
SELECT sg.StockGroupID, 
	   StockGroupName, 
	   SUM(LastStocktakeQuantity - QuantityOnHand) as QuantitySold, 
	   SUM(QuantityOnHand * LastCostPrice) as QuantityOnHandTotalCost
FROM Warehouse.StockGroups sg
JOIN Warehouse.StockItemStockGroups sig ON sg.StockGroupID = sig.StockGroupID
JOIN Warehouse.StockItemHoldings sih ON sig.StockItemID = sih.StockItemID
GROUP BY sg.StockGroupID, StockGroupName;

SELECT * FROM Warehouse.vItemQuantity ORDER BY QuantitySold DESC;

--BONUS
ALTER VIEW Warehouse.vItemQuantity
WITH SCHEMABINDING
AS
SELECT sg.StockGroupID, 
	   StockGroupName, 
	   SUM(LastStocktakeQuantity - QuantityOnHand) as QuantitySold, 
	   SUM(QuantityOnHand * LastCostPrice) as QuantityOnHandTotalCost,
	   COUNT_BIG(*) as RecordCount
FROM Warehouse.StockGroups sg
JOIN Warehouse.StockItemStockGroups sig ON sg.StockGroupID = sig.StockGroupID
JOIN Warehouse.StockItemHoldings sih ON sig.StockItemID = sih.StockItemID
GROUP BY sg.StockGroupID, StockGroupName;

CREATE UNIQUE CLUSTERED INDEX cix_sgid ON Warehouse.vItemQuantity(StockGroupID);

SELECT * FROM Warehouse.vItemQuantity ORDER BY QuantitySold DESC;