BEGIN TRAN ADDMANAGEROLE

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId UNIQUEIDENTIFIER;
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

        -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
        IF (@serviceId IS NOT NULL)
            BEGIN

            -- Step 1) get role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1);
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 1, 'd599de56-bf27-4171-b9df-45a32716f030', @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 'd599de56-bf27-4171-b9df-45a32716f030', @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 1, 'f635bbff-79c7-4362-bea1-0c2eb02dd36e', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '2a811079-cb9e-46c1-ace5-3d910cad9db3', @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 'f635bbff-79c7-4362-bea1-0c2eb02dd36e', @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
                            (NEWID(), '2a811079-cb9e-46c1-ace5-3d910cad9db3', @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE());

                END;

            SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleName_3);
            IF (@roleId_3 IS NOT NULL)

                BEGIN

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 1, '63643fe0-dfad-4d10-8449-216467baf825', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '3a7e1dbd-346a-4ae9-9636-9dae77329323', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '1b6d617b-9e4d-42ed-b4d7-9dc99bfa4997', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'd599de56-bf27-4171-b9df-45a32716f030', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '720a9a48-d737-4456-967e-68114738fb0d', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '095f46ce-7192-4d94-a744-b6a68445664c', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'ad40a258-9509-4280-97a2-2008993ee265', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'de33fab2-1b23-4879-9c8a-1a30023a4fb2', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'd1103cf8-9d98-46b2-b3dc-f36911baf3b2', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '204545c3-4f34-4075-bcc3-50a06d4a22bc', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '6e4d4b01-e09a-430d-9def-7ed7686f7e36', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '23947f14-d2cf-4a24-a9e8-0c41a75e92a0', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '127bee3a-6100-4081-bd5d-64abce42eed7', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'b3dcf295-ee54-41f5-84b5-dd315de19deb', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '4d283109-c085-4f46-9bb2-371b75fc273b', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'f635bbff-79c7-4362-bea1-0c2eb02dd36e', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, 'e4cef589-5594-4856-b2fd-21123fb3ffd3', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '34b1fc92-47f5-43bf-8f48-4470f0d36e3d', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '6a043c8c-50ca-4158-8e22-78cf8267f84a', @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, '2a811079-cb9e-46c1-ace5-3d910cad9db3', @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), '63643fe0-dfad-4d10-8449-216467baf825', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '3a7e1dbd-346a-4ae9-9636-9dae77329323', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '1b6d617b-9e4d-42ed-b4d7-9dc99bfa4997', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'd599de56-bf27-4171-b9df-45a32716f030', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '720a9a48-d737-4456-967e-68114738fb0d', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '095f46ce-7192-4d94-a744-b6a68445664c', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'ad40a258-9509-4280-97a2-2008993ee265', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'de33fab2-1b23-4879-9c8a-1a30023a4fb2', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'd1103cf8-9d98-46b2-b3dc-f36911baf3b2', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '204545c3-4f34-4075-bcc3-50a06d4a22bc', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '6e4d4b01-e09a-430d-9def-7ed7686f7e36', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '23947f14-d2cf-4a24-a9e8-0c41a75e92a0', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '127bee3a-6100-4081-bd5d-64abce42eed7', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'b3dcf295-ee54-41f5-84b5-dd315de19deb', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '4d283109-c085-4f46-9bb2-371b75fc273b', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'f635bbff-79c7-4362-bea1-0c2eb02dd36e', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), 'e4cef589-5594-4856-b2fd-21123fb3ffd3', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '34b1fc92-47f5-43bf-8f48-4470f0d36e3d', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '6a043c8c-50ca-4158-8e22-78cf8267f84a', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), '2a811079-cb9e-46c1-ace5-3d910cad9db3', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE());

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
