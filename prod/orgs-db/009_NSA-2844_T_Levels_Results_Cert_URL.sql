BEGIN TRAN TLEVELSRESULTSCERTURL

BEGIN TRY

     DECLARE @profileServiceId UNIQUEIDENTIFIER

     SET @profileServiceId = '0b030112-b8b1-4a70-a47a-316af0c22e71';

     -- Insert T Levels post logout redirect URL into DFE Signin Profile Service

     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@profileServiceId, 'https://services.signin.education.gov.uk/signout?redirected=true&redirect_uri=https://manage-tlevel-results.tlevels.gov.uk/');

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
