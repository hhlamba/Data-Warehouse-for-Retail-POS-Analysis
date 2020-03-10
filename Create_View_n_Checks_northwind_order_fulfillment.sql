use ist722_hhlamba_dw
Go
;
--Check Number of Records
select count(*)-1 from northwind.DimEmployee;
select count(*)-1 from northwind.DimProduct;
select count(*)-1 from northwind.DimCustomer;
select count(*)-1 from northwind.DimShipper;
select count(*)-1 from northwind.DimDate;
--select count(*) from northwind.FactSales;
select count(*) from northwind.FactOrderFullfilment;
GO

/*
DROP VIEW northwind.SalesMart
GO
;

CREATE VIEW northwind.SalesMart
AS
select 
P.ProductName,
F.Quantity, F.UnitPrice, F.DiscountAmount, F.SoldAmount,
C.CompanyName, C.ContactName, C.ContactTitle, C.City as 'Customer City', C.Region as 'Customer Region', C.PostalCode as 'Customer PostalCode', C.Country as 'Customer Country',
E.EmployeeName, E.Title, E.City as 'Employee City', E.Region  as 'Employee Region' , E.PostalCode as 'Employee PostalCode', E.Country as 'Employee Country'
from northwind.FactSales as F
JOIN northwind.DimEmployee as E ON E.EmployeeKey = F.EmployeeKey
JOIN northwind.DimProduct as P ON P.ProductKey = F.ProductKey
JOIN northwind.DimCustomer as C ON C.CustomerKey = F.CustomerKey;
GO
;

*/
DROP VIEW northwind.OrderFullfilmentMart
GO
;
CREATE VIEW northwind.OrderFullfilmentMart
AS
select
P.ProductName,
F.Quantity, F.DaysElapsed,
C.CompanyName, C.ContactName, C.ContactTitle, C.City as 'Customer City', C.Region as 'Customer Region', C.PostalCode as 'Customer PostalCode', C.Country as 'Customer Country',
S.CompanyName as 'Shipping Agency',
E.EmployeeName, E.Title, E.City as 'Employee City', E.Region  as 'Employee Region' , E.PostalCode as 'Employee PostalCode', E.Country as 'Employee Country'
from northwind.FactOrderFullfilment as F
JOIN northwind.DimEmployee as E ON E.EmployeeKey = F.EmployeeKey
JOIN northwind.DimProduct as P ON P.ProductKey = F.ProductKey
JOIN northwind.DimCustomer as C ON C.CustomerKey = F.CustomerKey
JOIN northwind.DimShipper as S ON S.ShipperKey = F.ShipperKey;