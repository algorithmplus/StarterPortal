BEGIN TRAN ADDPUSERTOGIASBACKOFFICEPOLICY

BEGIN TRY

    DECLARE @policyId_One UNIQUEIDENTIFIER;
    DECLARE @policyId_Two UNIQUEIDENTIFIER;

        SET @policyId_One = '88df18ad-7a0f-4617-ba76-13f48ae3149e';
            -- Create Policy Condition
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES (NEWID(), @policyId_One, 'email', 'is', 'maggie.swinden@education.gov.uk', GETDATE(), GETDATE());

        SET @policyId_Two = '46df98bb-3b86-4e0a-9ac9-e22c70243640';
              -- Create Policy Condition
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES (NEWID(), @policyId_Two, 'email', 'is', 'maggie.swinden@education.gov.uk', GETDATE(), GETDATE());

    -- COMMIT TRAN IF NO ERRORS
    ROLLBACK TRAN ADDPUSERTOGIASBACKOFFICEPOLICY;

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
          ROLLBACK TRAN ADDPUSERTOGIASBACKOFFICEPOLICY;

END CATCH;
