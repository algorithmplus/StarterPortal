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
                VALUES  (NEWID(), @policyId, 'organisation.id', 'is', 'd1375123-57a8-440f-b887-47c5705b3703', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', 'd38224a5-8636-4742-9126-270e155530f2', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', '25dedc79-03a0-4c9b-8772-75caef9432d9', GETDATE(), GETDATE()),
                        (NEWID(), @policyId, 'organisation.id', 'is', '62fafd5e-2c25-4214-91ad-1de69262820a', GETDATE(), GETDATE());

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
