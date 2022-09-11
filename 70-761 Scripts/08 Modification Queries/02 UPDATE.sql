
USE WideWorldImporters;
GO

-- UPDATE
BEGIN TRAN
SELECT * FROM Warehouse.StockItemHoldings;

UPDATE Warehouse.StockItemHoldings
SET QuantityOnHand *= 0.7,
	ReorderLevel *= 0.9;
SELECT * FROM Warehouse.StockItemHoldings;
ROLLBACK

-- UPDATE with JOIN 
UPDATE sih
SET QuantityOnHand *= 0.7,
	ReorderLevel *= 0.9
FROM Warehouse.StockItemHoldings sih
JOIN Warehouse.StockItemStockGroups sig ON sih.StockItemID = sih.StockItemID
WHERE sig.StockGroupID = 3;

-- UPDATE with OUTPUT
UPDATE sih
SET QuantityOnHand *= 0.5,
	ReorderLevel *= 0.5
OUTPUT deleted.*, inserted.*
FROM Warehouse.StockItemHoldings sih
JOIN Warehouse.StockItemStockGroups sig ON sih.StockItemID = sih.StockItemID
WHERE sig.StockGroupID = 3;