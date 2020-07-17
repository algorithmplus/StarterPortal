BEGIN TRAN UPDATEASSESSMENTURL

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Assessment Service';
    DECLARE @serviceId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'assessmentService');
    IF (@serviceId IS NOT NULL)

        BEGIN

            -- Insert redirect URL into Assessment Service
            INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
            VALUES  (@serviceId, 'https://s122p02-as-landing-portal-as.azurewebsites.net/auth/cb'),
                    (@serviceId, 'https://s122p02-as-manageassessment-as.azurewebsites.net/auth/cb'),
                    (@serviceId, 'https://s122p02-as-reporting-as.azurewebsites.net/auth/cb'),
                    (@serviceId, 'https://s122p02-rba-assessment-as.azurewebsites.net/auth/cb');

        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN UPDATEASSESSMENTURL;

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
        ROLLBACK TRAN UPDATEASSESSMENTURL;

END CATCH;
