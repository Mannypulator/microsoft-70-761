USE AdventureWorks;
GO

-- create a view
CREATE VIEW Sales.vSalesByTerritory
AS
	SELECT st.[Name] as TerritoryName, 
		   st.[Group] as TerritoryRegion, 
		   soh.SubTotal,
		   soh.TaxTotal,
		   soh.TotalDue
	FROM Sales.SalesTerritory st
	JOIN (SELECT TerritoryID, SUM(SubTotal) as SubTotal, SUM(TaxAmt) as TaxTotal, SUM(TotalDue) as TotalDue
		  FROM Sales.SalesOrderHeader
		  GROUP BY TerritoryID) soh ON st.TerritoryID = soh.TerritoryID;
GO

-- use the view
SELECT * FROM Sales.vSalesByTerritory ORDER BY TotalDue DESC;
GO

-- modify a view
ALTER VIEW Sales.vSalesByTerritory
AS
	SELECT st.[Name] as TerritoryName, 
		   st.[Group] as TerritoryRegion, 
		   st.CountryRegionCode,
		   soh.SubTotal,
		   soh.TaxTotal,
		   soh.TotalDue,
		   soh.NumOfOrders
	FROM Sales.SalesTerritory st
	JOIN (SELECT TerritoryID, SUM(SubTotal) as SubTotal, SUM(TaxAmt) as TaxTotal, SUM(TotalDue) as TotalDue, COUNT(*) NumOfOrders
		  FROM Sales.SalesOrderHeader
		  GROUP BY TerritoryID) soh ON st.TerritoryID = soh.TerritoryID;
GO

-- use the view
SELECT * FROM Sales.vSalesByTerritory 
WHERE CountryRegionCode = 'US' AND NumOfOrders > 1000
ORDER BY TerritoryName;
GO

-- add the SCHEMABINDING option to prevent underlying table changes
ALTER VIEW Sales.vSalesByTerritory
WITH SCHEMABINDING
AS
	SELECT st.TerritoryID,
		   st.[Name] as TerritoryName, 
		   st.[Group] as TerritoryRegion, 
		   st.CountryRegionCode,
		   soh.SubTotal,
		   soh.TaxTotal,
		   soh.TotalDue,
		   soh.NumOfOrders
	FROM Sales.SalesTerritory st
	JOIN (SELECT TerritoryID, SUM(SubTotal) as SubTotal, SUM(TaxAmt) as TaxTotal, SUM(TotalDue) as TotalDue, COUNT(*) NumOfOrders
		  FROM Sales.SalesOrderHeader
		  GROUP BY TerritoryID) soh ON st.TerritoryID = soh.TerritoryID;
GO

-- create clustered index (fail)
CREATE UNIQUE CLUSTERED INDEX cidx_tid ON Sales.vSalesByTerritory (TerritoryID);
GO

--re-write query to support indexed view
ALTER VIEW Sales.vSalesByTerritory
WITH SCHEMABINDING
AS

	SELECT st.TerritoryID, 
		   [Name] as TerritoryName, 
		   [Group] as TerritoryRegion, 
		   CountryRegionCode,
		   SUM(SubTotal) as SubTotal, 
		   SUM(TaxAmt) as TaxTotal, 
		   SUM(TotalDue) as TotalDue,
		   COUNT_BIG(*) NumOfOrders
	FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
	GROUP BY st.TerritoryID, [Name], [Group], CountryRegionCode;
GO

-- create clustered index (success!)
CREATE UNIQUE CLUSTERED INDEX cidx_tid ON Sales.vSalesByTerritory(TerritoryID);
GO

-- add additional non-clustered index
CREATE NONCLUSTERED INDEX idx_tname ON Sales.vSalesByTerritory(TerritoryName);
GO

-- use the view
SELECT * FROM Sales.vSalesByTerritory 
WHERE CountryRegionCode = 'US' AND NumOfOrders > 1000
ORDER BY TerritoryName;