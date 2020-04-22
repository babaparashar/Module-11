USE AdventureWorks2016;

Create Trigger TR_SalesOrderHeader_Insert
ON Sales.SalesOrderHeader
After Insert As Begin
IF Exists ( SELECT 1 FROM inserted AS i
WHERE i.SubTotal > 10000
AND i.PurchaseOrderNumber IS NULL
)
BEGIN
PRINT 'Orders above 10000 must have PO numbers';
ROLLBACK;           
END;
END;




INSERT INTO Sales.SalesOrderHeader 
(RevisionNumber, OrderDate, DueDate, Status,OnlineOrderFlag, PurchaseOrderNumber,CustomerID, SalespersonID, BillToAddressID, ShipToAddressID, ShipMethodID, SubTotal, TaxAmt, Freight)
VALUES (1, SYSDATETIME(), SYSDATETIME(), 1,1, 'ABC-123', 4, 274, 3, 3, 1, 10502, 12, 100);


INSERT INTO Sales.SalesOrderHeader 
(RevisionNumber, OrderDate, DueDate, Status, OnlineOrderFlag, PurchaseOrderNumber,CustomerID, SalespersonID, BillToAddressID, ShipToAddressID, ShipMethodID, SubTotal, TaxAmt, Freight)
VALUES (1, SYSDATETIME(), SYSDATETIME(), 1,1, NULL,4, 274, 3, 3,1, 8000, 12, 100);

INSERT INTO Sales.SalesOrderHeader 
(RevisionNumber, OrderDate, DueDate, Status,  OnlineOrderFlag, PurchaseOrderNumber,CustomerID, SalespersonID, BillToAddressID, ShipToAddressID, ShipMethodID, SubTotal, TaxAmt, Freight)
VALUES (1, SYSDATETIME(), SYSDATETIME(), 1,1, NULL,4, 274, 3, 3,1, 18000, 12, 100);


DROP TRIGGER Sales.TR_SalesOrderHeader_Insert;



DELETE soh 
FROM Sales.SalesOrderHeader AS soh
WHERE NOT EXISTS (SELECT 1FROM Sales.SalesOrderDetail AS sod 
WHERE soh.SalesOrderID = sod.SalesOrderID);



