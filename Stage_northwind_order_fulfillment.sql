use ist722_hhlamba_stage
Go
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindProduct

select ProductID, ProductName, CategoryName as 'Category'
INTO dbo.stgNorthwindProduct
from Northwind.dbo.Products as P JOIN Northwind.dbo.Categories as C
ON C.CategoryID = P.CategoryID;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindCustomer

select CustomerID,
CompanyName,
ContactName,
ContactTitle,
Address,
City,
Region,
PostalCode,
Country,
Phone,
Fax
INTO dbo.stgNorthwindCustomer
from Northwind.dbo.Customers;


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindEmployee') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindEmployee


select EmployeeID,
TitleOfCourtesy, LastName, FirstName,
Title,
Address,
City,
Region,
PostalCode,
Country,
HomePhone,
Extension
INTO dbo.stgNorthwindEmployee
from Northwind.dbo.Employees;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindShipper') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.stgNorthwindShipper

select ShipperID,
CompanyName,
Phone
INTO dbo.stgNorthwindShipper
from Northwind.dbo.Shippers;


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindDates') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP Table dbo.stgNorthwindDates;

select *
into dbo.stgNorthwindDates
From ExternalSources2.dbo.date_dimension
WHERE YEAR between 1996 and 1998;



IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.stgNorthwindFactOrderFullfilment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP Table dbo.stgNorthwindFactOrderFullfilment;

select ProductID, CustomerID, ShipVia, EmployeeID,OrderDate, ShippedDate, o.OrderID, Quantity 
into dbo.stgNorthwindFactOrderFullfilment
from Northwind.dbo.[Order Details] as od JOIN Northwind.dbo.Orders as o 
ON od.OrderID = o.OrderID;
