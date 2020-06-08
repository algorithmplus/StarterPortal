BEGIN TRAN ADDROATPORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- BRIGHT BEES NURSERY LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10066498')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'BRIGHT BEES NURSERY LTD', '051', 1, '10066498', @legacyId, GETDATE(), GETDATE());
        END;

    -- CELLAR TAPES UK LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085130')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CELLAR TAPES UK LTD', '051', 1, '10085130', @legacyId, GETDATE(), GETDATE());
        END;

    -- CORSERV LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10081883')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CORSERV LIMITED', '051', 1, '10081883', @legacyId, GETDATE(), GETDATE());
        END;

    -- GEOSEIS CONSULTANT LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10066420')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'GEOSEIS CONSULTANT LIMITED', '051', 1, '10066420', @legacyId, GETDATE(), GETDATE());
        END;

    -- JS CONSULT LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10048831')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'JS CONSULT LIMITED', '051', 1, '10048831', @legacyId, GETDATE(), GETDATE());
        END;

    -- KENT SCHOOL OF VETERINARY NURSING LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10066553')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'KENT SCHOOL OF VETERINARY NURSING LIMITED', '051', 1, '10066553', @legacyId, GETDATE(), GETDATE());
        END;

    -- LMJU LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085193')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'LMJU LIMITED', '051', 1, '10085193', @legacyId, GETDATE(), GETDATE());
        END;

    -- PHYSICAL EDUCATION & ACTIVE KIDS LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084933')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'PHYSICAL EDUCATION & ACTIVE KIDS LTD', '051', 1, '10084933', @legacyId, GETDATE(), GETDATE());
        END;

    -- RIVIERA TUITION LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10083548')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'RIVIERA TUITION LIMITED', '051', 1, '10083548', @legacyId, GETDATE(), GETDATE());
        END;

    -- SCHOOL OF MARKETING LONDON LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084871')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'SCHOOL OF MARKETING LONDON LTD', '051', 1, '10084871', @legacyId, GETDATE(), GETDATE());
        END;

    -- SEWELLS TRAINING AND CONSULTANCY LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10009922')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'SEWELLS TRAINING AND CONSULTANCY LIMITED', '051', 1, '10009922', @legacyId, GETDATE(), GETDATE());
        END;

    -- SKERN LODGE LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10005886')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'SKERN LODGE LIMITED', '051', 1, '10005886', @legacyId, GETDATE(), GETDATE());
        END;

    -- WE ARE IVE LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10064793')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'WE ARE IVE LTD', '051', 1, '10064793', @legacyId, GETDATE(), GETDATE());
        END;

    -- WE ARE MOMENTUM LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10083812')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'WE ARE MOMENTUM LIMITED', '051', 1, '10083812', @legacyId, GETDATE(), GETDATE());
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
