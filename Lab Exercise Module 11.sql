USE AdventureWorks2016


CREATE TABLE Production.ProductAudit(
ProductId int Not Null,
UpdateTime datetime2(7) Not Null,
ModifyingUser nvarchar(100) Not Null,
OriginalListPrice money Not Null,
NewListPrice money Not Null
)




Create Trigger Production.TR_ProductListPrice
ON Production.Product
After Update
As begin
Set Nocount On;
Insert Production.ProductAudit(ProductId, UpdateTime, ModifyingUser, OriginalListPrice, NewListPrice)
Select Inserted.ProductId, Sysdatetime(), Original_Login(), deleted.ListPrice, inserted.ListPrice
From deleted
Inner Join inserted
ON deleted.ProductID = inserted.ProductID
Where deleted.ListPrice > 1000 or inserted.ListPrice > 1000;
End



Update Production.Product
Set ListPrice=5000.00
Where ProductID Between 500 and 550;


SELECT * FROM Production.ProductAudit



USE MarketDev

Alter Trigger Marketing.TR_CampaignBalance_Update
ON Marketing.CampaignBalance
After Update
As Begin
Set Nocount On;
Insert Marketing.CampaignAudit
(AuditTime, ModifyingUser, RemainingBalance)
Select Sysdatetime(), Original_Login(),
inserted.RemainingBalance
From deleted Inner Join inserted
ON deleted.CampaignID = inserted.CampaignID 
Where ABS(deleted.RemainingBalance  - inserted.RemainingBalance) > 10000;
End



SELECT * FROM Marketing.CampaignAudit
