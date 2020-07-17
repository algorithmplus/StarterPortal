BEGIN TRAN ADDDQTORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- Educ8 Services Ltd
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'Educ8 Services Ltd')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, Address, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'Educ8 Services Ltd', '008', 1, '20-22 WenLock Road, London, N1 7GU', @legacyId, GETDATE(), GETDATE());
        END;

    -- Breakthrough In Education Ltd
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE name = 'Breakthrough In Education Ltd')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, Address, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'Breakthrough In Education Ltd', '008', 1, 'Manchester House, 113 Northgate Street, Bury Saint Edmunds, Suffolk, IP33 1HP', @legacyId, GETDATE(), GETDATE());
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
