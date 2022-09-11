
USE AdventureWorks;
GO

-- JOIN vs. APPLY
SELECT ProductID, p.Name as ProductName, psc.Name as SubCategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID;

SELECT ProductID, p.Name as ProductName, psc.Name as SubCategoryName
FROM Production.Product p
CROSS APPLY (SELECT * FROM Production.ProductSubcategory psc WHERE p.ProductSubcategoryID = psc.ProductSubcategoryID) psc;
GO

-- Table-valued User-defined Function
CREATE FUNCTION dbo.GetSubCategory(@subcat int)
RETURNS TABLE 
AS
RETURN (
	SELECT * FROM Production.ProductSubcategory WHERE ProductSubcategoryID = @subcat
)
GO

SELECT * FROM dbo.GetSubCategory(1);


-- JOIN (fail)
SELECT * 
FROM Production.Product p
JOIN dbo.GetSubCategory(1) psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID;

-- CROSS APPLY
SELECT * 
FROM Production.Product p
CROSS APPLY dbo.GetSubCategory(p.ProductSubcategoryID) psc;

-- OUTER APPLY
SELECT * 
FROM Production.Product p
OUTER APPLY dbo.GetSubCategory(p.ProductSubcategoryID) psc;