
-- connect to AW database
USE AdventureWorks;
GO

-- return all employee records, all columns
SELECT * FROM HumanResources.Employee;

-- return all employee records, specific columns
SELECT LoginID, JobTitle, HireDate, VacationHours
FROM HumanResources.Employee;

-- return all employee records, specific columns, with an expression and alias
SELECT LoginID, JobTitle, HireDate, VacationHours, (VacationHours / 24) AS VacationDays
FROM HumanResources.Employee;

-- sort the results with ORDER BY in descending order
SELECT LoginID, JobTitle, HireDate, VacationHours, (VacationHours / 24) AS VacationDays
FROM HumanResources.Employee
ORDER BY JobTitle;

-- sort the results with ORDER BY in descending order
SELECT LoginID, JobTitle, HireDate, VacationHours, (VacationHours / 24) AS VacationDays
FROM HumanResources.Employee
ORDER BY VacationDays DESC;

-- limit the results with TOP
SELECT TOP 10 LoginID, JobTitle, HireDate, VacationHours, (VacationHours / 24) AS VacationDays
FROM HumanResources.Employee
ORDER BY VacationDays DESC;

-- remove duplicate records with DISTINCT
SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle;


