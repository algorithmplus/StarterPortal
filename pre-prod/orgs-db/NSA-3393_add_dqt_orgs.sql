BEGIN TRAN ADDDQTORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- Edvantage LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'Edvantage LTD')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, Address, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'Edvantage LTD', '008', 1, 'The Dower House, 108 High Street, Berkhamsted, Herts, HP4 2BL', @legacyId, GETDATE(), GETDATE());
        END;

    -- Supply Well Limited
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'Supply Well Limited')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, Address, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'Supply Well Limited', '008', 1, '7th Floor, 4 St Pauls Square, Liverpool, L3 9SJ', @legacyId, GETDATE(), GETDATE());
        END;

    Commit TRAN ADDDQTORGS

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
