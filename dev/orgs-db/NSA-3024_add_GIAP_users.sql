BEGIN TRAN GIAPUSERONBOARD

BEGIN TRY

     DECLARE @orgName NVARCHAR(500) = 'GIAS CMT';
     DECLARE @orgId UNIQUEIDENTIFIER;
     DECLARE @serviceName NVARCHAR(500) = 'Get information about pupils';
     DECLARE @serviceId UNIQUEIDENTIFIER;
     DECLARE @policyId UNIQUEIDENTIFIER;
     DECLARE @roleId UNIQUEIDENTIFIER;
     DECLARE @numericId BIGINT;

     --Create service
     SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'GIAP');
     IF (@serviceId IS NOT NULL)
         BEGIN;
         --Create Policy - GIAP Admin
         SET @policyId = NEWID();
         INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
         VALUES (@policyId, 'Get information about pupils - GIAP Admin', @serviceId, 1, GETDATE(), GETDATE());

         --Create Policy Conditions - GIAP Admin
         INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
         VALUES (NEWID(), @policyId, 'email', 'is', 'deka.adan@education.gov.uk', GETDATE(), GETDATE()),
                (NEWID(), @policyId, 'email', 'is', 'eoin.corr@digital.education.gov.uk', GETDATE(), GETDATE());

         --Create Role 'GIAP Admin' and link to policy
         SET @roleId = NEWID();
         SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
         INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
         VALUES (@roleId, 'GIAP Admin', @serviceId, 1, GETDATE(), GETDATE(), 'giap_admin', @numericId, NULL);

         INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
         VALUES (@policyId, @roleId, GETDATE(), GETDATE());

         --Add User Services and User Servcice Roles
         SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
         IF (@orgId IS NOT NULL)
             BEGIN;

                 INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                 VALUES (NEWID(), 1, '08902b35-cf33-4408-bdd4-b7688c91c943', @orgId, @serviceId, GETDATE(), GETDATE()),
                        (NEWID(), 1, '6e197380-a652-40fa-9124-1e110056b11f', @orgId, @serviceId, GETDATE(), GETDATE());

                 INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                 VALUES (NEWID(), '08902b35-cf33-4408-bdd4-b7688c91c943', @serviceId, @orgId, @roleId, GETDATE(), GETDATE()),
                        (NEWID(), '6e197380-a652-40fa-9124-1e110056b11f', @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

             END;
         END;
   --Commit transaction if all went fine
   ROLLBACK TRAN GIAPUSERONBOARD;

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
        ROLLBACK TRAN GIAPUSERONBOARD;

END CATCH;
