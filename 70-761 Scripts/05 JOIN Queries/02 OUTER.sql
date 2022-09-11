
USE WideWorldImporters;
GO

-- inner join : customers with both primary and alternate contacts
SELECT cust.CustomerName, pri.FullName as PrimaryContact, alt.FullName as AlternateContact
FROM Sales.Customers cust
JOIN Application.People pri ON cust.PrimaryContactPersonID = pri.PersonID
JOIN Application.People alt ON cust.AlternateContactPersonID = alt.PersonID;

-- left join : customers with a primary contact and with or without alternate contacts
SELECT cust.CustomerName, pri.FullName as PrimaryContact, alt.FullName as AlternateContact
FROM Sales.Customers cust
JOIN Application.People pri ON cust.PrimaryContactPersonID = pri.PersonID
LEFT JOIN Application.People alt ON cust.AlternateContactPersonID = alt.PersonID;

-- left join with NULL predicate : customers with a primary contact and without alternate contacts
SELECT cust.CustomerName, pri.FullName as PrimaryContact, alt.FullName as AlternateContact
FROM Sales.Customers cust
JOIN Application.People pri ON cust.PrimaryContactPersonID = pri.PersonID
LEFT JOIN Application.People alt ON cust.AlternateContactPersonID = alt.PersonID
WHERE cust.AlternateContactPersonID IS NULL;

-- right join : categories with or without customers
SELECT cust.CustomerName, cat.CustomerCategoryName
FROM Sales.Customers cust
RIGHT JOIN Sales.CustomerCategories cat ON cust.CustomerCategoryID = cat.CustomerCategoryID;

-- right join with NULL predicate : categories without customers
SELECT cat.CustomerCategoryName
FROM Sales.Customers cust
RIGHT JOIN Sales.CustomerCategories cat ON cust.CustomerCategoryID = cat.CustomerCategoryID
WHERE cust.CustomerName IS NULL;

-- full join : customers with or without categories and categories with or without customers
SELECT cust.CustomerName, cat.CustomerCategoryName
FROM Sales.Customers cust
FULL JOIN Sales.CustomerCategories cat ON cust.CustomerCategoryID = cat.CustomerCategoryID;

-- full join with NULL predicate : customers without categories and categories without customers
SELECT cust.CustomerName, cat.CustomerCategoryName
FROM Sales.Customers cust
FULL JOIN Sales.CustomerCategories cat ON cust.CustomerCategoryID = cat.CustomerCategoryID
WHERE cust.CustomerCategoryID IS NULL OR cat.CustomerCategoryID IS NULL;