BEGIN TRAN UpdatingPostLogout

BEGIN TRY
    DECLARE @serviceId UNIQUEIDENTIFIER = '1172d468-dfa7-4639-9c6f-60911bf10576'
    DECLARE @profileId UNIQUEIDENTIFIER = 'dd4122b1-263a-4312-8f68-a26c208f72bf'

INSERT INTO
    servicePostLogoutRedirectUris
    (serviceId, redirectUrl)
VALUES
    (@serviceId, 'https://pp-profile.signin.education.gov.uk/signout?redirect_uri=https://pp.manage-tlevel-results.tlevels.gov.uk/');

    ROLLBACK TRAN UpdatingPostLogout;

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
          ROLLBACK TRAN UpdatingPostLogout;

END CATCH;
