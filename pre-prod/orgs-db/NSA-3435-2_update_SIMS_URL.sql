BEGIN TRAN UPDATESIMSURL

BEGIN TRY

    DECLARE @userId UNIQUEIDENTIFIER = '74d55f3e-925f-492f-ac91-ef8c0d6444e9';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @serviceId UNIQUEIDENTIFIER;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = 'Department for Education');
    IF (@orgId IS NOT NULL)

        BEGIN

        -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId = (SELECT id FROM service WHERE name = 'DfE Sign-in manage');
        IF (@serviceName IS NOT NULL)

            BEGIN

            SET @roleId = (SELECT id FROM Role WHERE name = 'SIMS Test - Service Configuration')
            IF (@roleId IS NOT NULL)

                BEGIN

                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                    VALUES (NEWID(), 1, @userId, @orgId, @serviceId, GETDATE(), GETDATE());

                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                    VALUES (NEWID(), @userId, @serviceId, @orgId, @roleId, GETDATE(), GETDATE());

                END;

            END;

        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN UPDATESIMSURL;

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
        ROLLBACK TRAN UPDATESIMSURL;

END CATCH;
