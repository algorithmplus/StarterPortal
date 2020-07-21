BEGIN TRAN OPASERVICEONBOARD

BEGIN TRY

     DECLARE @roleId_1 UNIQUEIDENTIFIER;
     DECLARE @roleId_2 UNIQUEIDENTIFIER;
     DECLARE @policyId UNIQUEIDENTIFIER;
     DECLARE @serviceId UNIQUEIDENTIFIER;
     DECLARE @orgId UNIQUEIDENTIFIER;
     DECLARE @manageId UNIQUEIDENTIFIER;
     DECLARE @numericId BIGINT;

     --Create service
     SET @serviceId = NEWID();
     INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
     VALUES (@serviceId, 'OPAFastForm', 'OPA FastForm', 'ESFAOnlineCollectionsOPAFastForm', '???', '???', 'client_secret_post', 'https://onlinecollections.des.fasst.org.uk/', NULL, 1, 0, NULL, 0);
     INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'https://onlinecollections.des.fasst.org.uk:443/fastform/authcallback');
     INSERT INTO serviceParams (serviceId, paramName, paramValue)
     VALUES (@serviceId, 'allowManageInvite', 'true'),
            (@serviceId, 'serviceId', UPPER(@serviceId));
     INSERT INTO serviceGrantTypes (serviceId, grantType)
     VALUES (@serviceId, 'authorization_code'),
            (@serviceId, 'refresh_token');

     --Create Policy - Users Access
     SET @policyId = NEWID();
     INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
     VALUES (@policyId, 'OPA - Access', @serviceId, 1, GETDATE(), GETDATE());

     --Create Policy Conditions - User Access
     INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
     VALUES  (NEWID(), @policyId, 'id', 'is', 'f9424d2d-1dc8-4a77-9879-819197945a70', GETDATE(), GETDATE());

     --Create Role 'OPA Administrator' linked to access policy
     SET @roleId_1 = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId_1, 'OPA Administrator', @serviceId, 1, GETDATE(), GETDATE(), 'opa_administrator', @numericId, NULL);

     --Create Role 'OPA End User' linked to access policy
     SET @roleId_2 = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId_2, 'OPA End User', @serviceId, 1, GETDATE(), GETDATE(), 'opa_end_user', @numericId, NULL);

      INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
      VALUES  (@policyId, @roleId_1, GETDATE(), GETDATE()),
              (@policyId, @roleId_2, GETDATE(), GETDATE());
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
     ROLLBACK TRAN OPASERVICEONBOARD;

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
          ROLLBACK TRAN OPASERVICEONBOARD;

END CATCH;
