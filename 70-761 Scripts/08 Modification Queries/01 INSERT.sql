
USE WideWorldImporters;
GO

-- INSERT VALUE - single record
INSERT INTO Application.People
			(FullName, PreferredName, IsPermittedToLogon, LogonName, IsExternalLogonProvider, IsSystemUser, IsEmployee, IsSalesperson, LastEditedBy)
     VALUES
			('Kylo Ren', 'Kylo', 1, 'kren@nuggetlab.com', 0, 1, 1, 0, 2);

-- INSERT VALUE - multiple records
INSERT INTO Application.People
			(FullName, PreferredName, IsPermittedToLogon, LogonName, IsExternalLogonProvider, IsSystemUser, IsEmployee, IsSalesperson, LastEditedBy)
     VALUES
			('Han Solo', 'Han', 1, 'hsolo@nuggetlab.com', 0, 1, 1, 0, 2),
			('Luke Skywalker', 'Luke', 1, 'lskywalker@nuggetlab.com', 0, 1, 1, 0, 2),
			('Leia Organa', 'Leia', 1, 'lorgana@nuggetlab.com', 0, 1, 1, 0, 2);

-- INSERT SELECT
INSERT dbo.CustomerStuff
SELECT	c.CustomerID, 
		LEFT(c.CustomerName, CHARINDEX(' ', c.CustomerName) - 1) AS FirstName,
		SUBSTRING(c.CustomerName, CHARINDEX(' ', c.CustomerName) + 1, 100) AS LastName,
		CityName,
		StateProvinceName,
		DeliveryMethodName,
		DeliveryAddressLine1,
		DeliveryAddressLine2,
		DeliveryPostalCode
FROM Sales.Customers c
JOIN Application.Cities ci ON c.DeliveryCityID = ci.CityID
JOIN Application.StateProvinces sp ON ci.StateProvinceID = sp.StateProvinceID
JOIN Application.DeliveryMethods dm ON c.DeliveryMethodID = dm.DeliveryMethodID
WHERE BuyingGroupID IS NULL;

-- SELECT INTO
SELECT	c.CustomerID, 
		LEFT(c.CustomerName, CHARINDEX(' ', c.CustomerName) - 1) AS FirstName,
		SUBSTRING(c.CustomerName, CHARINDEX(' ', c.CustomerName) + 1, 100) AS LastName,
		CityName,
		StateProvinceName,
		DeliveryMethodName,
		DeliveryAddressLine1,
		DeliveryAddressLine2,
		DeliveryPostalCode
INTO CustomerStuff_v2
FROM Sales.Customers c
JOIN Application.Cities ci ON c.DeliveryCityID = ci.CityID
JOIN Application.StateProvinces sp ON ci.StateProvinceID = sp.StateProvinceID
JOIN Application.DeliveryMethods dm ON c.DeliveryMethodID = dm.DeliveryMethodID
WHERE BuyingGroupID IS NULL;

TRUNCATE TABLE CustomerStuff

-- INSERT EXEC
INSERT dbo.CustomerStuff
EXEC Warehouse.SearchForCustomers 'ar', 20;