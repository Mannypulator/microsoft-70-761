
USE WideWorldImporters;
GO

/*
-- SQL QUERY CHALLENGE --

Write a query to pull StockItems that were manufactured in Japan for Adults.

Columns: StockItemName, Size, RecommendedRetailPrice
Table: Warehouse.StockItems

BONUS: Output the results as XML formatted as the following:

<StockItems>
  <Item Size="">
    <Name></Name>
    <RecommendedRetailPrice></RecommendedRetailPrice>
    <Country></Country>
  </Item>
</StockItems>

*/

SELECT	Size,
		StockItemName, 
		RecommendedRetailPrice,
		JSON_VALUE(CustomFields,'$.CountryOfManufacture') AS Country
FROM Warehouse.StockItems
WHERE JSON_VALUE(CustomFields,'$.CountryOfManufacture') = 'China'
		AND 
	  JSON_VALUE(CustomFields,'$.Range') = 'Adult';

-- BONUS
SELECT	Size AS "@Size",
		StockItemName AS "Name", 
		RecommendedRetailPrice,
		JSON_VALUE(CustomFields,'$.CountryOfManufacture') AS Country
FROM Warehouse.StockItems
WHERE JSON_VALUE(CustomFields,'$.CountryOfManufacture') = 'China'
		AND 
	  JSON_VALUE(CustomFields,'$.Range') = 'Adult'
FOR XML PATH ('Item'), ROOT ('StockItems');