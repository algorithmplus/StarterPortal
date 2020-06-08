BEGIN TRAN GIAPSERVICEONBOARD

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceNameToUpdate VARCHAR(500) = 'Key to Success 2.0';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId_1 UNIQUEIDENTIFIER;
    DECLARE @policyId_2 UNIQUEIDENTIFIER;
    DECLARE @policyId_3 UNIQUEIDENTIFIER;
    DECLARE @roleName_1 VARCHAR(500) = 'GIAP User';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleName_2 VARCHAR(500) = 'GIAP Approver';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleName_3 VARCHAR(500) = 'GIAP Admin';
    DECLARE @roleId_3 UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceNameToUpdate);
    IF (@serviceId IS NOT NULL)

        BEGIN

            UPDATE service
            SET name = 'Get information about pupils', description = 'Get information about pupils'
            WHERE id= @serviceId;

            -- Step 2) Create new policies and conditions
            --Create Policy - Organisations
            SET @policyId_1 = NEWID();
            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId_1, 'Get information about pupils - Organisations', @serviceId, 1, GETDATE(), GETDATE());

            --Create Policy Conditions - Organisations
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES  (NEWID(), @policyId_1, 'organisation.category.id', 'is', '001', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_1, 'organisation.category.id', 'is', '010', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_1, 'organisation.category.id', 'is', '013', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_1, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_1, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

            --Create Policy - Establishments
            SET @policyId_2 = NEWID();
            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId_2, 'Get information about pupils - Establishments', @serviceId, 1, GETDATE(), GETDATE());

            --Create Policy Conditions - Establishments
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES  (NEWID(), @policyId_2, 'organisation.type.id', 'is', '01', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '02', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '03', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '05', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '06', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '07', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '08', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '10', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '11', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '12', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '14', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '15', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '18', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '24', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '26', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '28', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '32', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '32', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '32', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '33', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '34', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '35', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '36', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '38', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '39', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '40', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '41', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '42', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '43', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '44', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '45', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.type.id', 'is', '46', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_2, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

            --Create Policy - Establishments
            SET @policyId_3 = NEWID();
            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId_3, 'Get information about pupils - GIAP Admin', @serviceId, 1, GETDATE(), GETDATE());

            --Create Policy Conditions - Establishments
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES  (NEWID(), @policyId_3, 'id', 'is', '40049bba-796c-4321-ba5b-03cb1ed0af1b', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '26594064-8342-46fd-93cf-0b6478846826', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '6753a8ac-4098-472c-ab6f-246826154472', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', 'e108a161-83a7-49ea-828b-246e8c6f1a0a', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '49cb164a-0473-4d01-89cd-35855f26936d', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '27b88c65-e6dd-4479-93f7-431b8bbab3e9', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', 'd4689ff2-9e87-4402-835c-5ee7caf7244b', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', 'd8983fc2-08bc-4b93-828a-72ed673cc4d6', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', 'c52a6363-b929-4421-aff5-0552f786b14a', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '97394e3e-f5c6-402e-b230-103c67f30280', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '9be44f8e-3040-424f-bf12-2c5ab4e7c250', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '2acec4b9-d75f-4986-bf58-545f944c68cc', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '47b9bc3f-e801-45e9-9b03-8b6ea33ed279', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '9b8903ab-a5cb-4970-ac10-abf1e39ef70a', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '4e6e86bf-197c-4324-8b50-b0f48776553f', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', 'f0577dbf-acd4-4b96-8c5a-f8b3c65e58ac', GETDATE(), GETDATE()),
                    (NEWID(), @policyId_3, 'id', 'is', '50bf4df2-b5e1-4ebe-bccd-ffe91896221d', GETDATE(), GETDATE());

            SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1);
            IF (@roleId_1 IS NOT NULL)

                BEGIN

                    -- Step 3) Link existing roles to new policies
                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES  (@policyId_1, @roleId_1, GETDATE(), GETDATE()),
                            (@policyId_2, @roleId_1, GETDATE(), GETDATE());

                SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
                IF (@roleId_2 IS NOT NULL)

                    BEGIN

                        -- Step 3) Link existing roles to new policies
                        INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                        VALUES  (@policyId_1, @roleId_2, GETDATE(), GETDATE()),
                                (@policyId_2, @roleId_2, GETDATE(), GETDATE());

                    SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleName_3);
                    IF (@roleId_3 IS NOT NULL)

                        BEGIN

                            INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                            VALUES (@policyId_3, @roleId_3, GETDATE(), GETDATE());

                            -- Step 4) Add user services and user servcice roles
                        SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
                        IF (@orgId IS NOT NULL)

                            BEGIN;

                                INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                VALUES  (NEWID(), 1, '40049bba-796c-4321-ba5b-03cb1ed0af1b',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, '26594064-8342-46fd-93cf-0b6478846826',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, '6753a8ac-4098-472c-ab6f-246826154472',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, 'e108a161-83a7-49ea-828b-246e8c6f1a0a',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, '49cb164a-0473-4d01-89cd-35855f26936d',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, '27b88c65-e6dd-4479-93f7-431b8bbab3e9',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, 'd4689ff2-9e87-4402-835c-5ee7caf7244b',@orgId, @serviceId, GETDATE(), GETDATE()),
                                        (NEWID(), 1, 'd8983fc2-08bc-4b93-828a-72ed673cc4d6',@orgId, @serviceId, GETDATE(), GETDATE());

                                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                VALUES  (NEWID(), '40049bba-796c-4321-ba5b-03cb1ed0af1b', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), '26594064-8342-46fd-93cf-0b6478846826', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), '6753a8ac-4098-472c-ab6f-246826154472', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), 'e108a161-83a7-49ea-828b-246e8c6f1a0a', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), '49cb164a-0473-4d01-89cd-35855f26936d', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), '27b88c65-e6dd-4479-93f7-431b8bbab3e9', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), 'd4689ff2-9e87-4402-835c-5ee7caf7244b', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE()),
                                        (NEWID(), 'd8983fc2-08bc-4b93-828a-72ed673cc4d6', @serviceId, @orgId, @roleId_3, GETDATE(), GETDATE());

                            END;

                    END;

                END;

            END;
        END;

    ROLLBACK TRAN GIAPSERVICEONBOARD;

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
          ROLLBACK TRAN GIAPSERVICEONBOARD;

END CATCH;
