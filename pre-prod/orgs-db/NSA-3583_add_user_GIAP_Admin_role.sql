BEGIN TRAN GIAPUSER

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Get information about pupils - GIAP Admin'
    DECLARE @policyId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId and Name = @policyName);
        IF (@policyId IS NOT NULL)

            BEGIN

                --Create Policy Condition
                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES  (NEWID(), @policyId, 'id', 'is', 'ee63ff19-3abe-460c-8783-183185bf03a1', GETDATE(), GETDATE());


            END;

        END;

    ROLLBACK TRAN GIAPUSER;

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
          ROLLBACK TRAN GIAPUSER;

END CATCH;
