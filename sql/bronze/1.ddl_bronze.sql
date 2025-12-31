/*
===============================================================================
DDL: Create Bronze Tables
===============================================================================
Purpose:
    Creates (or re-creates) tables in the 'bronze' schema.

Notes:
    - Run this script to define or refresh the Bronze table structures.
    - Bronze table names must match the corresponding data file names
      in the Azure Blob Storage container to support straightforward imports.
===============================================================================
*/

IF OBJECT_ID('pos_prd_sales') IS NOT NULL
    DROP TABLE pos_prd_sales;
GO
CREATE TABLE pos_prd_sales (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50),
	updated_at Datetime2
);
GO

IF OBJECT_ID('items_20250101_20250901') IS NOT NULL
    DROP TABLE items_20250101_20250901;
GO
CREATE TABLE items_20250101_20250901 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20241201_20250101') IS NOT NULL
    DROP TABLE items_20241201_20250101;
GO
CREATE TABLE items_20241201_20250101 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20241101_20241201') IS NOT NULL
    DROP TABLE items_20241101_20241201;
GO
CREATE TABLE items_20241101_20241201 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20241001_20241101') IS NOT NULL
    DROP TABLE items_20241001_20241101;
GO
CREATE TABLE items_20241001_20241101 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240901_20241001') IS NOT NULL
    DROP TABLE items_20240901_20241001;
GO
CREATE TABLE items_20240901_20241001 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240801_20240901') IS NOT NULL
    DROP TABLE items_20240801_20240901;
GO
CREATE TABLE items_20240801_20240901 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240701_20240801') IS NOT NULL
    DROP TABLE items_20240701_20240801;
GO
CREATE TABLE items_20240701_20240801 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240601_20240701') IS NOT NULL
    DROP TABLE items_20240601_20240701;
GO
CREATE TABLE items_20240601_20240701 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240501_20240601') IS NOT NULL
    DROP TABLE items_20240501_20240601;
GO
CREATE TABLE items_20240501_20240601 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO

IF OBJECT_ID('items_20240101_20240501') IS NOT NULL
    DROP TABLE items_20240101_20240501;
GO
CREATE TABLE items_20240101_20240501 (
    [Date] NVARCHAR(50),
    [Time] NVARCHAR(50),
    [Category] NVARCHAR(100),
    [Item] NVARCHAR(255),
    [Qty] NVARCHAR(50),
    [Product Sales] NVARCHAR(50),
    [Discounts] NVARCHAR(50),
    [Net Sales] NVARCHAR(50),
	[Transaction ID] NVARCHAR(100),
    [Itemization Type] NVARCHAR(50)
);
GO


