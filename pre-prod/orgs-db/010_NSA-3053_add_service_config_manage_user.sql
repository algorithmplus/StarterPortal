BEGIN TRAN ADDSERVICECONFIGUSER

BEGIN TRY

DECLARE @userId UNIQUEIDENTIFIER = '07bfc5d0-bd40-4b61-9617-07455d4068cc';
DECLARE @orgId UNIQUEIDENTIFIER = '23f20e54-79ea-4146-8e39-18197576f023';
DECLARE @serviceId UNIQUEIDENTIFIER = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
DECLARE @roleId UNIQUEIDENTIFIER = '541dbfe9-6cd1-4a51-bcf1-36620c791f2fe';

    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1, @userId,@orgId, @serviceId, GETDATE(), GETDATE());

    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    ROLLBACK TRAN ADDSERVICECONFIGUSER

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
          ROLLBACK TRAN TLEVELSRESULTSCERTONBOARD;

END CATCH;
