BEGIN TRAN GIAPMANAGEROLEUPDATE

BEGIN TRY

    DECLARE @roleNameToUpdate_1 VARCHAR(500) = 'Key to Success 2.0 - Service Access Management';
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleNameToUpdate_2 VARCHAR(500) = 'Key to Success 2.0 - Service Support';
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleNameToUpdate_3 VARCHAR(500) = 'Key to Success 2.0 - Service Configuration';
    DECLARE @roleId_3 UNIQUEIDENTIFIER;
    DECLARE @roleNameToUpdate_4 VARCHAR(500) = 'Key to Success 2.0 - Service Banner';
    DECLARE @roleId_4 UNIQUEIDENTIFIER;

    -- Step 1) get role Id based on name, if more than one found it will fail and go to catch block
    SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleNameToUpdate_1);
    IF (@roleId_1 IS NOT NULL)

        BEGIN

            UPDATE Role
            SET name = 'Get information about pupils - Service Access Management', updatedAt = GETDATE()
            WHERE id= @roleId_1;

        END;

        SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleNameToUpdate_2);
        IF (@roleId_2 IS NOT NULL)

            BEGIN

                UPDATE Role
                SET name = 'Get information about pupils - Service Support', updatedAt = GETDATE()
                WHERE id= @roleId_2;

            END;

        SET @roleId_3 = (SELECT id FROM Role WHERE name = @roleNameToUpdate_3);
        IF (@roleId_3 IS NOT NULL)

            BEGIN

                UPDATE Role
                SET name = 'Get information about pupils - Service Configuration', updatedAt = GETDATE()
                WHERE id= @roleId_3;

            END;

        SET @roleId_4 = (SELECT id FROM Role WHERE name = @roleNameToUpdate_4);
        IF (@roleId_4 IS NOT NULL)

            BEGIN

                UPDATE Role
                SET name = 'Get information about pupils - Service Banner', updatedAt = GETDATE()
                WHERE id= @roleId_4;

            END;

    ROLLBACK TRAN GIAPMANAGEROLEUPDATE;

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
          ROLLBACK TRAN GIAPMANAGEROLEUPDATE;

END CATCH;
