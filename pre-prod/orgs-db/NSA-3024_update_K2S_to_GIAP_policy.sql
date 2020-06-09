BEGIN TRAN GIAPSERVICESPOLICYUPDATE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName_1 VARCHAR(500) = 'Get information about pupils - Organisations'
    DECLARE @policyId_1 UNIQUEIDENTIFIER;
    DECLARE @policyName_2 VARCHAR(500) = 'Get information about pupils - Establishments'
    DECLARE @policyId_2 UNIQUEIDENTIFIER;
    DECLARE @policyConditionId UNIQUEIDENTIFIER;

      -- Get Service Id based on name, if more than one found it will fail and go to catch block
      SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);
      IF (@serviceId IS NOT NULL)
          BEGIN
          -- Get Policy Id based on name, if more than one found it will fail and go to catch block
          SET @policyId_1 = (SELECT id FROM Policy WHERE ApplicationId = @serviceId AND Name = @policyName_1);
          IF (@policyId_1 IS NOT NULL)
              BEGIN
                  SET @policyConditionId = (SELECT id FROM PolicyCondition WHERE PolicyId = @policyId_1 AND Field = 'organisation.category.id' AND VALUE = '001');
                  IF (@policyConditionId IS NOT NULL)
                      --  Update Policy Conditions
                      DELETE FROM PolicyCondition
                          WHERE id = @policyConditionId;
              END;
          END;

          -- Get Policy Id based on name, if more than one found it will fail and go to catch block
          SET @policyId_2 = (SELECT id FROM Policy WHERE ApplicationId = @serviceId AND Name = @policyName_2);
          IF (@policyId_2 IS NOT NULL)
              BEGIN
                  INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                  VALUES  (NEWID(), @policyId_2, 'organisation.category.id', 'is', '001', GETDATE(), GETDATE());
              END;

    -- COMMIT TRAN IF NO  ERRORS
    ROLLBACK TRAN GIAPSERVICESPOLICYUPDATE;

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
          ROLLBACK TRAN GIAPSERVICESPOLICYUPDATE;

END CATCH;
