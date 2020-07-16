BEGIN TRAN UPDATEGIAPADMINPOLICY

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Get information about pupils - GIAP Admin';
    DECLARE @policyId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId AND name = @policyName);
        IF (@policyId IS NOT NULL)

            BEGIN

                --Create Policy Conditions - Organisations
                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES  (NEWID(), @policyId, 'id', 'is', '6ef23475-d01a-4ebd-9799-d1cca18e4c78', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '71a1e765-aa9c-4c38-8e1e-a3c9e59fd5cf', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '47b9bc3f-e801-45e9-9b03-8b6ea33ed279', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', 'aee57e52-a228-4cd6-bca2-86440b4980db', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '59784071-a92d-4e07-92e8-d9cab5849b66', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '7b968220-f359-4bf7-a45a-c66162990692', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '66d05547-7f34-4294-b296-4b4f66f4192f', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '763e7ecb-a691-41de-a8f0-5589f511c332', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'id', 'is', '454ce01a-7136-4209-97d0-bd4e5f55fa46', GETDATE(), GETDATE());

            END;

        END;

    -- COMMIT TRAN IF NO ERRORS
    ROLLBACK TRAN UPDATEGIAPADMINPOLICY;

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
          ROLLBACK TRAN UPDATEGIAPADMINPOLICY;

END CATCH;
