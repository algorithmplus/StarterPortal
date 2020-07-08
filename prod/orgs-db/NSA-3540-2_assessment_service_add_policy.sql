BEGIN TRAN ASSESSMENTSERVICEROLES

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Assessment Service';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleId_2 UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'assessmentService');
    IF (@serviceId IS NOT NULL)

        BEGIN

            --Create policy - establishments
            SET @policyId = NEWID();

            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId, 'Assessment Service - Establishments', @serviceId, 1, GETDATE(), GETDATE());

            -- Get Role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_1 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'School Practitioner');
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'School Administration');
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_2, GETDATE(), GETDATE());

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
