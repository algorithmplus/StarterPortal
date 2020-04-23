BEGIN TRAN TLEVELSORGUPDATE

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'PEARSON EDUCATION LIMITED';
    DECLARE @serviceName VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);

    IF (@serviceId IS NOT NULL)
        BEGIN
            -- Step 2) update the users to point to the correct organisation
            UPDATE
                user_service_roles
            SET organisation_id = @orgId
                WHERE service_id = @serviceId
                
            UPDATE
                user_services
            SET organisation_id = @orgId
                WHERE service_id = @serviceId
        END

    ROLLBACK TRAN TLEVELSORGUPDATE;

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
          ROLLBACK TRAN TLEVELSORGUPDATE;

END CATCH;
