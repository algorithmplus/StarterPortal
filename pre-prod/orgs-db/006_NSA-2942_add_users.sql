BEGIN TRAN ADDMANAGEUSER

BEGIN TRY

    DECLARE @orgId UNIQUEIDENTIFIER = '23f20e54-79ea-4146-8e39-18197576f023';
    DECLARE @serviceId UNIQUEIDENTIFIER = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
    DECLARE @roleId UNIQUEIDENTIFIER;

    --INSERT into User Services
        INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
        VALUES (NEWID(), 1,'43e35af8-e8fd-4150-91e7-132e5be9f34c', @orgId, @serviceId, GETDATE(), GETDATE());
        INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
        VALUES (NEWID(), 1,'11ec7a28-342f-47a9-808d-bec31252c6ec', @orgId, @serviceId, GETDATE(), GETDATE());

    --Teacher Services - Employer Access - Agent
    --INSERT into User Services Roles
    SET @roleId = 'bc521f6f-65ee-4edb-a762-0012bdc1f110';
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    --Teacher Services - Employer Access - Schools
    --INSERT into User Services Roles
    SET @roleId = 'e14a978d-8cbc-4730-a067-7756e1e506e7';
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    --Teacher Services - Appropriate Body
    --INSERT into User Services Roles
    SET @roleId = '35ddaa8b-4549-4a63-a537-d73d348ca494';
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    --Teacher Services - ITT Provider
    --INSERT into User Services Roles
    SET @roleId = 'aadce938-75c0-4176-ab87-58c3f00488af';
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '43e35af8-e8fd-4150-91e7-132e5be9f34c', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());
        INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
        VALUES (NEWID(), '11ec7a28-342f-47a9-808d-bec31252c6ec', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    ROLLBACK TRAN ADDMANAGEUSER
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
          ROLLBACK TRAN ADDMANAGEUSER;

END CATCH;
