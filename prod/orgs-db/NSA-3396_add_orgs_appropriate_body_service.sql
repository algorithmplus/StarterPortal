BEGIN TRAN ADDORGSDQT

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Teacher Services - Appropriate Body';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'Evolve - Appropriate body';
    DECLARE @policyId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        -- Step 2) get policy Id based on name, if more than one found it will fail and go to catch block
        SET @policyId = (SELECT id FROM Policy WHERE Name = @policyName);
        IF (@policyId IS NOT NULL)

            BEGIN

            --Add new organisation to

                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES  (NEWID(), @policyId, 'organisation.id', 'is', 'a377dc43-496b-4ad1-9156-01b7abedc62a', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', '30a36ab3-ac7c-453d-be39-0fc4427ef5a4', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', '710e3855-ff32-40aa-8ade-668b49106380', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', '9e75a2cf-6339-41e0-bb04-bcc9c9890dcd', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', 'd0187dd1-6b96-48cd-8681-dedfbaba3265', GETDATE(), GETDATE());

            END;

        END;

    ROLLBACK TRAN ADDORGSDQT;

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
          ROLLBACK TRAN ADDORGSDQT;

END CATCH;
