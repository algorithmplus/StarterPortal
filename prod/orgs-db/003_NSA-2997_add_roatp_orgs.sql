BEGIN TRAN ADDROATPORGS

DECLARE @organisationId UNIQUEIDENTIFIER
DECLARE @legacyId AS BIGINT;

SET @organisationId = NEWID()
SET @legacyId = NEXT VALUE FOR org_legacy_id_sequence;

-- PLYMOUTH ARGYLE FOOTBALL IN THE COMMUNITY TRUST
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10035178')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'PLYMOUTH ARGYLE FOOTBALL IN THE COMMUNITY TRUST', '051', 1, '10035178', @legacyId, GETDATE(), GETDATE());
    END;

-- UK COLLEGE OF BUSINESS
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10047502')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'UK COLLEGE OF BUSINESS', '051', 1, '10047502', @legacyId, GETDATE(), GETDATE());
    END;

-- NCH AT NORTHEASTERN LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10048199')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'NCH AT NORTHEASTERN LIMITED', '051', 1, '10048199', @legacyId, GETDATE(), GETDATE());
    END;

-- PRAGMATIC CONSULTING LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10056336')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'PRAGMATIC CONSULTING LIMITED', '051', 1, '10056336', @legacyId, GETDATE(), GETDATE());
    END;

-- INFRATEC-UK LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10061558')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'INFRATEC-UK LIMITED', '051', 1, '10061558', @legacyId, GETDATE(), GETDATE());
    END;

-- BROOKS AND KIRK (ASSESSOR TRAINING) LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10062398')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'BROOKS AND KIRK (ASSESSOR TRAINING) LIMITED', '051', 1, '10062398', @legacyId, GETDATE(), GETDATE());
    END;

-- LEARNING CURVE (DEVELOPMENT) LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10063806')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'LEARNING CURVE (DEVELOPMENT) LIMITED', '051', 1, '10063806', @legacyId, GETDATE(), GETDATE());
    END;

-- A W JENKINSON TRANSPORT LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10064431')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'A W JENKINSON TRANSPORT LIMITED', '051', 1, '10064431', @legacyId, GETDATE(), GETDATE());
    END;

-- LEAN CONSTRUCT LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10065010')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'LEAN CONSTRUCT LIMITED', '051', 1, '10065010', @legacyId, GETDATE(), GETDATE());
    END;

-- KIDS PLANET DAY NURSERIES LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10066783')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'KIDS PLANET DAY NURSERIES LIMITED', '051', 1, '10066783', @legacyId, GETDATE(), GETDATE());
    END;

-- UTOPY C.I.C.
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10068386')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'UTOPY C.I.C.', '051', 1, '10068386', @legacyId, GETDATE(), GETDATE());
    END;

-- HOLLAND & BARRETT RETAIL LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10081176')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'HOLLAND & BARRETT RETAIL LIMITED', '051', 1, '10081176', @legacyId, GETDATE(), GETDATE());
    END;

-- CVP CONSULT LTD
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082269')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'CVP CONSULT LTD', '051', 1, '10082269', @legacyId, GETDATE(), GETDATE());
    END;

-- BISHOP FLEMING LLP
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082311')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'BISHOP FLEMING LLP', '051', 1, '10082311', @legacyId, GETDATE(), GETDATE());
    END;

-- SAPPHIRE LOGISTICS & CONSULTANCY LTD
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082452')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'SAPPHIRE LOGISTICS & CONSULTANCY LTD', '051', 1, '10082452', @legacyId, GETDATE(), GETDATE());
    END;

-- SOCIAL CHAIN LTD
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10082827')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'SOCIAL CHAIN LTD', '051', 1, '10082827', @legacyId, GETDATE(), GETDATE());
    END;

-- A-SAFE UK LTD
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10083474')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'A-SAFE UK LTD', '051', 1, '10083474', @legacyId, GETDATE(), GETDATE());
    END;

-- FORUM FOR SUSTAINABLE NEW VENTURE
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084420')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'FORUM FOR SUSTAINABLE NEW VENTURE', '051', 1, '10084420', @legacyId, GETDATE(), GETDATE());
    END;

-- BLUE LION LEARNING LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084461')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'BLUE LION LEARNING LIMITED', '051', 1, '10084461', @legacyId, GETDATE(), GETDATE());
    END;

-- BROWNS STAMFORD LTD
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084572')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'BROWNS STAMFORD LTD', '051', 1, '10084572', @legacyId, GETDATE(), GETDATE());
    END;

-- GYM FREE LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084785')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'GYM FREE LIMITED', '051', 1, '10084785', @legacyId, GETDATE(), GETDATE());
    END;

-- MARSHALL OF CAMBRIDGE (HOLDINGS) LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084918')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'MARSHALL OF CAMBRIDGE (HOLDINGS) LIMITED', '051', 1, '10084918', @legacyId, GETDATE(), GETDATE());
    END;

-- UNIVERSITY HOSPITALS OF DERBY AND BURTON NHS FOUNDATION TRUST
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10084937')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'UNIVERSITY HOSPITALS OF DERBY AND BURTON NHS FOUNDATION TRUST', '051', 1, '10084937', @legacyId, GETDATE(), GETDATE());
    END;

-- LONDON NORTH EASTERN RAILWAY LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085306')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'LONDON NORTH EASTERN RAILWAY LIMITED', '051', 1, '10085306', @legacyId, GETDATE(), GETDATE());
    END;

-- NORTHERN TRAINS LIMITED
  IF NOT EXISTS (SELECT * FROM organisation WHERE UKPRN = '10085493')
    BEGIN
      INSERT INTO organisation(id, name, Category, UKPRN, Status, legacyId, createdAt, updatedAt)
      VALUES(@organisationId, 'NORTHERN TRAINS LIMITED', '051', 1, '10085493', @legacyId, GETDATE(), GETDATE());
    END;

ROLLBACK TRAN ADDROATPORGS
