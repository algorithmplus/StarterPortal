BEGIN TRAN TLEVELSRESULTSCERTURL

BEGIN TRY

     DECLARE @profileServiceId UNIQUEIDENTIFIER

     SET @profileServiceId = '84b30af0-9e5b-4c9d-b8bf-02f0517adab0';

     -- Insert T Levels post logout redirect URL into DFE Signin Profile Service

     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@profileServiceId, 'https://s141d01-signin-svc.azurewebsites.net/signout?redirected=true&redirect_uri=https://dev.manage-tlevel-results.tlevels.gov.uk/');

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
