USE localdb;

GO
CREATE TRIGGER dbo.TR_Basket_insert_update 
ON dbo.Basket
INSTEAD OF INSERT AS
BEGIN
	INSERT INTO dbo.Basket(ID_SKU, ID_Family, Quantity, "Value", PurchaseDate, DiscountValue)
	SELECT ins.ID_SKU, ins.ID_Family, ins.Quantity, ins."Value", ins.PurchaseDate, 
			CASE WHEN ins1.ID_SKU IS NOT NULL
				 THEN Value * 0.05
			ELSE 0
			END AS DiscountValue
	  FROM inserted AS ins
	     LEFT JOIN (SELECT ID_SKU
			FROM inserted
			GROUP BY ID_SKU
			HAVING COUNT(*) > 1) AS ins1 ON ins1.ID_SKU = ins.ID_SKU;;
END;

