BEGIN TRAN TLEVELSRESULTSCERTONBOARD

DECLARE @roleId UNIQUEIDENTIFIER;
DECLARE @policyId UNIQUEIDENTIFIER;
DECLARE @serviceId UNIQUEIDENTIFIER;
DECLARE @orgId UNIQUEIDENTIFIER;

--Create service
--TO DO obtain redirectUrl and post logout url
SET @serviceId = NEWID();
INSERT INTO service (id, name, description, clientId, clientSecret, apiSecret, tokenEndpointAuthMethod, serviceHome, postResetUrl, isExternalService, isMigrated, parentId, isChildService)
VALUES (@serviceId, 'T Level Results and Certification', 'T Level Results and Certification', 'TLevelsRC', NULL, NULL, 'client_secret_post', NULL, NULL, 1, 0, NULL, 0);
INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
VALUES (@serviceId, '');
INSERT INTO servicePostLogoutRedirectUris (serviceId, redirectUrl)
VALUES (@serviceId, '');
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
VALUES (NEWID(), @policyId, 'organisation.id', 'is', '72ed2dcb-7fa3-456c-9618-21f52c314d5', GETDATE(), GETDATE()),
        (NEWID(), @policyId, 'organisation.id', 'is', 'be17ddce-c8fd-45ce-b4b4-4a98faebc445', GETDATE(), GETDATE()),
        (NEWID(), @policyId, 'organisation.id', 'is', '180b2f48-129d-4400-a2e4-1aa820d8ba08', GETDATE(), GETDATE());

--Create Role 'Site Administrator' and link to policy
SET @roleId = NEWID();
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'Site Administrator', NEWID(), 1, GETDATE(), GETDATE(), 't_levels_site_admin', (SELECT MAX(NumericId) FROM Role) + 1, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Create Role 'T Levels Reviewer' and link to policy
SET @roleId = NEWID();
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'T Levels Reviewer', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_reviewer', (SELECT MAX(NumericId) FROM Role) + 1, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Create Role 'Providers Editor' and link to policy
SET @roleId = NEWID();
INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
VALUES (@roleId, 'Providers Editor', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_providers_editor', (SELECT MAX(NumericId) FROM Role) + 1, null);

INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
VALUES (@policyId, @roleId, GETDATE(), GETDATE());


ROLLBACK TRAN TLEVELSRESULTSCERTONBOARD
