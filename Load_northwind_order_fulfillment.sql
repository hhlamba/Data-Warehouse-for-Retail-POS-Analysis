use ist722_hhlamba_dw
Go
;
print('Deleting')

delete from [northwind].[FactOrderFullfilment];
delete from [northwind].[DimEmployee] where EmployeeKey > 0;
delete from [northwind].[DimDate] where DateKey > 0;
delete from [northwind].[DimProduct] where ProductKey > 0;
delete from [northwind].[DimCustomer] where CustomerKey > 0;
delete from [northwind].[DimShipper] where ShipperKey > 0;
Go
;


print('Loading')


insert into [northwind].[DimEmployee]
(EmployeeID, EmployeeName, Title, Address, City, Region, PostalCode, Country, HomePhone, Extension)
select [EmployeeID]
, CONCAT([TitleOfCourtesy], ' ', [LastName],', ',  [FirstName]) AS EmployeeName
,  [Title]
,  [Address]
,  [City] 
,  case when [Region] is NULL then 'N/A' else Region end
,  [PostalCode]
,  [Country] 
,  [HomePhone] 
,  [Extension]
from ist722_hhlamba_stage.dbo.stgNorthwindEmployee;


insert into northwind.DimProduct
(ProductID, ProductName, Category)
select ProductID, ProductName, Category from ist722_hhlamba_stage.dbo.stgNorthwindProduct;


insert into northwind.DimCustomer
(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
select CustomerID, CompanyName, ContactName, ContactTitle, Address, City
, case when Region is NULL then 'N/A' else Region end
, case when PostalCode is NULL then 'N/A' else PostalCode end
, Country, Phone
, case when Fax is NULL then 'N/A' else Fax end
from ist722_hhlamba_stage.dbo.stgNorthwindCustomer;


insert into northwind.DimShipper
(ShipperID, CompanyName, Phone)
select ShipperID, CompanyName, Phone from ist722_hhlamba_stage.dbo.stgNorthwindShipper;

insert into northwind.DimDate
(DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
select DateKey, Convert(date, Date) as Date, FullDateUSA, DayOfWeekUSA as DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, Month as MonthOfYear, Quarter, QuarterName, Year, IsWeekday from ist722_hhlamba_stage.dbo.stgNorthwindDates;


/*
insert into northwind.FactSales
(ProductKey, CustomerKey, EmployeeKey, OrderDateKey, ShippedDateKey, OrderID, Quantity, UnitPrice, DiscountAmount,SoldAmount)
select ProductKey, CustomerKey, EmployeeKey
, case when OrderDate is NULL then -1 else ExternalSources2.dbo.getDateKey(OrderDate) end as OrderDateKey
, case when ShippedDate is NULL then -1 else ExternalSources2.dbo.getDateKey(ShippedDate) end as ShippedDateKey
, OrderID, Quantity, UnitPrice
, Round((Discount*UnitPrice),2) as DiscountAmount
, Round((Quantity *(1-Discount) * UnitPrice),2) as SoldAmount    
from ist722_hhlamba_stage.dbo.stgNorthwindFactSales  as F
JOIN northwind.DimProduct as P ON P.ProductID = F.ProductID
JOIN northwind.DimCustomer as C ON C.CustomerID = F.CustomerID
JOIN northwind.DimEmployee as E ON E.EmployeeID = F.EmployeeID
;
*/

insert into northwind.FactOrderFullfilment
(ProductKey, CustomerKey, ShipperKey ,EmployeeKey,OrderDateKey,ShippedDateKey, OrderID, Quantity,DaysElapsed)
select ProductKey, CustomerKey, ShipperKey ,EmployeeKey
, case when OrderDate is NULL then -1 else ExternalSources2.dbo.getDateKey(OrderDate) end as OrderDateKey
, case when ShippedDate is NULL then -1 else ExternalSources2.dbo.getDateKey(ShippedDate) end as ShippedDateKey
, OrderID, Quantity, DATEDIFF(d,OrderDate, ShippedDate) as DaysElapsed
from ist722_hhlamba_stage.dbo.stgNorthwindFactOrderFullfilment  as F
JOIN northwind.DimProduct as P ON P.ProductID = F.ProductID
JOIN northwind.DimCustomer as C ON C.CustomerID = F.CustomerID
JOIN northwind.DimEmployee as E ON E.EmployeeID = F.EmployeeID
JOIN northwind.DimShipper as S ON S.ShipperID = F.ShipVia
;
