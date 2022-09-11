
USE WideWorldImporters;
GO


-- ISNULL vs COALESCE
SELECT ISNULL(NULL, 'Hello!') as [ISNULL];
SELECT COALESCE(NULL, NULL, NULL, 'Hello again!') as [COALESCE];


-- ISNULL usage
SELECT StockItemName,
	   ISNULL(ColorName, 'N/A') as Color
FROM Warehouse.StockItems si
LEFT JOIN Warehouse.Colors c ON si.ColorID = c.ColorID;


-- COALESCE usage
ALTER PROCEDURE [Sales].[GetOrders]
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

EXEC Sales.GetOrders @StartOrderDate='20160528';
