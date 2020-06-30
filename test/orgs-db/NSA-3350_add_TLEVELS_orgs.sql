BEGIN TRAN ADDTLEVELSORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- PEARSON EDUCATION LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'PEARSON EDUCATION LIMITED')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'PEARSON EDUCATION LIMITED', '051', 1, '10022490', @legacyId, GETDATE(), GETDATE());
        END;

    -- CITY AND GUILDS OF LONDON INSTITUTE
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'CITY AND GUILDS OF LONDON INSTITUTE')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CITY AND GUILDS OF LONDON INSTITUTE', '051', 1, '10009931', @legacyId, GETDATE(), GETDATE());
        END;

    ROLLBACK TRAN ADDTLEVELSORGS

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
              ROLLBACK TRAN ADDTLEVELSORGS;
END CATCH;
