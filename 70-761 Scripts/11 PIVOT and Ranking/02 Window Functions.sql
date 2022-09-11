
USE WideWorldImporters;
GO

-- standard aggregate function with GROUP BY
SELECT  c.CustomerID, 
		o.OrderID,
		SUM(ol.UnitPrice * ol.Quantity) as OrderTotal
FROM Sales.Customers c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
GROUP BY c.CustomerID, o.OrderID
ORDER BY OrderTotal DESC;

-- window aggregate functions with OVER
SELECT	c.CustomerID, 
		o.OrderID,
		ol.UnitPrice * ol.Quantity as SubTotal,
		SUM(ol.UnitPrice * ol.Quantity) OVER(PARTITION BY c.CustomerID, o.OrderID) as OrderTotal,
		SUM(ol.UnitPrice * ol.Quantity) OVER(PARTITION BY c.CustomerID) as CustomerTotal,
		SUM(ol.UnitPrice * ol.Quantity) OVER(PARTITION BY c.CustomerID
											 ORDER BY o.OrderID
											 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as CustomerRunningTotal,
		SUM(ol.UnitPrice * ol.Quantity) OVER() as GrandTotal
FROM Sales.Customers c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
ORDER BY c.CustomerID, o.OrderID;

-- window ranking functions with OVER
SELECT	c.CustomerID, 
		o.OrderID,
		ol.UnitPrice * ol.Quantity as SubTotal,
		ROW_NUMBER() OVER(ORDER BY ol.UnitPrice * ol.Quantity) as RowNumber,
		RANK()		 OVER(ORDER BY ol.UnitPrice * ol.Quantity) as Ranked,
		RANK()		 OVER(PARTITION BY o.CustomerID ORDER BY ol.UnitPrice * ol.Quantity) as CustomerRanked,
		DENSE_RANK() OVER(ORDER BY ol.UnitPrice * ol.Quantity) as DenseRank,
		NTILE(10)	 OVER(ORDER BY ol.UnitPrice * ol.Quantity) as ntile10
FROM Sales.Customers c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
ORDER BY o.CustomerID, Ranked;