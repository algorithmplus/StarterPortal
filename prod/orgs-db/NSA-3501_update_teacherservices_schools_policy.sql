BEGIN TRAN TEACHERSERVICESPOLICYDELETION

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Teacher Services - Employer Access - Schools';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleName VARCHAR(500) = 'Teacher Services – Employers';
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @policyId_1 UNIQUEIDENTIFIER;
    DECLARE @policyConditionId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName AND clientId = 'EvolveEmpAccessSchool');
    IF (@serviceId IS NOT NULL)

        BEGIN

        SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId);
        IF (@policyId IS NOT NULL)

            BEGIN

                --  Update policy name
                UPDATE Policy
                    SET Name = 'Teacher Services - Employer Access - Schools', UpdatedAt = GETDATE()
                    WHERE id = @policyId;

            SET @policyConditionId = (SELECT id FROM PolicyCondition WHERE PolicyId = @policyId AND Field = 'organisation.id' AND VALUE = '243AE3E3-B8A0-46CE-ACE6-05A08A3D1C76');
            IF (@policyConditionId IS NOT NULL)

                BEGIN

                    --  Delete specific policy condition
                    DELETE FROM PolicyCondition
                        WHERE id = @policyConditionId;

                    --Create Policy Conditions - Organisations
                    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                    VALUES  (NEWID(), @policyId, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE()),
                            (NEWID(), @policyId, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

                END;

            END;

            -- Create new policy - Other Stakeholders
            SET @policyId_1 = NEWID();
                INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
                VALUES (@policyId_1, 'TA Administration', @serviceId, 1, GETDATE(), GETDATE());

                --Create Policy Conditions - Organisations
                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES  (NEWID(), @policyId_1, 'organisation.id', 'is', '243AE3E3-B8A0-46CE-ACE6-05A08A3D1C76', GETDATE(), GETDATE());


            SET @roleId = (SELECT id FROM Role WHERE ApplicationId = @serviceId and name = @roleName)
            IF (@roleId IS NOT NULL)

                BEGIN

                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES (@policyId_1, @roleId, GETDATE(), GETDATE());

                    UPDATE Role
                        SET Name = 'Evolve - Employer Access - Schools', UpdatedAt = GETDATE()
                        WHERE id = @roleId;

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
