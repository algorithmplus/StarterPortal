BEGIN TRAN TEACHERSERVICESPOLICYDELETION

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Teacher Services - Employer Access - Schools';
    DECLARE @policyName VARCHAR(500) = 'TA Administration - Restrict HEI Access';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @policyConditionId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName AND clientId = 'EvolveEmpAccessSchool');
    IF (@serviceId IS NOT NULL)
        BEGIN
        SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId AND name = @policyName);
        IF (@policyId IS NOT NULL)
            BEGIN
            SET @policyConditionId = (SELECT id FROM PolicyCondition WHERE PolicyId = @policyId AND Field = 'organisation.type.id' AND VALUE = '29');
            IF (@policyConditionId IS NOT NULL)
                BEGIN
                    --  DELETE Policy Condition
                    DELETE FROM PolicyCondition
                        WHERE id = @policyConditionId;

                    --  DELETE Policy
                    DELETE FROM Policy
                        WHERE id = @policyId;
                END;
            END;
        END;

    -- COMMIT TRAN IF NO ERRORS
    ROLLBACK TRAN TEACHERSERVICESPOLICYDELETION;

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
          ROLLBACK TRAN TEACHERSERVICESPOLICYDELETION;

END CATCH;
