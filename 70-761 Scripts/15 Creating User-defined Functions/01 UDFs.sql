
USE WideWorldImporters;
GO

--scalar udf
CREATE FUNCTION Warehouse.GetItemTransactionCount(@StockItemID int)  
RETURNS int
AS
BEGIN      
	DECLARE @ret int;
	      
	SELECT @ret = COUNT(*)       
	FROM Warehouse.StockItemTransactions       
	WHERE StockItemID = @StockItemID

	SET @ret = ISNULL(@ret, 0)

	RETURN @ret; 
END;  
GO  

-- query
SELECT StockItemName, Warehouse.GetItemTransactionCount(StockItemID) as Transactions
FROM Warehouse.StockItems
WHERE IsChillerStock = 1
ORDER BY Transactions DESC;
GO


--itvf udf 
CREATE FUNCTION Sales.GetOrdersByCustomer(@CustomerID int)
RETURNS TABLE
AS
RETURN
(
	SELECT o.OrderID, CustomerID, StockItemID, Quantity, OrderDate
	FROM Sales.Orders o
	JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
	WHERE CustomerID = @CustomerID 
);
GO

-- query
SELECT * FROM Sales.GetOrdersByCustomer(2);
GO


-- mstvf udf
CREATE FUNCTION Sales.GetTopCustomersByCategory(@CategoryID int = 0, @Top int)
RETURNS @tbl TABLE
(
	CustomerID INT NOT NULL,
	CustomerName nvarchar(100) NOT NULL,
	CategoryName nvarchar(50) NOT NULL,
	NumberOfSales INT NOT NULL,
	INDEX cidx_cid CLUSTERED(CustomerID)
)
WITH SCHEMABINDING
AS
BEGIN
	IF @CategoryID = 0
		BEGIN
			INSERT @tbl
			SELECT TOP (@Top)
				c.CustomerID,
				CustomerName,
				CustomerCategoryName,
				COUNT(*) as NumberOfSales
			FROM Sales.Customers c
			JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
			JOIN Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
		GROUP BY c.CustomerID, CustomerName, CustomerCategoryName
		ORDER BY NumberOfSales DESC
		END
	ELSE
		BEGIN
			INSERT @tbl
			SELECT TOP (@Top)
				c.CustomerID,
				CustomerName,
				CustomerCategoryName,
				COUNT(*) as NumberOfSales
			FROM Sales.Customers c
			JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
			JOIN Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
		WHERE c.CustomerCategoryID = @CategoryID
		GROUP BY c.CustomerID, CustomerName, CustomerCategoryName
		ORDER BY NumberOfSales DESC
		END

	RETURN
END
GO

-- queries
SELECT * FROM Sales.GetTopCustomersByCategory(default, 10);
SELECT * FROM Sales.GetTopCustomersByCategory(3, 5);