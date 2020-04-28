BEGIN TRAN TEACHERSERVICESPOLICYUPDATE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Teacher Services - Employer Access - Schools';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Evolve - Employer Access - Schools'
    DECLARE @policyId UNIQUEIDENTIFIER;

    IF (@serviceName IS NOT NULL)

      BEGIN
      -- Get Service Id based on name, if more than one found it will fail and go to catch block
      SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName AND clientId = 'EvolveEmpAccessSchool');

      -- Get Policy Id based on name, if more than one found it will fail and go to catch block
      SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId AND Name = @policyName);

      --  Create Policy Conditions
          INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
          VALUES (NEWID(), @policyId, 'organisation.type.id', '<>', '29', GETDATE(), GETDATE());
      END;

    -- COMMIT TRAN IF NO  ERRORS
    ROLLBACK TRAN TEACHERSERVICESPOLICYUPDATE;

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
          ROLLBACK TRAN TEACHERSERVICESPOLICYUPDATE;

END CATCH;
