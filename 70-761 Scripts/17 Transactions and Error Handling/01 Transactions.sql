
USE WideWorldImporters;
GO

-- autocommit transactions
DELETE FROM Warehouse.Colors WHERE ColorName = 'Wheat';
DELETE FROM Warehouse.Colors WHERE ColorName = 'Blue';

-- explicit transaction
BEGIN TRANSACTION
	DELETE FROM Warehouse.Colors 
	WHERE ColorID NOT IN 
		(SELECT DISTINCT ColorID FROM Warehouse.StockItems WHERE ColorID IS NOT NULL);
ROLLBACK;

SELECT * FROM Warehouse.Colors 
WHERE ColorID NOT IN 
	(SELECT DISTINCT ColorID FROM Warehouse.StockItems WHERE ColorID IS NOT NULL);

-- ddl transaction
BEGIN TRANSACTION
	TRUNCATE TABLE Sales.CustomerTransactions;
	DROP VIEW Warehouse.vItemQuantity;
	CREATE TABLE Warehouse.NewTable(NewTableID int);
ROLLBACK;

-- explicit transaction with SQL Server defaults
CREATE TABLE Warehouse.Transactions (
	TheID int NOT NULL PRIMARY KEY, 
	TheData nvarchar(10) NOT NULL
); 

BEGIN TRANSACTION
	-- success
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hi');
	-- failure (NULL error)
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(2, NULL);
	-- sucess
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(3, 'Hello');
	-- failure (key error)
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hiya');
	-- success
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(4, 'Hola');
COMMIT;

SELECT * FROM Warehouse.Transactions;
TRUNCATE TABLE Warehouse.Transactions;

-- explicit transaction with xact_abort
SET XACT_ABORT ON;
BEGIN TRANSACTION
	-- success
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hi');
	-- failure (NULL error)
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(2, NULL);
	-- sucess
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(3, 'Hello');
	-- failure (key error)
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hiya');
	-- success
	INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(4, 'Hola');
COMMIT;

SELECT * FROM Warehouse.Transactions;