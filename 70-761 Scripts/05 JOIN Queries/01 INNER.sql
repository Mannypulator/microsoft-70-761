
USE WideWorldImporters;
GO

-- inner join : customers with categories
SELECT cust.CustomerName, cat.CustomerCategoryName
FROM Sales.Customers cust
JOIN Sales.CustomerCategories cat ON cust.CustomerCategoryID = cat.CustomerCategoryID;

-- inner join (old-school) : customers with categories
SELECT cust.CustomerName, cat.CustomerCategoryName
FROM Sales.Customers cust, Sales.CustomerCategories cat
WHERE cust.CustomerCategoryID = cat.CustomerCategoryID;


USE AdventureWorks;
GO

-- multiple joins : products with a subcategory, category, and inventory
SELECT p.Name, psub.Name AS Subcategory, pcat.Name AS Category, pinv.Quantity
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory AS psub ON p.ProductSubcategoryID = psub.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pcat ON psub.ProductCategoryID = pcat.ProductCategoryID
INNER JOIN Production.ProductInventory AS pinv ON p.ProductID = pinv.ProductID;

-- multiple join conditions : sales orders and special offers
SELECT sod.SalesOrderID, p.Name AS ProductName, so.Description AS SpecialOffer
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Sales.SpecialOfferProduct AS sop ON sod.ProductID = sop.ProductID AND sod.SpecialOfferID = sop.SpecialOfferID
INNER JOIN Production.Product AS p ON sop.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer so ON sop.SpecialOfferID = so.SpecialOfferID
WHERE so.SpecialOfferID <> 1;
