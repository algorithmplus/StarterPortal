BEGIN TRAN ADDMANAGEROLE

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName_1 VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId_1 UNIQUEIDENTIFIER;
    DECLARE @serviceName_2 VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'Get information about pupils - Service Support';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'GIAP Admin';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Get information about pupils - GIAP Admin';
    DECLARE @policyId UNIQUEIDENTIFIER;

    -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
    IF (@orgId IS NOT NULL)
        BEGIN

        -- Step 2) get organisation Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId_1 = (SELECT id FROM service WHERE name = @serviceName_1);
        IF (@serviceId_1 IS NOT NULL)
            BEGIN

            SET @serviceId_2 = (SELECT id FROM service WHERE name = @serviceName_2);
            IF (@serviceId_2 IS NOT NULL)
                BEGIN

                -- Step 3) get role Id based on name, if more than one found it will fail and go to catch block
                SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1);
                IF (@roleId_1 IS NOT NULL)

                    BEGIN

                    SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
                    IF (@roleId_2 IS NOT NULL)

                        BEGIN

                            UPDATE user_services
                                SET user_id = '47b7c726-238b-4fed-b808-81d6ea3bd1f6', updatedAt = GETDATE()
                                WHERE user_id = 'f635bbff-79c7-4362-bea1-0c2eb02dd36e' and service_id = @serviceId_1;
                        END

                        BEGIN

                            INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                            VALUES  (NEWID(), 1, '14fd9b82-d100-4070-bf9a-52029a1c24d4', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                    (NEWID(), 1, 'c598044c-ff5a-4569-ad13-45277027f083', @orgId, @serviceId_2, GETDATE(), GETDATE());

                            INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                            VALUES  (NEWID(), '47b7c726-238b-4fed-b808-81d6ea3bd1f6', @serviceId_1, @orgId, @roleId_1, GETDATE(), GETDATE()),
                                    (NEWID(), '454ce01a-7136-4209-97d0-bd4e5f55fa46', @serviceId_1, @orgId, @roleId_1, GETDATE(), GETDATE()),
                                    (NEWID(), '14fd9b82-d100-4070-bf9a-52029a1c24d4', @serviceId_2, @orgId, @roleId_2, GETDATE(), GETDATE()),
                                    (NEWID(), 'c598044c-ff5a-4569-ad13-45277027f083', @serviceId_2, @orgId, @roleId_2, GETDATE(), GETDATE());
                        END;

                    SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId_2 AND name = @policyName);
                    IF (@policyId IS NOT NULL)

                        BEGIN

                            --Create Policy Conditions - Organisations
                            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                            VALUES  (NEWID(), @policyId, 'id', 'is', '14fd9b82-d100-4070-bf9a-52029a1c24d4', GETDATE(), GETDATE()),
                                    (NEWID(), @policyId, 'id', 'is', 'c598044c-ff5a-4569-ad13-45277027f083', GETDATE(), GETDATE());
                        END;

                    END;

                END;

            END;

        END;

    ROLLBACK TRAN ADDMANAGEROLE;

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
          ROLLBACK TRAN ADDMANAGEROLE;

END CATCH;
