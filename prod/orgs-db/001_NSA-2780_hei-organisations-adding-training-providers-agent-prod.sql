BEGIN TRAN HEIOrgAccessPolicy
DECLARE @teacherEAAServiceId UNIQUEIDENTIFIER
DECLARE @covUniOrgId UNIQUEIDENTIFIER
DECLARE @boltonUniOrgId UNIQUEIDENTIFIER
DECLARE @bathUniOrgId UNIQUEIDENTIFIER
DECLARE @EAAProviderRoleId UNIQUEIDENTIFIER
DECLARE @policyid UNIQUEIDENTIFIER

    Set @covUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10001726' and URN = '133808');
    Set @boltonUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10006841' and URN = '133794');
    Set @bathUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10000571' and URN = '133790');
    Set @teacherEAAServiceId = (select top 1 id from [service] where Name = 'Teacher Services - Employer Access - Agent');
    Set @EAAProviderRoleId = (select top 1 Id from role where ApplicationId = @teacherEAAServiceId and Name= 'Teacher Services – Organisations');

    Set @policyid = newid();

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyid, 'Evolve - Employer Access - Training provider', @teacherEAAServiceId, 1,
    getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @policyid,'organisation.id', 'is', @covUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @policyid,'organisation.id', 'is', @boltonUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @policyid,'organisation.id', 'is', @bathUniOrgId, getdate(), getdate());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyid, @EAAProviderRoleId, GETDATE(), GETDATE());

ROLLBACK TRAN HEIOrgAccessPolicy
