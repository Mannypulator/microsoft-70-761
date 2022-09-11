
USE AdventureWorks;
GO

/* logical functions -- CHOOSE & IIF */
SELECT JobTitle, HireDate, MONTH(HireDate) AS HireMonth,
		CHOOSE(MONTH(HireDate),
		'Winter','Winter','Winter',
		'Spring','Spring','Spring',
		'Summer','Summer','Summer',
		'Fall','Fall','Fall') AS HireSeason,
		IIF(Gender='F', 'Female', 'Male') AS Gender
FROM HumanResources.Employee
ORDER BY HireMonth;


/* conversion functions -- CAST & CONVERT */
SELECT 'Today''s date is ' + GETDATE();
SELECT 'Today''s date is ' + CAST(GETDATE() AS NVARCHAR);
SELECT 'Today''s date is ' + CONVERT(NVARCHAR, GETDATE(), 101);

 -- implicit
SELECT p.Name, pinv.Quantity, p.StandardCost, pinv.Quantity * p.StandardCost AS TotalCost
FROM Production.Product p
JOIN Production.ProductInventory pinv ON p.ProductID = pinv.ProductID
WHERE p.StandardCost > 0.00;

-- explicit
SELECT p.Name, pinv.Quantity AS OldQuantity, (pinv.Quantity * .5) AS OopsQuantity, CAST(pinv.Quantity * .5 AS SMALLINT) NewQuantity
FROM Production.Product p
JOIN Production.ProductInventory pinv ON p.ProductID = pinv.ProductID;


/* string functions */
-- LEFT & RIGHT
SELECT FirstName, LastName, LEFT(FirstName, 1) + LEFT(LastName, 1) as Initials
FROM Person.Person;

-- CHARINDEX & PATINDEX
SELECT DISTINCT City, CHARINDEX('city', City) as CityStartsAt, PATINDEX('%town%', City) as TownStartsAt
FROM Person.Address WHERE CHARINDEX('city', City) > 0 OR PATINDEX('%town%', City) > 0;

-- SUBSTRING, REPLACE, REVERSE
SELECT	ProductNumber, 
		LEFT(ProductNumber, 2) AS ProductCode,
		SUBSTRING(ProductNumber, CHARINDEX('-', ProductNumber, 0) + 1, 4) as PartialProductNumber,
		REPLACE(ProductNumber,'-','') as NewProductNumber,
		REVERSE(ProductNumber) as BackwardsProductNumber
FROM Production.Product;


/*  datetime functions */
-- DATENAME
SELECT DISTINCT	OrderDate, 
		DATENAME(YEAR, OrderDate) AS OrderYear, 
		DATENAME(MONTH, OrderDate) AS OrderMonth,
		DATENAME(WEEK, OrderDate) AS OrderWeek,
		DATENAME(DAY, OrderDate) AS OrderDay,
		DATENAME(DAYOFYEAR, OrderDate) AS OrderDayOfYear
FROM Sales.SalesOrderHeader;

-- DATEDIFF & DATEADD
SELECT LoginID, HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) YearsEmployed
FROM HumanResources.Employee
WHERE HireDate <=  DATEADD(YEAR, -5, GETDATE())
ORDER BY YearsEmployed DESC


/* system functions */
-- ISNULL
SELECT Name, ISNULL(Color, 'N/A') AS Color FROM Production.Product;

-- NEWID
SELECT NEWID();

-- SUSER_SNAME, USER_NAME, HOST_NAME
SELECT SUSER_SNAME() AS SystemUserName, USER_NAME() AS DatabaseUserName, HOST_NAME() AS MachineName;