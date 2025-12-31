TRUNCATE TABLE items_20250101_20250901;

BULK INSERT items_20250101_20250901
FROM 'items-2025-01-01-2026-01-01.csv'   -- path *inside* the container
WITH (
    DATA_SOURCE    = 'PigmentBlob',     -- <== important
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 -- skip header
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            -- line feed (recommended for Azure SQL)
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20241201_20250101;

BULK INSERT items_20241201_20250101
FROM 'items-2024-12-01-2025-01-01.csv'   
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20241101_20241201;

BULK INSERT items_20241101_20241201
FROM 'items-2024-11-01-2024-12-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20241001_20241101;

BULK INSERT items_20241001_20241101
FROM 'items-2024-10-01-2024-11-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240901_20241001;

BULK INSERT items_20240901_20241001
FROM 'items-2024-09-01-2024-10-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240801_20240901;

BULK INSERT items_20240801_20240901
FROM 'items-2024-08-01-2024-09-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240701_20240801;

BULK INSERT items_20240701_20240801
FROM 'items-2024-07-01-2024-08-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',    
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240601_20240701;

BULK INSERT items_20240601_20240701
FROM 'items-2024-06-01-2024-07-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240501_20240601;

BULK INSERT items_20240501_20240601
FROM 'items-2024-05-01-2024-06-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
TRUNCATE TABLE items_20240101_20240501;

BULK INSERT items_20240101_20240501
FROM 'items-2024-01-01-2024-05-01.csv'
WITH (
    DATA_SOURCE    = 'PigmentBlob',     
    FORMAT         = 'CSV',
    FIRSTROW       = 2,                 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0A',            
    CODEPAGE       = '65001',
    TABLOCK
);
GO
--------------------------------------------------------------------------------------
PRINT '------------------------------';
PRINT 'Combining All Items Data Into: pos_prd_sales';
PRINT '------------------------------';

TRUNCATE TABLE pos_prd_sales;

INSERT INTO pos_prd_sales 
SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20250101_20250901

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20241201_20250101

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20241101_20241201

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20241001_20241101

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20240901_20241001

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20240801_20240901

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE() 
FROM items_20240701_20240801

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20240601_20240701

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20240501_20240601

UNION ALL

SELECT
    [Date],
    [Time],
	[Category],
	[Item],
	[Qty],
	[Product Sales],
	[Discounts],
	[Net Sales],
	[Transaction ID],
	[Itemization Type],
	GETDATE()
FROM items_20240101_20240501
