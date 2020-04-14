BEGIN TRAN ADDORSPP
DECLARE @organisationId uniqueidentifier
-- New Gibson MAT Large
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson MAT Large', '013', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '77001500', GETDATE(), GETDATE());

-- New Gibson MAT Small
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson MAT Small', '013', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '77000400', GETDATE(), GETDATE());

-- New Gibson SAT
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson SAT', '010', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '77000100', GETDATE(), GETDATE());

-- New Aldgate MAT Large
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate MAT Large', '013', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '88001500', GETDATE(), GETDATE());

-- New Aldgate MAT Small
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate MAT Small', '013', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '88000400', GETDATE(), GETDATE());

-- New Aldgate SAT
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate SAT', '010', 1, (SELECT NEXT VALUE FOR org_legacy_id_sequence AS numId), '88000100', GETDATE(), GETDATE());

ROLLBACK TRAN ADDORSPP
