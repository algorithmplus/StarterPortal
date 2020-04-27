BEGIN TRAN TLEVELSRESULTSCERTURL

BEGIN TRY

     DECLARE @profileServiceId UNIQUEIDENTIFIER

       SET @profileServiceId = 'c31b5da5-4538-4188-aa3a-d53593af98e3';

     -- Insert T Levels post logout redirect URL into DFE Signin Profile Service

     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@profileServiceId, 'https://test-services.signin.education.gov.uk/signout?redirected=true&redirect_uri=https://localhost:44345/'),
            (@profileServiceId, 'https://test-services.signin.education.gov.uk/signout?redirected=true&redirect_uri=https://test.manage-tlevel-results.tlevels.gov.uk/');

     --Commit transaction if all went fine
     ROLLBACK TRAN TLEVELSRESULTSCERTURL;

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
          ROLLBACK TRAN TLEVELSRESULTSCERTURL;

END CATCH;
