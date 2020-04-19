BEGIN TRAN ADDPMANAGEUSER

DECLARE @orgId UNIQUEIDENTIFIER
DECLARE @serviceId UNIQUEIDENTIFIER
DECLARE @roleId UNIQUEIDENTIFIER
--Teacher Services - Employer Access - Agent
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = '40b35632-0510-4440-9e9c-adecab61d31e';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'ec8d1e57-9645-4fa8-a360-c790944c056e','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'bbf3261c-9c9c-46a8-bdea-c86fd63391a2','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'7ea0a96c-986c-4f8b-abd9-942d344ed5e9','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'ec8d1e57-9645-4fa8-a360-c790944c056e', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'bbf3261c-9c9c-46a8-bdea-c86fd63391a2', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '7ea0a96c-986c-4f8b-abd9-942d344ed5e9', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - Employer Access - Schools
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = '5b78be3d-6c78-4c5a-9ed4-05465dd9e379';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'ec8d1e57-9645-4fa8-a360-c790944c056e','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'bbf3261c-9c9c-46a8-bdea-c86fd63391a2','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'7ea0a96c-986c-4f8b-abd9-942d344ed5e9','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'ec8d1e57-9645-4fa8-a360-c790944c056e', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'bbf3261c-9c9c-46a8-bdea-c86fd63391a2', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '7ea0a96c-986c-4f8b-abd9-942d344ed5e9', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - Appropriate Body
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = 'bb4ac13a-6ba4-48b3-973e-2e5f9589a6e3';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'ec8d1e57-9645-4fa8-a360-c790944c056e','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'bbf3261c-9c9c-46a8-bdea-c86fd63391a2','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'7ea0a96c-986c-4f8b-abd9-942d344ed5e9','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'ec8d1e57-9645-4fa8-a360-c790944c056e', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'bbf3261c-9c9c-46a8-bdea-c86fd63391a2', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '7ea0a96c-986c-4f8b-abd9-942d344ed5e9', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

--Teacher Services - ITT Provider
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
SET @serviceId = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
SET @roleId = 'f620b42d-7f36-4175-985c-7761756a4749';
--INSERT into User Services
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'ec8d1e57-9645-4fa8-a360-c790944c056e','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'bbf3261c-9c9c-46a8-bdea-c86fd63391a2','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4','@orgId', '@serviceId', GETDATE(), GETDATE());
    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'7ea0a96c-986c-4f8b-abd9-942d344ed5e9','@orgId', '@serviceId', GETDATE(), GETDATE());
--INSERT into User Services Roles
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'ec8d1e57-9645-4fa8-a360-c790944c056e', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'bbf3261c-9c9c-46a8-bdea-c86fd63391a2', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), 'fb9c75a9-f163-4b9f-af3d-6b2f06af3db4', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());
    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '7ea0a96c-986c-4f8b-abd9-942d344ed5e9', 'serviceId', '@orgId', 'roleId', GETDATE(), GETDATE());

ROLLBACK TRAN ADDPMANAGEUSER
