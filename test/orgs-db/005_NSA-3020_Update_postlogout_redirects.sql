BEGIN TRANSACTION UPDATEURLS;
BEGIN TRY  

-- profile to service
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('c31b5da5-4538-4188-aa3a-d53593af98e3', 'https://test-services.signin.education.gov.uk/signout?redirected=true');

-- service to profile
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('025311fc-71f6-49ca-8f35-17b8bdb71890', 'https://test-profile.signin.education.gov.uk/signout');
    
--Commit transaction if all went fine
ROLLBACK TRAN UPDATEURLS;

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
          ROLLBACK TRAN UPDATEURLS;
END CATCH;