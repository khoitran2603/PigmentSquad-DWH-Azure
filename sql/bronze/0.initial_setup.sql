-- Check current database
SELECT DB_NAME() AS current_database;
GO


-- Create master key (run once per database)
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '*******';
GO


-- Create credential using SAS token
-- SAS token is generated from:
-- Azure Portal → Storage Account → Containers → source → Shared access tokens
ALTER DATABASE SCOPED CREDENTIAL PigmentBlobCred
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
     SECRET   = '******';
GO


-- Register Blob Storage location for data import
CREATE EXTERNAL DATA SOURCE PigmentBlob
WITH (
    TYPE = BLOB_STORAGE,
    LOCATION = 'https://storagepigments.blob.core.windows.net/source',
    CREDENTIAL = PigmentBlobCred
);
GO
