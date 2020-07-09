BEGIN TRAN ADDROATPORGS

BEGIN TRY

    DECLARE @organisationId UNIQUEIDENTIFIER
    DECLARE @legacyId AS BIGINT;

    -- ACHIEVING FOR CHILDREN COMMUNITY INTEREST COMPANY
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10047071')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'ACHIEVING FOR CHILDREN COMMUNITY INTEREST COMPANY', '051', 1, '10047071', @legacyId, GETDATE(), GETDATE());
        END;

    -- BARTONWALSH HOLDINGS LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084018')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'BARTONWALSH HOLDINGS LIMITED', '051', 1, '10084018', @legacyId, GETDATE(), GETDATE());
        END;

    -- COMPASS SKILLS TRAINING LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10083267')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'COMPASS SKILLS TRAINING LIMITED', '051', 1, '10083267', @legacyId, GETDATE(), GETDATE());
        END;

    -- FOUNDERS & CODERS C.I.C.
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085696')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'FOUNDERS & CODERS C.I.C.', '051', 1, '10085696', @legacyId, GETDATE(), GETDATE());
        END;

    -- GLOBAL ATS LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10065771')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'GLOBAL ATS LIMITED', '051', 1, '10065771', @legacyId, GETDATE(), GETDATE());
        END;

    -- OPEN HEART CARE LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085048')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'OPEN HEART CARE LTD', '051', 1, '10085048', @legacyId, GETDATE(), GETDATE());
        END;

    --UNISERVE HOLDINGS LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085521')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'UNISERVE HOLDINGS LIMITED', '051', 1, '10085521', @legacyId, GETDATE(), GETDATE());
        END;

    -- WATERTON ACADEMY TRUST
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10060843')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'WATERTON ACADEMY TRUST', '051', 1, '10060843', @legacyId, GETDATE(), GETDATE());
        END;

    -- DEXTERS LONDON LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084602')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'DEXTERS LONDON LIMITED', '051', 1, '10084602', @legacyId, GETDATE(), GETDATE());
        END;

    -- MERCIA TRAINING LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084703')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'MERCIA TRAINING LTD', '051', 1, '10084703', @legacyId, GETDATE(), GETDATE());
        END;

    -- BRAILLARD TRAINING LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085310')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'BRAILLARD TRAINING LIMITED', '051', 1, '10085310', @legacyId, GETDATE(), GETDATE());
        END;

    -- CONVEY365 LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082851')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CONVEY365 LTD', '051', 1, '10082851', @legacyId, GETDATE(), GETDATE());
        END;

    -- PERSONAL TRAINER LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10034320')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'PERSONAL TRAINER LTD', '051', 1, '10034320', @legacyId, GETDATE(), GETDATE());
        END;

    -- SKILLS OFFICE NETWORK LTD
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082140')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'SKILLS OFFICE NETWORK LTD', '051', 1, '10082140', @legacyId, GETDATE(), GETDATE());
        END;

    -- TRAIN4WORK TRAINING SERVICES LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10061639')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'TRAIN4WORK TRAINING SERVICES LIMITED', '051', 1, '10061639', @legacyId, GETDATE(), GETDATE());
        END;

    -- CHILDBASE PARTNERSHIP LIMITED
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084678')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'CHILDBASE PARTNERSHIP LIMITED', '051', 1, '10084678', @legacyId, GETDATE(), GETDATE());
        END;

    -- THE CHIEF CONSTABLE OF SOUTH YORKSHIRE
    SET @organisationId = NEWID();
    SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;
      IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10063335')
        BEGIN
          INSERT INTO organisation(id, name, Category, Status, UKPRN, legacyId, createdAt, updatedAt)
          VALUES(@organisationId, 'THE CHIEF CONSTABLE OF SOUTH YORKSHIRE', '051', 1, '10063335', @legacyId, GETDATE(), GETDATE());
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
