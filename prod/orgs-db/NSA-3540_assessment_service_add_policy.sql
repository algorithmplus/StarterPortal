BEGIN TRAN ASSESSMENTSERVICEROLES

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Assessment Service';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @orgName VARCHAR(500) = 'Standards and Testing Agency';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleId_3 UNIQUEIDENTIFIER;
    DECLARE @roleId_4 UNIQUEIDENTIFIER;
    DECLARE @roleId_5 UNIQUEIDENTIFIER;
    DECLARE @roleId_6 UNIQUEIDENTIFIER;
    DECLARE @roleId_7 UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'assessmentService');
    IF (@serviceId IS NOT NULL)

        BEGIN

            --Create policy - organisations
            SET @orgId = (SELECT id FROM organisation WHERE name = @orgName AND Category = '008');
            SET @policyId = NEWID();

            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId, 'Assessment Service - Organisations', @serviceId, 1, GETDATE(), GETDATE());

            --Create policy conditions - organisations
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES  (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

            -- Get Role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_1 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Data User');
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Test Developer');
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_2, GETDATE(), GETDATE());

                END;

            SET @roleId_3 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Service Manager');
            IF (@roleId_3 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_3, GETDATE(), GETDATE());

                END;

            SET @roleId_4 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Support');
            IF (@roleId_4 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_4, GETDATE(), GETDATE());

                END;

            SET @roleId_5 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Help Desk');
            IF (@roleId_5 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_5, GETDATE(), GETDATE());

                END;

            SET @roleId_6 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Reviewer');
            IF (@roleId_6 IS NOT NULL)

                BEGIN

                    --Link existing roles to new policy
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId, @roleId_6, GETDATE(), GETDATE());

                END;

            SET @roleId_7 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'School User');
            IF (@roleId_7 IS NOT NULL)

                BEGIN

                    UPDATE Role
                        SET Status = 0
                        WHERE Id = @roleId_7;

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
