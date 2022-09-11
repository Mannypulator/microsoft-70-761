
USE AdventureWorks;
GO

-- basic CTE
WITH BikeProducts_CTE  AS (
	SELECT p.*
	FROM Production.Product p
	JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	WHERE psc.Name LIKE '%bike%'
)

SELECT * FROM BikeProducts_CTE;


-- standard CTE
WITH SalesTotals_CTE (SalesPerson, TotalSales)
AS
(
	 SELECT SalesPersonID, ROUND(SUM(SubTotal), 2)
	 FROM Sales.SalesOrderHeader 
	 WHERE SalesPersonID IS NOT NULL
	 GROUP BY SalesPersonID
)

SELECT sp.FirstName, sp.LastName, TotalSales
FROM Sales.vSalesPerson sp
JOIN SalesTotals_CTE st ON sp.BusinessEntityID = st.SalesPerson
ORDER BY TotalSales DESC;


-- multiple CTEs
WITH Person_CTE (Person, FirstName, LastName)
AS (SELECT BusinessEntityID, FirstName, LastName FROM Person.Person),
Email_CTE (Person, EmailAddress)
AS (SELECT BusinessEntityID, EmailAddress FROM Person.EmailAddress)

SELECT FirstName, LastName, EmailAddress
FROM Person_CTE p
JOIN Email_CTE e ON p.Person = e.Person
WHERE FirstName LIKE 's%' AND LastName LIKE 's%';


-- recursive CTE
WITH Materials_CTE (ProductID, ProductName, Quantity, Level, Sort)
AS
(
	-- anchor member
	SELECT ProductID, CAST(Name AS VARCHAR(100)), 1, 1, CAST(Name as VARCHAR(100))
	FROM Production.Product p
	JOIN Production.BillOfMaterials bm ON p.ProductID = bm.ComponentID AND bm.ProductAssemblyID IS NULL

	UNION ALL

	-- recursive member
	SELECT 
		p.ProductID,
		CAST(REPLICATE('-->', cte.level) + p.Name AS VARCHAR(100)), 
		CAST(bm.PerAssemblyQty AS INT), 
		cte.Level + 1, 
		CAST(cte.Sort + '>' + p.Name AS VARCHAR(100))
	FROM Materials_CTE cte
	JOIN Production.BillOfMaterials bm ON bm.ProductAssemblyID = cte.ProductID
	JOIN Production.Product p ON bm.ComponentID = p.ProductID
)

SELECT * FROM Materials_CTE ORDER BY Sort;