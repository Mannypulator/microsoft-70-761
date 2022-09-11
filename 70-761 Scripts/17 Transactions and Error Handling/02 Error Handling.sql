
USE WideWorldImporters;
GO

TRUNCATE TABLE Warehouse.Transactions;

-- try this code
BEGIN TRY
	BEGIN TRANSACTION
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hi');
		-- failure (NULL error)
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(2, NULL);
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(3, 'Hello');
		-- failure (key error)
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hiya');
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(4, 'Hola');
	COMMIT;
END TRY
-- if an error occurs, rollback entire transaction
BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrNumber, ERROR_MESSAGE() as ErrMessage, ERROR_SEVERITY() as ErrSeverity;
	ROLLBACK;
END CATCH;

SELECT * FROM Warehouse.Transactions;

-- successful
BEGIN TRY
	BEGIN TRANSACTION
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(1, 'Hi');
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(3, 'Hello');
		-- success
		INSERT INTO Warehouse.Transactions (TheID, TheData) VALUES(4, 'Hola');

		THROW 51000, 'Something bad happened!', 1;
	COMMIT;
END TRY
BEGIN CATCH
	THROW
	SELECT ERROR_NUMBER() as ErrNumber, ERROR_MESSAGE() as ErrMessage, ERROR_SEVERITY() as ErrSeverity;
	ROLLBACK;
END CATCH;