BEGIN TRAN DQTSERVICEMANAGEUSER

BEGIN TRY

    DECLARE @userId UNIQUEIDENTIFIER = '7ebf9e08-eef7-447c-add8-463b1231d4f9';
    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName VARCHAR(500) = 'DfE Sign-in manage';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'Teacher Services - Employer Access - Schools - Service Access Management';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'Teacher Services - Employer Access - Schools - Service Support';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_3 VARCHAR(500) = 'Teacher Services - Employer Access - Agent - Service Access Management';
    DECLARE @roleId_3 UNIQUEIDENTIFIER;
    DECLARE @roleName_4 VARCHAR(500) = 'Teacher Services - Employer Access - Agent - Service Support';
    DECLARE @roleId_4 UNIQUEIDENTIFIER;
    DECLARE @roleName_5 VARCHAR(500) = 'Teacher Services - Appropriate Body - Service Access Management';
    DECLARE @roleId_5 UNIQUEIDENTIFIER;
    DECLARE @roleName_6 VARCHAR(500) = 'Teacher Services - Appropriate Body - Service Support';
    DECLARE @roleId_6 UNIQUEIDENTIFIER;
    DECLARE @roleName_7 VARCHAR(500) = 'Teacher Services - ITT Provider - Service Access Management';
    DECLARE @roleId_7 UNIQUEIDENTIFIER;
    DECLARE @roleName_8 VARCHAR(500) = 'Teacher Services - ITT Provider - Service Support';
    DECLARE @roleId_8 UNIQUEIDENTIFIER;

    -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
    IF (@orgId IS NOT NULL)
        BEGIN

        -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
        IF (@serviceId IS NOT NULL)
            BEGIN

            -- Step 1) get role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1 and Code = 'AA4BD63E-61B8-421F-90DF-8EF2CD15AA38_accessManage');
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                VALUES (NEWID(), 1, @userId, @orgId, @serviceId, GETDATE(), GETDATE());

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE());

                END;

            SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2 and Code = 'AA4BD63E-61B8-421F-90DF-8EF2CD15AA38_serviceSup');
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE());

                END;

            SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleName_3 and Code = 'DDFA2FA3-9824-4678-A2E0-F34D6D71948E_accessManage');
            IF (@roleId_3 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE());

                END;

            SET @roleId_4 = (SELECT id FROM Role WHERE name = @roleName_4 and Code = 'DDFA2FA3-9824-4678-A2E0-F34D6D71948E_serviceSup');
            IF (@roleId_4 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_4, GETDATE(), GETDATE());

                END;

            SET @roleId_5 = (SELECT id FROM Role WHERE name = @roleName_5 and Code = '8FBA5FDE-832B-499B-957E-8BCD97D11B2D_accessManage');
            IF (@roleId_5 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_5, GETDATE(), GETDATE());

                END;

            SET @roleId_6 = (SELECT id FROM Role WHERE name = @roleName_6 and Code = '8FBA5FDE-832B-499B-957E-8BCD97D11B2D_serviceSup');
            IF (@roleId_6 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_6, GETDATE(), GETDATE());

                END;

            SET @roleId_7 = (SELECT id FROM Role WHERE name = @roleName_7 and Code = '0D15C5BD-CA2F-4211-B789-853BB34CE884_accessManage');
            IF (@roleId_7 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_7, GETDATE(), GETDATE());

                END;

            SET @roleId_8 = (SELECT id FROM Role WHERE name = @roleName_8 and Code = '0D15C5BD-CA2F-4211-B789-853BB34CE884_serviceSup');
            IF (@roleId_8 IS NOT NULL)

                BEGIN

                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId_8, GETDATE(), GETDATE());

                END;

            END;

        END;

    ROLLBACK TRAN DQTSERVICEMANAGEUSER

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
          ROLLBACK TRAN DQTSERVICEMANAGEUSER;

END CATCH;
