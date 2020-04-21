BEGIN TRAN TLEVELSRESULTSCERTONBOARD

DECLARE @roleId UNIQUEIDENTIFIER;
DECLARE @policyId UNIQUEIDENTIFIER;
DECLARE @serviceId UNIQUEIDENTIFIER;
DECLARE @orgId UNIQUEIDENTIFIER;
DECLARE @manageId UNIQUEIDENTIFIER;
DECLARE @numericId BIGINT;

DECLARE @ncfeOrgId UNIQUEIDENTIFIER = '1c058b23-1d46-422e-bc6d-34a04d7a7e7d';
DECLARE @pearsonOrgId UNIQUEIDENTIFIER = 'b79a7d27-c62c-48b1-8ef7-fd16b8e737a9';
DECLARE @cityGuildsOrgId UNIQUEIDENTIFIER = '7e9e54e6-3524-4e3a-b467-2c2fa12c732b';

--Create service
SET @serviceId = NEWID();
INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
VALUES (@serviceId, 'T Level Results and Certification', 'T Level Results and Certification', 'TLevelsRC', NULL, NULL, 'client_secret_post', 'https://manage-tlevel-results.tlevels.gov.uk/Dashboard', NULL, 1, 0, NULL, 0);
INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
VALUES (@serviceId, 'https://manage-tlevel-results.tlevels.gov.uk/auth/cb');
INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
VALUES (@serviceId, 'https://manage-tlevel-results.tlevels.gov.uk/signout/complete');
INSERT INTO serviceParams (serviceId, paramName, paramValue)
VALUES (@serviceId, 'allowManageInvite', 'true');
INSERT INTO serviceGrantTypes (serviceId, grantType)
VALUES (@serviceId, 'authorization_code');

--Create Policy
SET @policyId = NEWID();
INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
VALUES (@policyId, 'T Levels and Certification', @serviceId, 1, GETDATE(), GETDATE());

--Create Policy Conditions
INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
VALUES (NEWID(), @policyId, 'organisation.id', 'is', @ncfeOrgId, GETDATE(), GETDATE()),
        (NEWID(), @policyId, 'organisation.id', 'is', @pearsonOrgId, GETDATE(), GETDATE()),
        (NEWID(), @policyId, 'organisation.id', 'is', @cityGuildsOrgId, GETDATE(), GETDATE());

--Create Role 'Site Administrator' and link to policy
SET @roleId = NEWID();
SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'Site Administrator', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_site_admin', @numericId, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Create Role 'T Levels Reviewer' and link to policy
SET @roleId = NEWID();
SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'T Levels Reviewer', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_reviewer', @numericId, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Create Role 'Providers Editor' and link to policy
SET @roleId = NEWID();
SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'Providers Editor', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_providers_editor', @numericId, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());

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

ROLLBACK TRAN TLEVELSRESULTSCERTONBOARD