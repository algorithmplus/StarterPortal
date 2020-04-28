BEGIN TRAN TEACHERSERVICESPOLICYUPDATE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Teacher Services - Employer Access - Schools';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;

      -- Get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'EvolveEmpAccessSchool');
    IF (@serviceId IS NOT NULL)
        BEGIN
            -- Create Policy: 'Test Policy - Evolve - Employer Access - Schools'
            SET @policyId = NEWID();
                INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
                VALUES (@policyId, 'Test Policy - Evolve - Employer Access - Schools', @serviceId, 1, GETDATE(), GETDATE());

            --  Create Policy Conditions
                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES (NEWID(), @policyId, 'organisation.type.id', '<>', '29', GETDATE(), GETDATE());

            -- Create Role: 'Test Role - Evolve - Employer Access - Schools'
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'Test Role - Evolve - Employer Access - Schools', @serviceId, 1, GETDATE(), GETDATE(), 'da_dummy', @numericId, NULL);

            -- Link Role: 'Test Role - Evolve - Employer Access - Schools' to Policy: 'Test Policy - Evolve - Employer Access - Schools'
                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId, @roleId, GETDATE(), GETDATE());
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
