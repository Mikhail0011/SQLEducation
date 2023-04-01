USE localdb;

GO
CREATE TRIGGER dbo.TR_Basket_insert_update 
ON dbo.Basket
INSTEAD OF INSERT AS
BEGIN
	INSERT INTO dbo.Basket(ID_SKU, ID_Family, Quantity, "Value", PurchaseDate, DiscountValue)
	SELECT ID_SKU, ID_Family, Quantity, "Value", PurchaseDate, 
		   DiscountValue = 
			CASE WHEN ID_SKU IN (SELECT ID_SKU
								 FROM inserted
								 GROUP BY ID_SKU
							     HAVING COUNT(*) > 1)
				 THEN Value * 0.05
			ELSE 0
			END
		FROM inserted;
END;

