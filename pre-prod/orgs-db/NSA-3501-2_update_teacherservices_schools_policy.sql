BEGIN TRAN TEACHERSERVICESPOLICYDELETION

BEGIN TRY

    DECLARE @serviceId UNIQUEIDENTIFIER = 'aa4bd63e-61b8-421f-90df-8ef2cd15aa38';
    DECLARE @roleName VARCHAR(500) = 'Evolve - Employer Access - Schools';
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Teacher Services - Employer Access - Schools';
    DECLARE @policyId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId and Name = @policyName);
    IF (@policyId IS NOT NULL)

        BEGIN

            --Create Policy Conditions - Organisations
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES  (NEWID(), @policyId, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE()),
                    (NEWID(), @policyId, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

        END;

    SET @roleId = (SELECT id FROM Role WHERE Name = @roleName)
    IF (@roleId IS NOT NULL)

        BEGIN

            UPDATE Role
                SET Name = 'Teacher Services – Employers', UpdatedAt = GETDATE()
                WHERE id = @roleId;

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
