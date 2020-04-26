BEGIN TRAN TLEVELSRESULTSCERTURL

BEGIN TRY

     DECLARE @profileServiceId UNIQUEIDENTIFIER

     SET @profileServiceId = 'dd4122b1-263a-4312-8f68-a26c208f72bf';

     -- Insert T Levels post logout redirect URL into DFE Signin Profile Service

     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@profileServiceId, 'https://pp-services.signin.education.gov.uk/signout?redirected=true&redirect_uri=https://pp.manage-tlevel-results.tlevels.gov.uk/');

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
