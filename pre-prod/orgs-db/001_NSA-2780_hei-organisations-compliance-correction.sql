BEGIN TRAN correctHEIPolicy

    DECLARE @policyid UNIQUEIDENTIFIER
    SET @policyid = newid();

    DELETE from PolicyCondition where PolicyId='e96db78f-819e-4350-9e65-f4938410680e' and Field in ('organisation.category.id','organisation.status.id')

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyid, 'Evolve - Training provider category', '0d15c5bd-ca2f-4211-b789-853bb34ce884', 1,
    getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyid, 'organisation.category.id', 'is', '009', GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyid, 'organisation.status.id', 'is', '1', GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyid, 'organisation.status.id', 'is', '3', GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, '92c701bc-c09b-45b3-91b9-2dac5e5d3f32', GETDATE(), GETDATE());

ROLLBACK TRAN correctHEIPolicy
