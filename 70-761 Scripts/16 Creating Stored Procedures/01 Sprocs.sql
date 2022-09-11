
USE WideWorldImporters;
GO

-- basic stored procedure
CREATE PROCEDURE Warehouse.GetColor
	@ColorID int
AS
	SELECT * FROM Warehouse.Colors WHERE ColorID = @ColorID
GO

EXEC Warehouse.GetColor 10;
EXEC Warehouse.GetColor 20;

-- view stored procedure plan cache
SELECT * FROM sys.dm_exec_cached_plans
CROSS APPLY sys.dm_exec_sql_text(plan_handle)
CROSS APPLY sys.dm_exec_query_plan(plan_handle);
GO

-- dynamic stored procedure
ALTER PROCEDURE Sales.GetOrders
	@CustomerID int = NULL,
	@SalesPersonID int = NULL,
	@StartOrderDate date = NULL, 
	@EndOrderDate date = NULL
WITH RECOMPILE
AS
    SELECT OrderID, CustomerID, SalespersonPersonID, OrderDate, ExpectedDeliveryDate, DeliveryInstructions
	FROM Sales.Orders
	WHERE (CustomerID = @CustomerID OR @CustomerID IS NULL)
			AND
		  (SalespersonPersonID = @SalesPersonID OR @SalesPersonID IS NULL)
			AND
		  (
		   (OrderDate >= @StartOrderDate OR @StartOrderDate IS NULL) 
			AND 
		   (OrderDate <= @EndOrderDate OR @EndOrderDate IS NULL)
		  );
GO

EXEC Sales.GetOrders
EXEC Sales.GetOrders 105,7,'20160101','20161231';
EXEC Sales.GetOrders NULL,7,'20160101','20161231';
EXEC Sales.GetOrders 105,NULL,'20160101','20161231';
EXEC Sales.GetOrders @StartOrderDate = '20160101';
EXEC Sales.GetOrders @EndOrderDate = '20160101';
EXEC Sales.GetOrders @StartOrderDate = '20160101',@EndOrderDate = '20161231';
GO

-- stored procedure with output parameter
CREATE PROCEDURE Warehouse.AddColor
	@ColorName nvarchar(20),
	@ColorID int OUTPUT
WITH EXECUTE AS OWNER
AS
	SET @ColorID = NEXT VALUE FOR Sequences.ColorID;

	INSERT INTO Warehouse.Colors(ColorID, ColorName,LastEditedBy)
		 VALUES(@ColorID, @ColorName,1);	
GO

DECLARE @NewColorID int;
EXEC Warehouse.AddColor 'MyFavoriteColor', @ColorID = @NewColorID OUTPUT;
PRINT @NewColorID;