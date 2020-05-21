BEGIN TRAN ADDPUSERTOGIASBACKOFFICE

BEGIN TRY

DECLARE @userId UNIQUEIDENTIFIER = '9c961696-cbe4-40a9-b65c-847ad2ec75b6';
DECLARE @orgId UNIQUEIDENTIFIER = '7d48d8ff-a322-4f22-8a79-c0425ac69749';
DECLARE @serviceId UNIQUEIDENTIFIER = '2354cb2e-f559-4bf4-9981-4f6c6890aa5e';
DECLARE @roleId UNIQUEIDENTIFIER = 'a1dc17ea-695b-4063-8ed0-5d9fca01adbf'
DECLARE @policyId UNIQUEIDENTIFIER = '46df98bb-3b86-4e0a-9ac9-e22c70243640';

      -- Create Policy Condition
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'id', 'is', @userId, GETDATE(), GETDATE());

    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1, @userId, @orgId, @serviceId, GETDATE(), GETDATE());

    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

    ROLLBACK TRAN ADDPUSERTOGIASBACKOFFICE

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
          ROLLBACK TRAN ADDPUSERTOGIASBACKOFFICE;

END CATCH;
