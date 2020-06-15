BEGIN TRAN ADDMANAGEROLEFORCD

BEGIN TRY

    DECLARE @userId_1 UNIQUEIDENTIFIER = 'f22e06a4-6f6b-4aa2-8f58-0e1a6a74fbdc';
    DECLARE @userId_2 UNIQUEIDENTIFIER = '040aa1aa-2f4a-4c73-9891-aeec5c86b72a';
    DECLARE @userId_3 UNIQUEIDENTIFIER = 'e04efa71-2d13-4c61-ad15-3977b1929212';
    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'Course Directory - Service Access Management';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'Course Directory - Service Support';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_3 VARCHAR(500) = 'Course Directory - Service Banner';
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

                UPDATE Role
                    SET NAME = 'Publish to the Course Directory - Service Access Management', updatedAt = GETDATE()
                    WHERE id = @roleId_1;

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 1, @userId_1, @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, @userId_2, @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), @userId_1, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
                            (NEWID(), @userId_2, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
                            (NEWID(), @userId_3, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
            IF (@roleId_2 IS NOT NULL)

                BEGIN


                UPDATE Role
                    SET NAME = 'Publish to the Course Directory - Service Support', updatedAt = GETDATE()
                    WHERE id = @roleId_2;

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), @userId_1, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
                            (NEWID(), @userId_2, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE());

                END;

            SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleName_3);
            IF (@roleId_3 IS NOT NULL)

                BEGIN

                UPDATE Role
                    SET NAME = 'Publish to the Course Directory - Service Banner', updatedAt = GETDATE()
                    WHERE id = @roleId_3;

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), @userId_1, @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), @userId_2, @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                            (NEWID(), @userId_3, @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE());

                END;

            END;

        END;

    ROLLBACK TRAN ADDMANAGEROLEFORCD;

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
          ROLLBACK TRAN ADDMANAGEROLEFORCD;

END CATCH;
