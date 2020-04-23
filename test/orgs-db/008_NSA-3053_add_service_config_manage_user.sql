BEGIN TRAN ADDSERVICECONFIGUSER

BEGIN TRY

DECLARE @userId UNIQUEIDENTIFIER = '8acb6411-af2b-4c5f-9262-2fb5fa641536';
DECLARE @orgId UNIQUEIDENTIFIER = '09158cf5-a701-47e8-bdcd-4ea201b024a3';
DECLARE @serviceId UNIQUEIDENTIFIER = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
DECLARE @roleId UNIQUEIDENTIFIER = 'b768a8e9-d4ec-4f97-91f4-f8ec2a5e250e';

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
