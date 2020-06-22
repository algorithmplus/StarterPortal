BEGIN TRAN ADDMANAGEROLE

BEGIN TRY

    DECLARE @userId_1 UNIQUEIDENTIFIER = 'f93c58c8-fbf5-43a3-a48c-976734a16d55';
    DECLARE @userId_2 UNIQUEIDENTIFIER = '0ce3f504-18ef-4474-a667-01037ee9b995';
    DECLARE @userId_3 UNIQUEIDENTIFIER = '80a44186-f366-4d25-bcb4-4df68a46570d';
    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'DfE Sign-in - Service Access Management';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'DfE Sign-in - Service Banner';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;

    -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
    IF (@orgId IS NOT NULL)
        BEGIN

        -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
        IF (@serviceId IS NOT NULL)
            BEGIN

            -- Step 1) get role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1 and Code = '57B211C9-2335-46EB-81DA-39484896FF01_accessManage');
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES  (NEWID(), 1, @userId_1, @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, @userId_2, @orgId, @serviceId, GETDATE(), GETDATE()),
                            (NEWID(), 1, @userId_3, @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), @userId_1, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
                            (NEWID(), @userId_2, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
                            (NEWID(), @userId_3, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2 and Code = '57B211C9-2335-46EB-81DA-39484896FF01_serviceBanner');
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES  (NEWID(), @userId_1, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
                            (NEWID(), @userId_2, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
                            (NEWID(), @userId_3, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE());

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
