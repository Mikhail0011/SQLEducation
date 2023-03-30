USE localdb;

GO

CREATE VIEW vw_SKUPrice 
AS 
SELECT *, dbo.udf_GetSKUPrice(ID) as Price
FROM dbo.SKU