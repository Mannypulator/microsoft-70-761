
USE AdventureWorks;
GO

-- FROM (290 records)
SELECT JobTitle, HireDate
FROM HumanResources.Employee;

-- WHERE (209 records)
SELECT JobTitle, HireDate
FROM HumanResources.Employee
WHERE YEAR(HireDate) >= 2009;

-- GROUP BY (63 records)
SELECT JobTitle, YEAR(HireDate) as YearHired, COUNT(*) as NumberOfEmployees
FROM HumanResources.Employee
WHERE YEAR(HireDate) >= 2009
GROUP BY JobTitle, YEAR(HireDate);

-- HAVING (34 records)
SELECT JobTitle, YEAR(HireDate) as YearHired, COUNT(*) as NumberOfEmployees
FROM HumanResources.Employee
WHERE YEAR(HireDate) >= 2009
GROUP BY JobTitle, YEAR(HireDate)
HAVING COUNT(*) > 1;

-- SELECT (34 records)

-- ORDER BY (34 records)
SELECT JobTitle, YEAR(HireDate) as YearHired, COUNT(*) as NumberOfEmployees
FROM HumanResources.Employee
WHERE YEAR(HireDate) >= 2009
GROUP BY JobTitle, YEAR(HireDate)
ORDER BY JobTitle, YearHired DESC;