
USE WideWorldImporters;
GO

-- query the current table
SELECT * FROM Warehouse.Colors;

-- add data
INSERT Warehouse.Colors (ColorName, LastEditedBy)
	VALUES ('Aqua', 1),
		   ('Turquoise', 1);

-- query the history table using FOR SYSTEM_TIME
DECLARE @yesterday datetime2
SET @yesterday = DATEADD(d, -1, SYSUTCDATETIME())

SELECT *
FROM Warehouse.Colors
FOR SYSTEM_TIME AS OF @yesterday;
GO

-- FROM..TO and BETWEEN..AND
DECLARE @yesterday datetime2
SET @yesterday = DATEADD(d, -1, SYSUTCDATETIME())
DECLARE @tomorrow datetime2
SET @tomorrow = DATEADD(d, 1, SYSUTCDATETIME())

SELECT *
FROM Warehouse.Colors
FOR SYSTEM_TIME FROM @yesterday TO @tomorrow;

SELECT *
FROM Warehouse.Colors
FOR SYSTEM_TIME BETWEEN @yesterday AND @tomorrow;

-- CONTAINED..IN
SELECT *
FROM Warehouse.Colors
FOR SYSTEM_TIME CONTAINED IN (@yesterday, @tomorrow);

-- remove data 
DELETE FROM Warehouse.Colors WHERE ColorID = 38;
