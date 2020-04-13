BEGIN TRAN ADDORSPP
DECLARE @organisationId uniqueidentifier
-- New Gibson MAT Large
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson MAT Large', '013', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '77001500', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
-- New Gibson MAT Small
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson MAT Small', '013', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '77000400', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
-- New Gibson SAT
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Gibson SAT', '010', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '77000100', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
-- New Aldgate MAT Large
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate MAT Large', '013', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '88001500', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
-- New Aldgate MAT Small
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate MAT Small', '013', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '88000400', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
-- New Aldgate SAT
SET @organisationId = NEWID()
INSERT INTO organisation(id, name, Category, Status, legacyId, companyRegistrationNumber, createdAt, updatedAt)
VALUES(@organisationId, 'Aldgate SAT', '010', 1, (select next_value from counters where counter_name = 'organisation_legacyid'), '88000100', GETDATE(), GETDATE());
update counters set next_value = (select next_value + 1 from counters where counter_name = 'organisation_legacyid') where counter_name = 'organisation_legacyid';
ROLLBACK TRAN ADDORSPP
