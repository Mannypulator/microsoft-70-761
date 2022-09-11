
USE WideWorldImporters;
GO

-- query and transform JSON data using JSON_VALUE
SELECT	FullName, 
		UserPreferences,
		JSON_VALUE(UserPreferences,'$.theme') AS AppTheme,
		JSON_VALUE(UserPreferences,'$.timeZone') AS TimeZone
FROM Application.People
WHERE ISJSON(UserPreferences) > 0 AND JSON_VALUE(UserPreferences,'$.timeZone') = 'PST'
ORDER BY JSON_VALUE(UserPreferences,'$.theme')

-- transform relational data to JSON
SELECT	PersonID AS "id", 
		FullName AS "person.name", 
		EmailAddress AS "person.emailAddress" ,
		IsEmployee AS "system.isEmployee",
		IsSalesperson AS "system.isSalesPerson"
FROM Application.People
WHERE EmailAddress IS NOT NULL
FOR JSON PATH;

-- import JSON data
DECLARE @json NVARCHAR(MAX)
SET @json = N'[
	{
	  "id":1,
	  "person":{ 
	    "fullName":"Luke Sykwalker",
	    "emailAddress":"lskywalker@wideworldimporters.com",
		"phoneNumber":"8001111111"
	  },
	  "system":{
	    "isEmployee":true,
		"isSales":false
		}
	},
	{
	  "id":2,
	  "person":{
	    "fullName":"Darth Vader",
	    "emailAddress":"dvader@wideworldimporters.com",
		"phoneNumber":"8009999999"
	  },
	  "system":{
	    "isEmployee":true,
		"isSales":true
	    }
	 }]'

SELECT *
FROM OPENJSON(@json)
WITH
(
	PersonID int				'$.id',
	FullName nvarchar(100)		'$.person.fullName',
	EmailAddress nvarchar(100)	'$.person.emailAddress',
	PhoneNumber nvarchar(10)	'$.person.phoneNumber',
	IsEmployee bit				'$.system.isEmployee',
	IsSales bit					'$.system.isSales'
);