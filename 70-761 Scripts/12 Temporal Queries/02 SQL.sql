
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Execute the below statement to delete colors that are not associated with any stockitem.

Write a query to identify the deleted records from the sytem-versioned temporal table.

BONUS: Restore those records back into the color table!

*/

DELETE FROM Warehouse.Colors 
WHERE ColorID NOT IN (SELECT ColorID FROM Warehouse.StockItems WHERE ColorID IS NOT NULL);

DECLARE @yesterday datetime2
SET @yesterday = DATEADD(d, -1, SYSUTCDATETIME())

INSERT Warehouse.Colors (ColorID, ColorName, LastEditedBy)
SELECT ColorID, ColorName, LastEditedBy
FROM Warehouse.Colors
FOR SYSTEM_TIME AS OF @yesterday
WHERE ColorID NOT IN (SELECT ColorID FROM Warehouse.Colors);