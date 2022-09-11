USE AdventureWorks;
GO

/*
-- SQL QUERY CHALLENGE --

Write a scalar valued user-defined function that will format a number as currency. Write a query
against the products table that will return the listprice in this format.

UDF: dbo.FormatAsCurrency
Parameters: @Number money
HINT: Use the FORMAT function =)

*/

ALTER FUNCTION dbo.FormatAsCurrency (@Number money)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @val varchar(50)
	SET @val = FORMAT(@Number, 'C', 'en-gb')
	RETURN @val
END
GO

SELECT Name as ProductName,
	   ListPrice,
	   dbo.FormatAsCurrency(ListPrice) as FormattedListPrice
FROM Production.Product
WHERE ListPrice > 0;