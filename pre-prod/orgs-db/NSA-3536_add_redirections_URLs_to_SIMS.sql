BEGIN TRAN UPDATESIMSREDIRECTURL

BEGIN TRY

     DECLARE @serviceId UNIQUEIDENTIFIER = '5f895ff4-6d68-4a5a-ac2b-5ab51c36b09f';

    BEGIN
        -- Insert redirect URLs
        -- into SIMS Test Service
        INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
        VALUES (@serviceId, 'http://10.94.214.177:90/eseries/esfa.redirect'),
                (@serviceId, 'http://localhost:8001'),
                (@serviceId, 'http://localhost:8001/eseries/esfa.redirect'),
                (@serviceId, 'http://localhost:8586/eseries/esfa.redirect'),
                (@serviceId, 'http://localhost:8587'),
                (@serviceId, 'http://localhost:8587/tenant4/esfa.redirect');

        --Commit transaction if all went fine
        ROLLBACK TRAN UPDATESIMSREDIRECTURL;
    END;

END TRY

BEGIN CATCH

     SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

     --Rollback if there was an error
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN UPDATESIMSREDIRECTURL;

END CATCH;
