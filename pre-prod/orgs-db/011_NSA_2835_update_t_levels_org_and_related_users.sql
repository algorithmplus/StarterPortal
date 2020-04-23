BEGIN TRAN TLEVELSORGUPDATE

BEGIN TRY

    DECLARE @orgNameNEW VARCHAR(500) = 'PEARSON EDUCATION LIMITED';
    DECLARE @orgNameOLD VARCHAR(500) = 'PEARSON PLC';
    DECLARE @serviceName VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @orgIdNEW UNIQUEIDENTIFIER;
    DECLARE @orgIdOLD UNIQUEIDENTIFIER;
    DECLARE @serviceId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgIdNEW = (SELECT id FROM organisation WHERE name = @orgNameNEW);
    SET @orgIdOLD = (SELECT id FROM organisation WHERE name = @orgNameOLD);

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);

    IF (@serviceId IS NOT NULL)
        BEGIN
            -- Step 2) update the users to point to the correct organisation
            UPDATE
                user_service_roles
            SET organisation_id = @orgIdNEW
                WHERE service_id = @serviceId
                  AND organisation_id = @orgIdOLD;

            UPDATE
                user_services
            SET organisation_id = @orgIdNEW
                WHERE service_id = @serviceId
                  AND organisation_id = @orgIdOLD;

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
