BEGIN TRAN ADDMANAGEUSER

DECLARE @orgId UNIQUEIDENTIFIER
DECLARE @serviceId UNIQUEIDENTIFIER
DECLARE @roleId UNIQUEIDENTIFIER

--Teacher Services - Employer Access - Agent
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = 'bc521f6f-65ee-4edb-a762-0012bdc1f110';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'43e35af8-e8fd-4150-91e7-132e5be9f34c','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'11ec7a28-342f-47a9-808d-bec31252c6ec','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - Employer Access - Schools
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = 'e14a978d-8cbc-4730-a067-7756e1e506e7';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'43e35af8-e8fd-4150-91e7-132e5be9f34c','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'11ec7a28-342f-47a9-808d-bec31252c6ec','@orgId', '@serviceId', GETDATE(), GETDATE());
  --INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - Appropriate Body
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = '35ddaa8b-4549-4a63-a537-d73d348ca494';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'43e35af8-e8fd-4150-91e7-132e5be9f34c','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'11ec7a28-342f-47a9-808d-bec31252c6ec','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - ITT Provider
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = 'aadce938-75c0-4176-ab87-58c3f00488af';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'43e35af8-e8fd-4150-91e7-132e5be9f34c','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'11ec7a28-342f-47a9-808d-bec31252c6ec','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

ROLLBACK TRAN ADDMANAGEUSER
