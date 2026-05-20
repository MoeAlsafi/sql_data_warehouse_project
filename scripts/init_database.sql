USE master 
GO

-- Drop and recreate 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWharehouse SET SINGLER_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse


USE DataWarehouse
GO

-- Create schemas
Create SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
