BEGIN TRAN UPDATESIMSURL

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'SIMS Test';
    DECLARE @serviceId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

            -- Insert redirect URL into SIMS Test Service
            INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
            VALUES  (@serviceId, 'http://10.94.214.177:90/esfa.redirect/'),
                    (@serviceId, 'http://localhost:8001/esfa.redirect/'),
                    (@serviceId, 'http://localhost:8587/esfa.redirect/'),
                    (@serviceId, 'https://pilot.pecuniam-online.co.uk/esfa.redirect/'),
                    (@serviceId, 'https://preprod.pecuniam-online.co.uk/esfa.redirect/'),
                    (@serviceId, 'https://uat-v2.pecuniam-online.co.uk/esfa.redirect/'),
                    (@serviceId, 'http://localhost:8586/esfa.redirect/');

        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN UPDATESIMSURL;

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
        ROLLBACK TRAN UPDATESIMSURL;

END CATCH;
