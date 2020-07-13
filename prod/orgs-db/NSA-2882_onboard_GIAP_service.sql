BEGIN TRAN GIAPSERVICEONBOARD

BEGIN TRY

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
    DECLARE @manageId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;

        --Step 1) Create new service and associated data
        SET @serviceId = NEWID();
        INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
        VALUES  (@serviceId, 'Get information about pupils', 'Get information about pupils', 'kts2', '???', '???', 'client_secret_post', 'https://s115p01-as-searchweb.azurewebsites.net', NULL, 1, 0, NULL, 0);
        INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
        VALUES  (@serviceId, 'https://s115p01-as-searchweb.azurewebsites.net/auth/cb'),
                (@serviceId, 'https://www.get-information-pupils.service.gov.uk/auth/cb');
        INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
        VALUES  (@serviceId, 'https://s115p01-as-searchweb-dsi.azurewebsites.net/auth/signout'),
                (@serviceId, 'https://www.get-information-pupils.service.gov.uk/auth/signout');
        INSERT INTO serviceParams (serviceId, paramName, paramValue)
        VALUES (@serviceId, 'allowManageInvite', 'true');
        INSERT INTO serviceGrantTypes (serviceId, grantType)
        VALUES (@serviceId, 'authorization_code');

        --Step 2) Create new policies and conditions
        --Create Policy - Organisations
        SET @policyId_1 = NEWID();
        INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
        VALUES (@policyId_1, 'Get information about pupils - Organisations', @serviceId, 1, GETDATE(), GETDATE());

        --Create Policy Conditions - Organisations
        INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
        VALUES  (NEWID(), @policyId_1, 'organisation.category.id', 'is', '002', GETDATE(), GETDATE()),
                (NEWID(), @policyId_1, 'organisation.category.id', 'is', '010', GETDATE(), GETDATE()),
                (NEWID(), @policyId_1, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE()),
                (NEWID(), @policyId_1, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

        --Create Policy - Establishments
        SET @policyId_2 = NEWID();
        INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
        VALUES (@policyId_2, 'Get information about pupils - Establishments', @serviceId, 1, GETDATE(), GETDATE());

        --Create Policy Conditions - Establishments
        INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
        VALUES  (NEWID(), @policyId_2, 'organisation.category.id', 'is', '001', GETDATE(), GETDATE()),
                (NEWID(), @policyId_2, 'organisation.type.id', 'is', '01', GETDATE(), GETDATE()),
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

        --Create Policy - Admin Users
        SET @policyId_3 = NEWID();
        INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
        VALUES (@policyId_3, 'Get information about pupils - GIAP Admin', @serviceId, 1, GETDATE(), GETDATE());

        --Create Policy Conditions - Establishments
        INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
        VALUES  (NEWID(), @policyId_3, 'id', 'is', '63643fe0-dfad-4d10-8449-216467baf825', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '3a7e1dbd-346a-4ae9-9636-9dae77329323', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '1b6d617b-9e4d-42ed-b4d7-9dc99bfa4997', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', 'd599de56-bf27-4171-b9df-45a32716f030', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '720a9a48-d737-4456-967e-68114738fb0d', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '095f46ce-7192-4d94-a744-b6a68445664c', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', 'ad40a258-9509-4280-97a2-2008993ee265', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', 'de33fab2-1b23-4879-9c8a-1a30023a4fb2', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', 'd1103cf8-9d98-46b2-b3dc-f36911baf3b2', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '204545c3-4f34-4075-bcc3-50a06d4a22bc', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '6e4d4b01-e09a-430d-9def-7ed7686f7e36', GETDATE(), GETDATE()),
                (NEWID(), @policyId_3, 'id', 'is', '23947f14-d2cf-4a24-a9e8-0c41a75e92a0', GETDATE(), GETDATE());

        --Step 3) Create roles and link to  associated policies
        --Create Role 'GIAP User' and link to policies 1 and 2
        SET @roleId_1 = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;

        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId_1, @roleName_1, @serviceId, 1, GETDATE(), GETDATE(), 'GIAPUser', @numericId, NULL);

        INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
        VALUES  (@policyId_1, @roleId_1, GETDATE(), GETDATE()),
                (@policyId_2, @roleId_1, GETDATE(), GETDATE());

        --Create Role 'GIAP Approver' and link to policies 1 and 2
        SET @roleId_2 = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;

        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId_2, @roleName_2, @serviceId, 1, GETDATE(), GETDATE(), 'GIAPApprover', @numericId, NULL);

        INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
        VALUES  (@policyId_1, @roleId_2, GETDATE(), GETDATE()),
                (@policyId_2, @roleId_2, GETDATE(), GETDATE());

        --Create role 'GIAP Admin' and link to policy 3
        SET @roleId_3 = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;

        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId_3, @roleName_3, @serviceId, 1, GETDATE(), GETDATE(), 'GIAPAdmin', @numericId, NULL);

        INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
        VALUES (@policyId_3, @roleId_3, GETDATE(), GETDATE());

        --Step 4) Add service manage roles
        --Create role 'Get information about pupils - Service Configuration'
        SET @manageId = (SELECT id FROM service WHERE clientId = 'manage')
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role
        (Id, Name, ApplicationId, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        SELECT NEWID(),
            name + ' - Service Configuration',
            @manageId,
            GETDATE(),
            GETDATE(),
            UPPER(cast(id as varchar(40))) + '_serviceconfig',
            @numericId,
            NULL
        FROM service
        WHERE id = @serviceId

        --Create role 'Get information about pupils - Service Banner'
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role
        (Id, Name, ApplicationId, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        SELECT NEWID(),
            name + ' - Service Banner',
            @manageId,
            GETDATE(),
            GETDATE(),
            UPPER(cast(id as varchar(40))) + '_serviceBanner',
            @numericId,
            NULL
        FROM service
        WHERE id = @serviceId

        --Create role 'Get information about pupils - Service Access Management'
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role
        (Id, Name, ApplicationId, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        SELECT NEWID(),
            name + ' - Service Access Management',
            @manageId,
            GETDATE(),
            GETDATE(),
            UPPER(cast(id as varchar(40))) + '_accessManage',
            @numericId,
            NULL
        FROM service
        WHERE id = @serviceId

        --Create role 'Get information about pupils - Service Support'
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role
        (Id, Name, ApplicationId, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        SELECT NEWID(),
            name + ' - Service Support',
            @manageId,
            GETDATE(),
            GETDATE(),
            UPPER(cast(id as varchar(40))) + '_serviceSup',
            @numericId,
            NULL
        FROM service
        WHERE id = @serviceId

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
