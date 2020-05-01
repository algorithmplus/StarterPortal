-- IMPORTANT!!!
-- Pre-requisite for this script:
-- Before running this script the CSV file with data has to be loaded in a temporary table in the database:
--
--STEPS TO FOLLOW:
--
-- 1) Prepare the CSV with data to import
--      * Source CSV with up-to-date details
--      * Leave only the relevant columns (UKPRN and Org Trading Name)
--      * Remove column headers
--      * Remove trailing spaces in Org Trading Name (replace regexp \s+\n with \n)
--
-- 2) Create the table
-- CREATE TABLE pimsOrgsTemp (
--     UKPRN NVARCHAR(25),
--     name NVARCHAR(500)
-- );
--
-- 3) Import data from CSV (to be provided with the script)
-- bcp pimsOrgsTemp in C:\temp\PIMS.csv -S <server> -d s141d01-signin-organisations-db -U <username> -P <password> -q -c -t
--
-- 4) Run this script
--
-- 5) Delete temp table if all successful
-- DROP TABLE pimsOrgsTemp;



BEGIN TRANSACTION UPDATEPIMSORGS;

BEGIN TRY  

    SET NOCOUNT ON;

    --constant values
    DECLARE @orgCategory NVARCHAR(25) = '051';

    --table where we store the orgs that we are going to INSERT (UKPRN not already present)
    DECLARE @pimsOrgsInsert AS TABLE (
        UKPRN NVARCHAR(25),
        name NVARCHAR(500)
        );

    --Get UKPRN and name or all orgs that need to be INSERTED
    --using EXCEPT to compare only UKPRNs (as names might slightly differ)
    INSERT INTO @pimsOrgsInsert (UKPRN, name) 
        SELECT UKPRN, name FROM pimsOrgsTemp
            WHERE UKPRN IN (
                SELECT UKPRN   
                FROM pimsOrgsTemp
                EXCEPT  
                SELECT UKPRN from organisation WHERE UKPRN IS NOT NULL);

    --table where we store the orgs that need to be either INSERTED or UPDATED (not already present or present with different name)
    DECLARE @pimsOrgsInsertAndUpdate AS TABLE (
        UKPRN NVARCHAR(25),
        name NVARCHAR(500)
        );
    INSERT INTO @pimsOrgsInsertAndUpdate (UKPRN, name) 
        SELECT UKPRN, name FROM pimsOrgsTemp
            EXCEPT  
            SELECT UKPRN, Name from organisation WHERE UKPRN IS NOT NULL;

    --table where we store the orgs that need to be UPDATED (present with different name)
    DECLARE @pimsOrgsUpdate AS TABLE (
        UKPRN NVARCHAR(25),
        name NVARCHAR(500)
        );
    INSERT INTO @pimsOrgsUpdate (UKPRN, name) 
        SELECT UKPRN, name FROM @pimsOrgsInsertAndUpdate
            EXCEPT
            SELECT UKPRN, name FROM @pimsOrgsInsert;

    --variables to store the org data to insert (one by one using cursor)
    DECLARE @orgUKPRN NVARCHAR(25);
    DECLARE @orgName NVARCHAR(500);

    --counters for inserted, updated and processed rows
    DECLARE @insertedRows INT = 0;
    DECLARE @updatedRows INT = 0;
    DECLARE @processedRows INT = (SELECT COUNT(*) FROM pimsOrgsTemp);
    
    --INSERT new Orgs
    DECLARE db_cursor_orgs_insert CURSOR FOR SELECT UKPRN, Name FROM @pimsOrgsInsert;
    OPEN db_cursor_orgs_insert;
    FETCH NEXT FROM db_cursor_orgs_insert INTO @orgUKPRN, @orgName;

    WHILE @@FETCH_STATUS = 0

    BEGIN

        INSERT INTO organisation (id, name, category, ukprn, status, legacyId, createdAt, updatedAt)
            VALUES 
            (NEWID(), @orgName, @orgCategory, @orgUKPRN, 1, (NEXT VALUE FOR org_legacy_id_sequence), GETDATE(), GETDATE());
        --increment counter of inserted rows
        SET @insertedRows = @insertedRows + @@ROWCOUNT;

        PRINT 'Org with UKPRN ' + @orgUKPRN + ' added. Name: ' + @orgName;

        -- get next org
        FETCH NEXT FROM db_cursor_orgs_insert INTO @orgUKPRN, @orgName;
    END;

    CLOSE db_cursor_orgs_insert;
    DEALLOCATE db_cursor_orgs_insert;

    --UPDATE existing Orgs
    DECLARE db_cursor_orgs_update CURSOR FOR SELECT UKPRN, Name FROM @pimsOrgsUpdate;
    OPEN db_cursor_orgs_update;
    FETCH NEXT FROM db_cursor_orgs_update INTO @orgUKPRN, @orgName;

    WHILE @@FETCH_STATUS = 0

    BEGIN
        
        UPDATE organisation
            SET name = @orgName , updatedAt = GETDATE() WHERE UKPRN = @orgUKPRN
        --increment counter of updated rows
        SET @updatedRows = @updatedRows + @@ROWCOUNT;

        PRINT 'Org with UKPRN ' + @orgUKPRN + ' updated. New Name: ' + @orgName;

        -- get next org
        FETCH NEXT FROM db_cursor_orgs_update INTO @orgUKPRN, @orgName;
    END;

    CLOSE db_cursor_orgs_update;
    DEALLOCATE db_cursor_orgs_update;

    PRINT '*** Number of organisations added: ' + CAST(@insertedRows AS nvarchar(30));
    PRINT '*** Number of organisations updated with new name: ' + CAST(@updatedRows AS nvarchar(30));
    PRINT '*** From a total of ' + CAST(@processedRows AS nvarchar(30)) + ' records processed.';
        
    --Commit transaction if all went fine
    ROLLBACK TRAN UPDATEPIMSORGS;

END TRY

BEGIN CATCH

    SELECT
        ERROR_NUMBER() AS ErrorNumber  
        , ERROR_SEVERITY() AS ErrorSeverity  
        , ERROR_STATE() AS ErrorState  
        , ERROR_PROCEDURE() AS ErrorProcedure  
        , ERROR_LINE() AS ErrorLine  
        , ERROR_MESSAGE() AS ErrorMessage;  
     --Rollback if there was an error
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN UPDATEPIMSORGS;
END CATCH;