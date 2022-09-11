
USE AdventureWorks;
GO

-- Not SARG-able :(
SELECT SalesOrderID, OrderDate, DATEDIFF(YEAR, OrderDate, GETDATE()) as OrderAgeYears
FROM Sales.SalesOrderHeader
WHERE DATEDIFF(YEAR, OrderDate, GETDATE()) >= 5;

--SARG-able! :)
SELECT SalesOrderID, OrderDate, DATEDIFF(YEAR, OrderDate, GETDATE())as  OrderAgeYears
FROM Sales.SalesOrderHeader
WHERE OrderDate <= DATEADD(YEAR, -5, GETDATE());


-- Not SARG-able :(
SELECT FirstName, LastName
FROM Person.Person
WHERE CHARINDEX('pow', LastName) > 0;

--SARG-able! :)
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE LastName LIKE 'pow%';