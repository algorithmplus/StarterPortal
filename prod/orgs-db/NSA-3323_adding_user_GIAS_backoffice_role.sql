BEGIN TRAN ADDPUSERTOGIASBACKOFFICE

BEGIN TRY

DECLARE @userId UNIQUEIDENTIFIER = '9C961696-CBE4-40A9-B65C-847AD2EC75B6';
DECLARE @orgId UNIQUEIDENTIFIER = 'e7c403e2-ac6f-42b1-b6b5-bcd449710b52';
DECLARE @serviceId UNIQUEIDENTIFIER = '2354cb2e-f559-4bf4-9981-4f6c6890aa5e';
DECLARE @roleId UNIQUEIDENTIFIER = 'a1dc17ea-695b-4063-8ed0-5d9fca01adbf';
DECLARE @policyId_1 UNIQUEIDENTIFIER = '46df98bb-3b86-4e0a-9ac9-e22c70243640';
DECLARE @policyId_2 UNIQUEIDENTIFIER = '88df18ad-7a0f-4617-ba76-13f48ae3149e';

      -- Create Policy Condition
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId_1, 'id', 'is', @userId, GETDATE(), GETDATE()),
           (NEWID(), @policyId_2, 'id', 'is', @userId, GETDATE(), GETDATE());

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
