
USE WideWorldImporters;
GO

-- data types
CREATE TABLE Warehouse.DataTypes (
	DTID		UNIQUEIDENTIFIER	NOT NULL PRIMARY KEY,
	SomeFlag	BIT					NOT NULL DEFAULT 1,
	SomeNumber	INT					NULL,
	SomeNumber2	DECIMAL(10,2)		NULL,
	SomeData	NVARCHAR(10)		NULL,
	SomeDate	DATETIME			NOT NULL DEFAULT GETDATE()
);

INSERT Warehouse.DataTypes (DTID, SomeNumber, SomeNumber2, SomeData)
	VALUES (NEWID(), 7, 7.77, 'heyo!');

SELECT * FROM Warehouse.DataTypes;
DROP TABLE Warehouse.DataTypes;

-- conversion with TRY_CAST
SELECT 
	TRY_CAST('data' AS int) as Fail,
	CASE WHEN TRY_CAST('data' AS int) IS NULL
		THEN 'No..'
		ELSE 'Yes!'
	END as CaseFail,
	TRY_CAST('1/1/2018' AS datetime2) as Sucess,
	CASE WHEN TRY_CAST('1/1/2018' AS datetime2) IS NULL
		THEN 'No..'
		ELSE 'Yes!'
	END as CaseSuccess

-- conversion with TRY_PARSE
SELECT
	TRY_PARSE('$123.00' AS money USING 'en-gb') as Fail,
	TRY_PARSE('$123.00' AS money USING 'en-us') as Success,
	TRY_PARSE('Monday, 1 January 2018' AS datetime2) as DateTimeSuccess