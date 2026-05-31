-- EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '====================================';
        PRINT 'load bronze layer'
        PRINT '====================================';
        
        PRINT '-------------------------------------';
        PRINT 'Loading CRM'
        PRINT '-------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM '/tmp/datasets/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM '/tmp/datasets/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------'    ;


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM '/tmp/datasets/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------';


        PRINT '-------------------------------------';
        PRINT 'Loading ERP';
        PRINT '-------------------------------------';
        
        
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_CUST_AZ12';
        TRUNCATE TABLE bronze.erp_CUST_AZ12;
        BULK INSERT bronze.erp_CUST_AZ12
        FROM '/tmp/datasets/source_erp/CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM '/tmp/datasets/source_erp/loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2';
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM '/tmp/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '----------------------------------------------------';
        

        SET @batch_end_time = GETDATE();
        PRINT'===========================================';
        PRINT'Bronze Layer Completed';
        PRINT'  - Total Load duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT'===========================================';

                
    END TRY
    BEGIN CATCH
        PRINT '=======================================';
        PRINT 'Error During loading bronze layer';
        PRINT 'Error messsage' + ERROR_Message();
        PRINT 'Error messsage' + CAST(ERROR_NUMBER() AS NVARCHAR)
        
        PRINT '=======================================';
    END CATCH
END


