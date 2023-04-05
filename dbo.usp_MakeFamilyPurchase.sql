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
		SET BudgetValue = BudgetValue - bskt.famSum
		FROM dbo.Family fml
			INNER JOIN (SELECT ID_Family, SUM("Value") famSum
						FROM dbo.Basket
						GROUP BY ID_Family) AS bskt ON bskt.ID_Family = fml.ID
		WHERE fml.SurName = @FamilySurName;
END;