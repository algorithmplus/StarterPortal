BEGIN TRANSACTION UPDATEURLS;
BEGIN TRY  

-- profile to service
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('0b030112-b8b1-4a70-a47a-316af0c22e71', 'https://test-services.signin.education.gov.uk/signout?redirected=true');

-- service to profile
INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    ('57b211c9-2335-46eb-81da-39484896ff01', 'https://test-profile.signin.education.gov.uk/signout');
    
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
          ROLLBACK TRAN TLEVELSRESULTSCERTONBOARD;
END CATCH;