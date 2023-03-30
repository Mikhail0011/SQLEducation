USE localdb;

GO
CREATE TRIGGER dbo.TR_Basket_insert_update 
ON dbo.Basket
AFTER INSERT AS
BEGIN
	UPDATE dbo.Basket
	   SET DiscountValue = 
			CASE WHEN ID_SKU IN (SELECT ID_SKU
								 FROM inserted
								 GROUP BY ID_SKU
							     HAVING COUNT(*) > 1)
				 THEN Value * 0.05
			ELSE 0
			END
		WHERE ID_SKU IN (SELECT ID_SKU
						 FROM inserted);
END;