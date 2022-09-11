
USE WideWorldImporters;
GO

-- pivot on customer category, aggregating quantity by year
SELECT * FROM
(
	SELECT cc.CustomerCategoryName, YEAR(OrderDate) AS OrderYear, ol.Quantity
	FROM Sales.Customers c
	JOIN Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
	JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
	JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
) src
PIVOT
(
	SUM(Quantity)
	FOR CustomerCategoryName IN ([Supermarket],[Novelty Shop],[Gift Store],[Computer Store],[Corporate])
) pvt;

-- pivot on order month, aggregating subtotal by year
SELECT * FROM
(
	SELECT YEAR(OrderDate) as OrderYear, MONTH(OrderDate) as OrderMonth, ol.PickedQuantity * ol.UnitPrice as SubTotal
	FROM Sales.Orders o
	JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
) src
PIVOT 
(
	SUM(SubTotal)
	FOR OrderMonth IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) pvt
ORDER BY OrderYear;


-- pivot on order month with friendly names, aggregating subtotal by year
SELECT * FROM
(
	SELECT YEAR(OrderDate) as OrderYear,
		   ol.PickedQuantity * ol.UnitPrice as SubTotal,
		   CASE MONTH(OrderDate) 
		   WHEN 1 THEN 'January'
		   WHEN 2 THEN 'February'
		   WHEN 3 THEN 'March'
		   WHEN 4 THEN 'April'
		   WHEN 5 THEN 'May'
		   WHEN 6 THEN 'June'
		   WHEN 7 THEN 'July'
		   WHEN 8 THEN 'August'
		   WHEN 9 THEN 'September'
		   WHEN 10 THEN 'October'
		   WHEN 11 THEN 'November'
		   WHEN 12 THEN 'December'
		   END as OrderMonth
	FROM Sales.Orders o
	JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
) src
PIVOT 
(
	SUM(SubTotal)
	FOR OrderMonth IN ([January],[February],[March],[April],[May],[June],[July],[August],[September],[October],[November],[December])
) pvt
ORDER BY OrderYear;


-- generate column headers using dynamic SQL
DECLARE @colSQL VARCHAR(MAX)
SELECT @colSQL = COALESCE(@colSQL + ',[' + CustomerCategoryName + ']','[' + CustomerCategoryName + ']')
FROM Sales.CustomerCategories
PRINT @colSQL

DECLARE @pvtSQL NVARCHAR(MAX)
SET @pvtSQL = N'
	SELECT * FROM
	(
		SELECT cc.CustomerCategoryName, YEAR(OrderDate) AS OrderYear, DATEPART(q, OrderDate) AS OrderQuarter, ol.Quantity
		FROM Sales.Customers c
		JOIN Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
		JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
		JOIN Sales.OrderLines ol ON o.OrderID = ol.OrderID
	) src
	PIVOT
	(
		SUM(Quantity)
		FOR CustomerCategoryName IN (' + @colSQL + ')
	) pvt'
		
EXECUTE(@pvtSQL)