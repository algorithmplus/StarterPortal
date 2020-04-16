BEGIN TRAN ITTOrgAccessPolicy
DECLARE @teacherITTServiceId UNIQUEIDENTIFIER
DECLARE @covUniOrgId UNIQUEIDENTIFIER
DECLARE @boltonUniOrgId UNIQUEIDENTIFIER
DECLARE @bathUniOrgId UNIQUEIDENTIFIER
DECLARE @ITTProviderRoleId UNIQUEIDENTIFIER
DECLARE @ITTpolicyid UNIQUEIDENTIFIER

    Set @covUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10001726' and URN = '133808');
    Set @boltonUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10006841' and URN = '133794');
    Set @bathUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10000571' and URN = '133790');
    Set @teacherITTServiceId = (select top 1 id from [service] where Name = 'Teacher Services - ITT Provider');
    Set @ITTProviderRoleId = (select top 1 Id from role where ApplicationId = @teacherEAAServiceId and Name= 'ITT Provider');

    Set @ITTpolicyid = newid();

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@ITTpolicyid, 'Evolve - Training provider - orgs', @teacherITTServiceId, 1,
    getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @ITTpolicyid,'organisation.id', 'is', @covUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @ITTpolicyid,'organisation.id', 'is', @boltonUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @ITTpolicyid,'organisation.id', 'is', @bathUniOrgId, getdate(), getdate());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@ITTpolicyid, @ITTProviderRoleId, GETDATE(), GETDATE());

ROLLBACK TRAN ITTOrgAccessPolicy
