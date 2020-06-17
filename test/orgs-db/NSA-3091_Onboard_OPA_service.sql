BEGIN TRAN OPASERVICEONBOARD

BEGIN TRY

     DECLARE @roleId UNIQUEIDENTIFIER;
     DECLARE @serviceId UNIQUEIDENTIFIER;
     DECLARE @orgId UNIQUEIDENTIFIER;
     DECLARE @manageId UNIQUEIDENTIFIER;
     DECLARE @numericId BIGINT;

     --Create service
     SET @serviceId = NEWID();
     INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
     VALUES (@serviceId, 'OPAFastForm', 'OPA FastForm', 'ESFAOnlineCollectionsOPAFastForm ', '???', '???', 'client_secret_post', 'https://onlinecollections.sitdes.fasst.org.uk/', NULL, 1, 0, NULL, 0);
     INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'http://10.0.0.4:7001/fastform/auth/cb'),
            (@serviceId, 'http://localhost:7001/fastform/auth/cb'),
            (@serviceId, 'https://onlinecollections.sitdes.fasst.org.uk:443/fastform/auth/cb'),
            (@serviceId, 'https://onlinecollections.preproddes.fasst.org.uk:443/fastform/auth/cb');
     INSERT INTO serviceParams (serviceId, paramName, paramValue)
     VALUES (@serviceId, 'allowManageInvite', 'true');
     INSERT INTO serviceGrantTypes (serviceId, grantType)
     VALUES (@serviceId, 'authorization_code');

     --Create Role 'OPA Administrator' is not linked to any policies as per service request in TEST environment
     SET @roleId = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId, 'OPA Administrator', @serviceId, 1, GETDATE(), GETDATE(), 'opa_administrator', @numericId, NULL);

     --Create Role 'OPA End User' is not linked to any policies as per service request in TEST environment
     SET @roleId = NEWID();
     SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
     INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
     VALUES (@roleId, 'OPA End User', @serviceId, 1, GETDATE(), GETDATE(), 'opa_end_user', @numericId, NULL);

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
