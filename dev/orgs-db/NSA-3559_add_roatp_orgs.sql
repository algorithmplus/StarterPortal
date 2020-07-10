BEGIN TRAN ADDROATPORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- CODERS GUILD LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10058030')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CODERS GUILD LTD', '051', 1, '10058030', @legacyId, GETDATE(), GETDATE());
        END;

        -- EDUCATION GOALS LTD
        SET @organisationId = NEWID();
        SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
          IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10083696')
            BEGIN
              INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
              VALUES(@organisationId, 'EDUCATION GOALS LTD', '051', 1, '10083696', @legacyId, GETDATE(), GETDATE());
            END;

    ROLLBACK TRAN ADDROATPORGS

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
          ROLLBACK TRAN ADDROATPORGS;

END CATCH;
