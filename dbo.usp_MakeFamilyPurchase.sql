USE localdb;

GO

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase 
  @FamilySurName varchar(255)
AS 
BEGIN
	DECLARE @valueSum DECIMAL(18,2);

	IF NOT EXISTS(SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName) 
		PRINT 'No family found with this surname!';	
	ELSE 	
		SELECT @valueSum = SUM(bskt."Value")
		FROM dbo.Basket AS bskt 
		INNER JOIN dbo.Family AS fml ON fml.ID = bskt.ID_Family
									AND fml.SurName = @FamilySurName;

		UPDATE dbo.Family
		SET BudgetValue = BudgetValue - @valueSum
		WHERE SurName = @FamilySurName;
END;
