BEGIN TRAN ADDMANAGEROLE

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName_1 VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId_1 UNIQUEIDENTIFIER;
    DECLARE @serviceName_2 VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'Get information about pupils - Service Access Management';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'Get information about pupils - Service Configuration';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_3 VARCHAR(500) = 'GIAP Admin';
    DECLARE @roleId_3 UNIQUEIDENTIFIER;

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

                        INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                        VALUES  (NEWID(), 1, '2acec4b9-d75f-4986-bf58-545f944c68cc', @orgId, @serviceId_1, GETDATE(), GETDATE()),
                                (NEWID(), 1, 'f635bbff-79c7-4362-bea1-0c2eb02dd36e', @orgId, @serviceId_1, GETDATE(), GETDATE()),
                                (NEWID(), 1, '2a811079-cb9e-46c1-ace5-3d910cad9db3', @orgId, @serviceId_1, GETDATE(), GETDATE());

                        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                        VALUES  (NEWID(), '2acec4b9-d75f-4986-bf58-545f944c68cc', @serviceId_1, @orgId, @roleId_1, GETDATE(), GETDATE()),
                                (NEWID(), '47b7c726-238b-4fed-b808-81d6ea3bd1f6', @serviceId_1, @orgId, @roleId_1, GETDATE(), GETDATE()),
                                (NEWID(), '454ce01a-7136-4209-97d0-bd4e5f55fa46', @serviceId_1, @orgId, @roleId_1, GETDATE(), GETDATE());

                    END;

                SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
                IF (@roleId_2 IS NOT NULL)

                    BEGIN

                        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                        VALUES  (NEWID(), '47b7c726-238b-4fed-b808-81d6ea3bd1f6', @serviceId_1, @orgId, @roleId_2, GETDATE(), GETDATE()),
                                (NEWID(), '454ce01a-7136-4209-97d0-bd4e5f55fa46', @serviceId_1, @orgId, @roleId_2, GETDATE(), GETDATE());

                    END;

                SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleName_3);
                IF (@roleId_3 IS NOT NULL)

                    BEGIN

                        INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                        VALUES  (NEWID(), 1, '47b7c726-238b-4fed-b808-81d6ea3bd1f6', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, 'aee57e52-a228-4cd6-bca2-86440b4980db', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, '59784071-a92d-4e07-92e8-d9cab5849b66', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, '7b968220-f359-4bf7-a45a-c66162990692', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, '66d05547-7f34-4294-b296-4b4f66f4192f', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, '763e7ecb-a691-41de-a8f0-5589f511c332', @orgId, @serviceId_2, GETDATE(), GETDATE()),
                                (NEWID(), 1, '454ce01a-7136-4209-97d0-bd4e5f55fa46', @orgId, @serviceId_2, GETDATE(), GETDATE());

                        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                        VALUES  (NEWID(), '6ef23475-d01a-4ebd-9799-d1cca18e4c78', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '71a1e765-aa9c-4c38-8e1e-a3c9e59fd5cf', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '47b7c726-238b-4fed-b808-81d6ea3bd1f6', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), 'aee57e52-a228-4cd6-bca2-86440b4980db', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '59784071-a92d-4e07-92e8-d9cab5849b66', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '7b968220-f359-4bf7-a45a-c66162990692', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '66d05547-7f34-4294-b296-4b4f66f4192f', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '763e7ecb-a691-41de-a8f0-5589f511c332', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                (NEWID(), '454ce01a-7136-4209-97d0-bd4e5f55fa46', @serviceId_2, @orgId, @roleId_3, GETDATE(), GETDATE());
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
