
USE AdventureWorks2016;


SELECT * FROM Sales.SalesTerritoryHistory;



CREATE TRIGGER TR_SalesTerritoryHistory_Delete
ON Sales.SalesTerritoryHistory
AFTER DELETE AS BEGIN
IF EXISTS(SELECT 1
FROM deleted AS d
WHERE d.EndDate IS NULL) BEGIN
PRINT 'Current Sales Territory History rows cannot be deleted';
ROLLBACK;
END;
END;



SELECT * FROM Sales.SalesTerritoryHistory WHERE BusinessEntityID = 283;


DELETE FROM Sales.SalesTerritoryHistory 
WHERE BusinessEntityID = 283;



DROP TRIGGER Sales.TR_SalesTerritoryHistory_Delete;


