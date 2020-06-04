BEGIN TRAN ADDPUSERTOGIASBACKOFFICE

BEGIN TRY

DECLARE @userId_1 UNIQUEIDENTIFIER = '621B83C6-7D14-498C-A236-466C78BD160C';
DECLARE @userId_2 UNIQUEIDENTIFIER = '631295A2-6AF8-405A-9022-41ACC43E1A43';
DECLARE @userId_3 UNIQUEIDENTIFIER = '148EDDCD-5668-41C5-BEF0-D874F343AAF6';
DECLARE @orgId UNIQUEIDENTIFIER = 'e7c403e2-ac6f-42b1-b6b5-bcd449710b52';
DECLARE @serviceId UNIQUEIDENTIFIER = '2354cb2e-f559-4bf4-9981-4f6c6890aa5e';
DECLARE @roleId_1 UNIQUEIDENTIFIER = '76a127ed-769f-4760-b16d-a76e9055794b';
DECLARE @roleId_2 UNIQUEIDENTIFIER = 'a1dc17ea-695b-4063-8ed0-5d9fca01adbf';
DECLARE @policyId_1 UNIQUEIDENTIFIER = '46df98bb-3b86-4e0a-9ac9-e22c70243640';
DECLARE @policyId_2 UNIQUEIDENTIFIER = '88df18ad-7a0f-4617-ba76-13f48ae3149e';

      -- Create Policy Condition
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId_1, 'id', 'is', @userId_1, GETDATE(), GETDATE()),
           (NEWID(), @policyId_2, 'id', 'is', @userId_1, GETDATE(), GETDATE()),
           (NEWID(), @policyId_1, 'id', 'is', @userId_2, GETDATE(), GETDATE()),
           (NEWID(), @policyId_2, 'id', 'is', @userId_2, GETDATE(), GETDATE()),
           (NEWID(), @policyId_1, 'id', 'is', @userId_3, GETDATE(), GETDATE()),
           (NEWID(), @policyId_2, 'id', 'is', @userId_3, GETDATE(), GETDATE());

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
