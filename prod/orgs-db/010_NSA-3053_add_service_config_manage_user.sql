BEGIN TRAN ADDSERVICECONFIGUSER

BEGIN TRY

  DECLARE @userId UNIQUEIDENTIFIER = '2b8145fc-00e6-44cd-9de5-3d1905e30767';
  DECLARE @orgId UNIQUEIDENTIFIER = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
  DECLARE @serviceId UNIQUEIDENTIFIER = 'b1f190aa-729a-45fc-a695-4ea209dc79d4';
  DECLARE @roleName VARCHAR(500) = 'T Level Results and Certification - Service Configuration';

      INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
      VALUES (NEWID(), 1, @userId,@orgId, @serviceId, GETDATE(), GETDATE());

    SET @roleId = (SELECT id FROM Role WHERE name = @roleName);

    IF (@roleId IS NOT NULL)
        BEGIN
            INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
            VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId, GETDATE(), GETDATE());
        END

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
          ROLLBACK TRAN ADDSERVICECONFIGUSER;

END CATCH;
