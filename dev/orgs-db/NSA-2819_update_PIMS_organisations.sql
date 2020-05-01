-- IMPORTANT!!!
-- Pre-requisites for this script:

-- Before running this script the CSV file with data has to be loaded in a temporary table in the database:
--
-- 1) Create the table
-- CREATE TABLE pimsOrgsTemp (
--     UKPRN NVARCHAR(25),
--     name NVARCHAR(500)
-- );
--
-- 2) Import data from CSV (to be provided with the script)
-- bcp pimsOrgsTemp in C:\temp\PIMS.csv -S <server> -d s141d01-signin-organisations-db -U <username> -P <password> -q -c -t
--
-- 3) Run this script
--
-- 4) Delete temp table if all successful
-- DROP TABLE pimsOrgsTemp;



BEGIN TRANSACTION UPDATEPIMSORGS;

BEGIN TRY  

    SET NOCOUNT ON;

    --constant values
    DECLARE @orgCategory NVARCHAR(25) = '051';

    --table where we store the orgs data that we are going to import
    DECLARE @pimsOrgs AS TABLE (
        UKPRN NVARCHAR(25),
        name NVARCHAR(500)
        );

    --Get the data from temp table in the database (has to be previously loaded)
    --We will load all UKPRNs that are not already present in the database
    --using EXCEPT to compare only UKPRNs (as names might slightly differ)
    INSERT INTO @pimsOrgs (UKPRN, name) 
        SELECT UKPRN, name from pimsOrgsTemp
            WHERE UKPRN IN (
                SELECT UKPRN   
                FROM pimsOrgsTemp
                EXCEPT  
                SELECT UKPRN from organisation WHERE UKPRN IS NOT NULL);

    --variables to store the org data to insert (one by one using cursor)
    DECLARE @orgUKPRN NVARCHAR(25);
    DECLARE @orgName NVARCHAR(500);

    --counters for inserted and processed rows
    DECLARE @insertedRows INT = 0;
    DECLARE @processedRows INT = (SELECT COUNT(*) FROM pimsOrgsTemp);
    
    --use cursor to loop through the list
    DECLARE db_cursor_orgs CURSOR FOR SELECT UKPRN, Name FROM @pimsOrgs;
    OPEN db_cursor_orgs;
    FETCH NEXT FROM db_cursor_orgs INTO @orgUKPRN, @orgName;

    WHILE @@FETCH_STATUS = 0

    BEGIN

        IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = @orgUKPRN)
            BEGIN 
                INSERT INTO organisation (id, name, category, ukprn, status, legacyId, createdAt, updatedAt)
                    VALUES 
                    (NEWID(), @orgName, @orgCategory, @orgUKPRN, 1, (NEXT VALUE FOR org_legacy_id_sequence), GETDATE(), GETDATE());
                --increment counter of inserted rows
                SET @insertedRows = @insertedRows + @@ROWCOUNT;

                PRINT @orgName + ' added to organisations. UKPRN: ' + @orgUKPRN;
            END

        -- get next org
        FETCH NEXT FROM db_cursor_orgs INTO @orgUKPRN, @orgName;
    END;

    CLOSE db_cursor_orgs;
    DEALLOCATE db_cursor_orgs;

    PRINT '*** Final Number of organisations added: ' + CAST(@insertedRows AS nvarchar(30));
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