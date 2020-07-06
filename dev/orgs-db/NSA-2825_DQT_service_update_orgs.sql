BEGIN TRAN ADDDQTORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER

    -- Pertemps Education Network Ltd
    SET @organisationId = NEWID();
    IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'Pertemps Education Network Ltd')

        BEGIN

          INSERT INTO organisation(id, name, Category, Status, Address, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'Pertemps Education Network Ltd', '008', 1, 'Suite 70, Waterhouse Business Centre, 2 Cromar Way Chelmsford, CM1 2QE', '3552384', GETDATE(), GETDATE());

        END;

    ROLLBACK TRAN ADDDQTORGS

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
              ROLLBACK TRAN ADDDQTORGS;
END CATCH;
