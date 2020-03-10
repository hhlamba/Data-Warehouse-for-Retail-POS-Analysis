/****** Object:  Database ist722_hhlamba_dw    Script Date: 2/29/2020 1:29:54 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_hhlamba_dw
GO
CREATE DATABASE ist722_hhlamba_dw
GO
ALTER DATABASE ist722_hhlamba_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhlamba_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;


--FactSales
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactSales
--FactOrderFillfilment
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactOrderFullfilment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactOrderFullfilment
--Product
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimProduct
--Customer
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimCustomer
--Employee
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimEmployee') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimEmployee
--Shipper
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimShipper') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimShipper
--Date
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimDate 
;

/* Create table northwind.DimDate */
CREATE TABLE northwind.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  date   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekday]  bit  DEFAULT 0 NOT NULL
, CONSTRAINT [PK_northwind.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date dimension contains one row for every day, may also be rows for "hasn''t happened yet."', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
;
*/
INSERT INTO northwind.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)
;
/*
--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FullDateUSA', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuarterName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'String expression of the full date, eg MM/DD/YYYY', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week; Sunday = 1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter name eg. First', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'23-Nov-2004', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..365', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, …, 12', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'In the form: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
;
*/




/* Drop table northwind.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimProduct 
;

/* Create table northwind.DimProduct */
CREATE TABLE northwind.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName]  nvarchar(40)   NOT NULL
,  [Category]  nvarchar(15)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimProduct', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
;
*/
SET IDENTITY_INSERT northwind.DimProduct ON
;
INSERT INTO northwind.DimProduct (ProductKey, ProductID, ProductName, Category, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown ProductName', 'Unk Category', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimProduct OFF
;
/*
--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Category', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business Key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Product Name', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Category Name', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Chai', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Beverage', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Products', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Categories', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ProductID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ProductName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CategoryName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'Category'; 
;
*/




/* Drop table northwind.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimCustomer 
;

/* Create table northwind.DimCustomer */
CREATE TABLE northwind.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nchar(5)   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NOT NULL
,  [ContactTitle]  nvarchar(30)   NOT NULL
,  [Address]  nvarchar(60)   NOT NULL
,  [City]  nvarchar(15)   NOT NULL
,  [Region]  nvarchar(15)   NOT NULL
,  [PostalCode]  nvarchar(10)   NOT NULL
,  [Country]  nvarchar(15)   NOT NULL
,  [Phone]  nvarchar(24)   NOT NULL
,  [Fax]  nvarchar(24)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCustomer', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimCustomer
;*/

SET IDENTITY_INSERT northwind.DimCustomer ON
;
INSERT INTO northwind.DimCustomer (CustomerKey, CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'Unk CompanyName', 'Unk ContactName', 'Unk Title', 'Unk Address', 'Unk City', 'Unk Region', '99999', 'Unk Country', 'Unk Phone', 'Unk Fax', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimCustomer OFF
;
/*
--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Company Name', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Contact Name', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Contact Title', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Address', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Postal Code', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Phone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Fax', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business Key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the Company (Customer)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the Contact Person', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Title of the Contact Person', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Address of the Customer', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'City of the Customer', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Region Customer is located', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Postal code Customer is located', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Country Customer is located', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Phone Number of Customer', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Fax Number', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'ALFKI', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Alfreds Futterkiste', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Maria Anders', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sales Representative', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Obere Str. 57', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Berlin', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'NULL', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12209', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Germany', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'030-0074321', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'030-0076545', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Customers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CompanyName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ContactName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ContactTitle', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Address', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PostalCode', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Phone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Fax', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'ContactTitle'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Fax'; 
;
*/




/* Drop table northwind.DimEmployee */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimEmployee') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimEmployee 
;

/* Create table northwind.DimEmployee */
CREATE TABLE northwind.DimEmployee (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  int   NOT NULL
,  [EmployeeName]  nvarchar(55)   NOT NULL
,  [Title]  nvarchar(30)   NOT NULL
,  [Address]  nvarchar(60)   NOT NULL
,  [City]  nvarchar(15)   NOT NULL
,  [Region]  nvarchar(15)   NOT NULL
,  [PostalCode]  nvarchar(10)   NOT NULL
,  [Country]  nvarchar(15)   NOT NULL
,  [HomePhone]  nvarchar(24)   NOT NULL
,  [Extension]  nvarchar(4)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimEmployee] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimEmployee', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimEmployee
;
*/
SET IDENTITY_INSERT northwind.DimEmployee ON
;
INSERT INTO northwind.DimEmployee (EmployeeKey, EmployeeID, EmployeeName, Title, Address, City, Region, PostalCode, Country, HomePhone, Extension, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown EmployeeName', 'Unk', 'Unknown Address', 'Unknown City', 'Unknown Region', '99999', 'Unknown Country', 'Unknown HomePhone', 'Unk', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimEmployee OFF
;
/*
--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employee Name', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Title', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Address', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PostalCode', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HomePhone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Extension', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unique Identifier for Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Job Title of the Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Address of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'City of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Region of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Postal Code of the Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Country of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Home number of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Extension of Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Mr. Davolio, Nancy', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sales Representative', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'507 - 20th Ave. E.  Apt. 2A', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Seattle', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'WA', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'98122', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'USA', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'(206) 555-9857', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'5467', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'EmployeeID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TitleOfCourtesy + " " + LastName+ ", " + FirstName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Title', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Address', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'City', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PostalCode', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'HomePhone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Extension', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Address'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'City'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'HomePhone'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Extension'; 
;
*/




/* Drop table northwind.DimShipper */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimShipper') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimShipper 
;

/* Create table northwind.DimShipper */
CREATE TABLE northwind.DimShipper (
   [ShipperKey]  int IDENTITY  NOT NULL
,  [ShipperID]  int   NOT NULL
,  [CompanyName]  varchar(40)   NOT NULL
,  [Phone]  varchar(24)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NULL
,  [RowStartDate]  datetime   NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimShipper] PRIMARY KEY CLUSTERED 
( [ShipperKey] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimShipper
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimShipper', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimShipper
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimShipper
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimShipper
;
*/
SET IDENTITY_INSERT northwind.DimShipper ON
;
INSERT INTO northwind.DimShipper (ShipperKey, ShipperID, CompanyName, Phone, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown CompanyName', 'Unk Phone', 'Y', '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimShipper OFF
;
/*
--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank Dim Key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShipperID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CompanyName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Phone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business Key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always describe your columns', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Speedy Express', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'(503) 555-9831', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Shippers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Shippers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Shippers', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ShipperID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CompanyName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Phone', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'ShipperID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'CompanyName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimShipper', @level2type=N'COLUMN', @level2name=N'Phone'; 
;
*/




/* Drop table northwind.FactOrderFullfilment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactOrderFullfilment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactOrderFullfilment 
;

/* Create table northwind.FactOrderFullfilment */
CREATE TABLE northwind.FactOrderFullfilment (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [ShipperKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [Quantity]  int   NULL
,  [DaysElapsed]  int   NULL
, CONSTRAINT [PK_northwind.FactOrderFullfilment] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;
/*
--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactOrderFullfilment', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=FactOrderFullfilment
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=FactOrderFullfilment
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShipperKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShippedDateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DaysElapsed', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Product', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Shipper', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Employee', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date (for Orders)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date (for Shipped)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The natural key for the fact table, if any (eg order number)', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quanity of Product', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Days Elapsed', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20120108', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20120108', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1, 2, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1, 2, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1, 2, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1, 2, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShipperKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDetails', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDetails', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'OrderDetails', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ShippedDate-OrderDate', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'OrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'FactOrderFullfilment', @level2type=N'COLUMN', @level2name=N'DaysElapsed'; 
;
*/
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES northwind.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES northwind.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_ShipperKey FOREIGN KEY
   (
   ShipperKey
   ) REFERENCES northwind.DimShipper
   ( ShipperKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES northwind.DimEmployee
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactOrderFullfilment ADD CONSTRAINT
   FK_northwind_FactOrderFullfilment_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES northwind.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
