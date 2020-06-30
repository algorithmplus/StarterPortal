BEGIN TRAN TLEVELSSERVICEROLE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;
    DECLARE @pearsonOrgId UNIQUEIDENTIFIER;
    DECLARE @cityGuildsOrgId UNIQUEIDENTIFIER;


    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        --Role: MTC Service - Technical Support
        SET @roleId = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
            INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
            VALUES (@roleId, 'Registrations Editor', @serviceId, 1, GETDATE(), GETDATE(), 't_levels_registrations_editor', @numericId, NULL);

        -- Step 2) get policy Id based on name, if more than one found it will fail and go to catch block
        SET @policyId = (SELECT id FROM Policy WHERE ApplicationId = @serviceId);
        IF (@policyId IS NOT NULL)

            BEGIN

            --PolicyRole: Link Technical Support role for MTC service to MTC Internal roles policy

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId, @roleId, GETDATE(), GETDATE());

            END;

        END;

    ROLLBACK TRAN TLEVELSSERVICEROLE;

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
          ROLLBACK TRAN TLEVELSSERVICEROLE;

END CATCH;
