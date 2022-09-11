USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

The WHERE clause in following stored procedure is broken, fix it!

*/


ALTER PROCEDURE Sales.GetPersons
	@FirstName	nvarchar(50) = NULL,
	@LastName	nvarchar(50) = NULL
AS

	SELECT FirstName, LastName, Title
	FROM Person.Person 
	WHERE FirstName LIKE @FirstName + '%'
			AND
		  LastName LIKE @LastName + '%';
GO

EXEC Sales.GetPersons 'r','a';
EXEC Sales.GetPersons @FirstName='r';
EXEC Sales.GetPersons @LastName='a';