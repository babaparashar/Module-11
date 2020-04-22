USE tempdb;



CREATE TABLE dbo.CurrentPrice
(
	CurrentPriceID int IDENTITY(1,1) 
	  CONSTRAINT PK_CurrentPrice PRIMARY KEY,
	SellingPrice decimal(18,2) NOT NULL,
	LastModified datetime2 NOT NULL
	  CONSTRAINT DF_CurrentPrice_LastModified
	  DEFAULT (SYSDATETIME()),
	ModifiedBy sysname NOT NULL
	  CONSTRAINT DF_CurrentPrice_ModifiedBy
	  DEFAULT (ORIGINAL_LOGIN())
);




INSERT INTO dbo.CurrentPrice 
  (SellingPrice)
  VALUES (2.3), (4.3), (5);



SELECT * FROM dbo.CurrentPrice;

  

UPDATE dbo.CurrentPrice 
SET SellingPrice = 10 
WHERE CurrentPriceID = 2;




SELECT * FROM dbo.CurrentPrice;



CREATE TRIGGER TR_CurrentPrice_Update
ON dbo.CurrentPrice
AFTER UPDATE AS BEGIN
  SET NOCOUNT ON;
  UPDATE cp
  SET cp.LastModified = SYSDATETIME(),
      cp.ModifiedBy = ORIGINAL_LOGIN()
  FROM dbo.CurrentPrice AS cp
  INNER JOIN inserted AS i
  ON cp.CurrentPriceID = i.CurrentPriceID;
END;




UPDATE dbo.CurrentPrice 
SET SellingPrice = 20 
WHERE CurrentPriceID = 2;

SELECT * FROM dbo.CurrentPrice;





SELECT * FROM sys.triggers;


DROP TABLE dbo.CurrentPrice;





SELECT * FROM sys.triggers;

