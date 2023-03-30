USE localdb;

GO

CREATE FUNCTION dbo.udf_GetSKUPrice (@ID_SKU INT)
    RETURNS DECIMAL(18, 2)
BEGIN
	DECLARE @price DECIMAL(18,2);

	SELECT @price = SUM ("Value") / SUM (Quantity) 
	FROM dbo.Basket 
	WHERE ID_SKU = @ID_SKU;

	RETURN @price;
END;