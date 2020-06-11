BEGIN TRAN UPDATEA2CURLS

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Apply to convert';
    DECLARE @serviceId UNIQUEIDENTIFIER;

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN
            -- Step 2) update the serviceHome URL to point to the new base URL
            UPDATE service
                SET serviceHome = 'https://apply-convert-academy.service.gov.uk/'
                WHERE id = @serviceId

            -- Step 3) update the service redirectUris to point to the new redirectUris
            UPDATE serviceRedirectUris
                SET redirectUrl = 'https://apply-convert-academy.service.gov.uk/signin-oidc'
                WHERE serviceId = @serviceId AND redirectUrl = 'https://a2c.education.gov.uk/signin-oidc'

            -- Step 4) update the service post logout redirectUris to point to the new post logout redirectUris
            UPDATE servicePostLogoutRedirectUris
                SET redirectUrl = 'https://apply-convert-academy.service.gov.uk/signout/complete'
                WHERE serviceId = @serviceId AND redirectUrl = 'https://a2c.education.gov.uk/signout/complete'
        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN UPDATEA2CURLS;

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
        ROLLBACK TRAN UPDATEA2CURLS;

END CATCH;
