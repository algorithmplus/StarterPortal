BEGIN TRANSACTION UPDATEURLS;
BEGIN TRY  

-- profile to service
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('84b30af0-9e5b-4c9d-b8bf-02f0517adab0', 'https://s141d01-signin-svc.azurewebsites.net/signout?redirected=true');

-- service to profile
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('28388aeb-431b-49bc-9480-8db1b0bdd6e1', 'https://s141d01-signin-pfl.azurewebsites.net/signout');
    
--Commit transaction if all went fine
COMMIT TRAN UPDATEURLS;

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
          ROLLBACK TRAN TLEVELSRESULTSCERTONBOARD;
END CATCH;