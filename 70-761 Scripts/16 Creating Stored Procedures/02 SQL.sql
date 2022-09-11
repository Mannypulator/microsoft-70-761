
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Write a stored procedure that will update a color, execute the stored procedure
and verify it worked.

Stored Procedure: Warehouse.UpdateColor
Input Parameters: @ColorID, @ColorName

*/

CREATE PROCEDURE Warehouse.UpdateColor
	@ColorID int,
	@ColorName nvarchar(20)
AS
	UPDATE Warehouse.Colors
	SET ColorName = @ColorName
	WHERE ColorID = @ColorID;
GO

EXEC Warehouse.UpdateColor 13, 'Pink';

SELECT * FROM Warehouse.Colors WHERE ColorID = 13;