BEGIN TRANSACTION UPDATEURLS;
BEGIN TRY  

-- profile to service
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('dd4122b1-263a-4312-8f68-a26c208f72bf', 'https://pp-services.signin.education.gov.uk/signout?redirected=true');

-- service to profile
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('1172d468-dfa7-4639-9c6f-60911bf10576', 'https://pp-profile.signin.education.gov.uk/signout');
    
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