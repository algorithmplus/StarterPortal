BEGIN TRAN MTCSERVICEMANAGEUSER

BEGIN TRY

DECLARE @userId_1 UNIQUEIDENTIFIER = '1ed5ac78-628c-4658-9211-e4025e16f89f';
DECLARE @userId_2 UNIQUEIDENTIFIER = '496b4c62-24f1-4c1e-95a0-d6184ea1b02a';
DECLARE @userId_3 UNIQUEIDENTIFIER = '4c8424bd-95ff-46ce-9a0b-fb5a743a143f';
DECLARE @orgId UNIQUEIDENTIFIER = '23f20e54-79ea-4146-8e39-18197576f023';
DECLARE @serviceId UNIQUEIDENTIFIER = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
DECLARE @roleId_1 UNIQUEIDENTIFIER = 'dec9aac6-6211-4742-a78d-270142af3f91';
DECLARE @roleId_2 UNIQUEIDENTIFIER = 'f21f8cde-95bf-4000-963e-30bdc51ca822';


    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1, @userId_1, @orgId, @serviceId, GETDATE(), GETDATE()),
           (NEWID(), 1, @userId_2, @orgId, @serviceId, GETDATE(), GETDATE()),
           (NEWID(), 1, @userId_3, @orgId, @serviceId, GETDATE(), GETDATE());

    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), @userId_1, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
           (NEWID(), @userId_1, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
           (NEWID(), @userId_2, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
           (NEWID(), @userId_2, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE()),
           (NEWID(), @userId_3, @serviceId, @orgId, @roleId_1, GETDATE(), GETDATE()),
           (NEWID(), @userId_3, @serviceId, @orgId, @roleId_2, GETDATE(), GETDATE());

    ROLLBACK TRAN MTCSERVICEMANAGEUSER

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
          ROLLBACK TRAN MTCSERVICEMANAGEUSER;

END CATCH;
