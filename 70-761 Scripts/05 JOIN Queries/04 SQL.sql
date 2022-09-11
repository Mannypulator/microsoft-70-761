
USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Write a query that returns employee and personal information.

Tables: HumanResources.Employee, Person.Person, Person.EmailAddress
Columns: FirstName, LastName, JobTitle, HireDate, EmailAddress

*/

SELECT p.FirstName, p.LastName, emp.JobTitle, emp.HireDate, ea.EmailAddress
FROM HumanResources.Employee emp
JOIN Person.Person p ON emp.BusinessEntityID = p.BusinessEntityID
JOIN Person.EmailAddress ea ON emp.BusinessEntityID = ea.BusinessEntityID;