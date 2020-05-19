BEGIN TRAN UPDATEGIAPURL

BEGIN TRY

     DECLARE @serviceId UNIQUEIDENTIFIER = '127a1a5a-a48b-485c-853d-4c2b5e14858a';

     -- Insert redirect URL into GIAP Service (aka KTS)
     INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'https://s115p01-as-searchweb.azurewebsites.net/auth/cb'),
            (@serviceId, 'https://s115p02-as-searchweb.azurewebsites.net/auth/cb');

     -- Insert post logout redirect URL into GIAP Service (aka KTS)
     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'https://s115p01-as-searchweb.azurewebsites.net/auth/signout'),
            (@serviceId, 'https://s115p02-as-searchweb.azurewebsites.net/auth/signout');

     --Commit transaction if all went fine
     ROLLBACK TRAN UPDATEGIAPURL;

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
          ROLLBACK TRAN UPDATEGIAPURL;

END CATCH;
