BEGIN TRAN MTCSERVICEROLE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Multiplication tables check';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyName VARCHAR(500) = 'MTC Internal roles';
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @roleName VARCHAR(500) = 'Technical Support';
    DECLARE @roleId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        -- Step 2) get policy Id based on name, if more than one found it will fail and go to catch block
        SET @policyId = (SELECT id FROM Policy WHERE Name = @policyName);
        IF (@policyId IS NOT NULL)

            BEGIN

            -- Step 3) get role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId = (SELECT id FROM Role WHERE Name = @roleName);
            IF (@roleId IS NOT NULL)

                BEGIN

                --PolicyRole: Link Technical Support role for MTC service to MTC Internal roles policy

                    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

                END;

            END;

        END;

    ROLLBACK TRAN MTCSERVICEROLE;

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
          ROLLBACK TRAN MTCSERVICEROLE;

END CATCH;
