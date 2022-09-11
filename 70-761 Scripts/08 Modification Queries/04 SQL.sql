
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

1. Write an INSERT statement that adds a new customer category named BEST CATEGORY EVER.

2. Write an UPDATE statement that modifies customers in category 5 to the new category created above.

*/


INSERT INTO Sales.CustomerCategories
           (CustomerCategoryID
           ,CustomerCategoryName
           ,LastEditedBy)
     VALUES
           (DEFAULT
           ,'BEST CATEGORY EVER'
           ,1);
GO

UPDATE Sales.Customers
   SET CustomerCategoryID = 9
 WHERE CustomerCategoryID = 5;
GO



