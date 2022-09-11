USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Add transaction support with error handling to the following stored procedure!

*/

CREATE PROCEDURE Warehouse.DeleteColor
	@ColorID int,
	@MakeItError bit = 0
AS	
	BEGIN TRY 
		BEGIN TRANSACTION 
			UPDATE Warehouse.StockItems 
			SET ColorID = NULL 
			WHERE ColorID = @ColorID;

			If @MakeItError = 1
				THROW 51001, 'You made me do it!', 1;

			DELETE FROM Warehouse.Colors
			WHERE ColorID = @ColorID;
		COMMIT; 
	END TRY 
	BEGIN CATCH 
		SELECT ERROR_NUMBER() as ErrNumber, ERROR_MESSAGE() as ErrMessage; 
		ROLLBACK;  
	END CATCH  
GO

EXEC Warehouse.DeleteColor 3, 1; 
EXEC Warehouse.DeleteColor 3, default; 

SELECT * FROM Warehouse.Colors WHERE ColorID = 3; 
SELECT * FROM Warehouse.StockItems WHERE ColorID = 3; 