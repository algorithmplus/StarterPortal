BEGIN TRAN ASSESSMENTSERVICEROLES

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Assessment Service';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'assessmentService');
    IF (@serviceId IS NOT NULL)

        BEGIN

            SET @roleId = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'School User');
            IF (@roleId IS NOT NULL)

                BEGIN

                    UPDATE Role
                        SET Status = 0
                        WHERE Id = @roleId;

                END;


        END;

    ROLLBACK TRAN ASSESSMENTSERVICEROLES;

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
          ROLLBACK TRAN ASSESSMENTSERVICEROLES;

END CATCH;
