USE localdb;

GO

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase 
  @FamilySurName varchar(255)
AS 
BEGIN

	IF NOT EXISTS(SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName) 
		RAISERROR('No family found with this surname!', 10, 1)	
	ELSE 
		UPDATE dbo.Family
		SET BudgetValue = BudgetValue - (SELECT SUM(bskt."Value")
										 FROM dbo.Basket AS bskt
										 WHERE bskt.ID_Family = dbo.Family.ID)
		WHERE SurName = @FamilySurName;
END;