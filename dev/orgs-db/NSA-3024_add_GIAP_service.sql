BEGIN TRAN GIAPSERVICEONBOARD

BEGIN TRY

     DECLARE @orgId UNIQUEIDENTIFIER;
     DECLARE @manageId UNIQUEIDENTIFIER;
     DECLARE @policyId_1 UNIQUEIDENTIFIER;
     DECLARE @policyId_2 UNIQUEIDENTIFIER;
     DECLARE @roleId UNIQUEIDENTIFIER;
     DECLARE @serviceId UNIQUEIDENTIFIER;
     DECLARE @numericId BIGINT;

     --Create service
     SET @serviceId = NEWID();
     INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
     VALUES (@serviceId, 'Get information about pupils', 'Get information about pupils', 'GIAP', 'NULL', NULL, 'client_secret_post', NULL, NULL, 1, 0, NULL, 0);
     INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'test');
     INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'test');
     INSERT INTO serviceParams (serviceId, paramName, paramValue)
     VALUES (@serviceId, 'allowManageInvite', 'true');
     INSERT INTO serviceGrantTypes (serviceId, grantType)
     VALUES (@serviceId, 'authorization_code');

     --Create Policy - Organisations
     SET @policyId_1 = NEWID();
     INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
     VALUES (@policyId_1, 'Get information about pupils - Organisations', @serviceId, 1, GETDATE(), GETDATE());

     --Create Policy Conditions - Organisations
     INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
     VALUES (NEWID(), @policyId_1, 'organisation.category.id', 'is', '001', GETDATE(), GETDATE()),
            (NEWID(), @policyId_1, 'organisation.category.id', 'is', '002', GETDATE(), GETDATE()),
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
      VALUES (NEWID(), @policyId_2, 'organisation.type.id', 'is', '01', GETDATE(), GETDATE()),
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

     --Create Role 'GIAP User' and link to policy
     SET @roleId = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId, 'GIAP User', @serviceId, 1, GETDATE(), GETDATE(), 'giap_user', @numericId, NULL);

     INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
     VALUES (@policyId_1, @roleId, GETDATE(), GETDATE()),
            (@policyId_2, @roleId, GETDATE(), GETDATE());

     --Create Role 'GIAP Approver' and link to policy
     SET @roleId = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId, 'GIAP Approver', @serviceId, 1, GETDATE(), GETDATE(), 'giap_approver', @numericId, NULL);

     INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
     VALUES (@policyId_1, @roleId, GETDATE(), GETDATE()),
            (@policyId_2, @roleId, GETDATE(), GETDATE());

     --Add Manage Roles
     --service Config
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

     --service banner
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

     --service access management
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

     --service support
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

     --Commit transaction if all went fine
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
