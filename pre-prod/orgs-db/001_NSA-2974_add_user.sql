BEGIN TRAN ADDPOLICYFORUSER
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), '0e49752e-8b2f-48d0-b2d7-51eaa399891f', 'email', 'is', 'chris.wadsworth@digital.education.gov.uk', GETDATE(), GETDATE());
ROLLBACK TRAN ADDPOLICYFORUSER
