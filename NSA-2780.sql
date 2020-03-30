BEGIN TRAN UPDATEHEIPOLICYCONDITIONS

    DECLARE @covUniOrgId UNIQUEIDENTIFIER
    DECLARE @boltonUniOrgId UNIQUEIDENTIFIER
    DECLARE @bathUniOrgId UNIQUEIDENTIFIER

    DECLARE @teacherITTServiceId UNIQUEIDENTIFIER
    DECLARE @teacherEmpServiceId UNIQUEIDENTIFIER

    DECLARE @ittProviderRoleId UNIQUEIDENTIFIER
    DECLARE @evolveEmpMatRoleId UNIQUEIDENTIFIER

    DECLARE @evolveITrainingProviderPolicy UNIQUEIDENTIFIER
    DECLARE @evolveEmpMatPolicyId UNIQUEIDENTIFIER
    DECLARE @evolveEmpPolicyId UNIQUEIDENTIFIER

    Set @covUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10001726' and URN = '133808');
    Set @boltonUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10006841' and URN = '133794');
    Set @bathUniOrgId = (select top 1 Id from [organisation] where UKPRN = '10000571' and URN = '133790');


    Set @teacherITTServiceId = (select top 1 id from [service] where Name = 'Teacher Services - ITT Provider');
    Set @ittProviderRoleId = (select top 1 Id from role where ApplicationId = @teacherITTServiceId and Name= 'ITT Provider');
    Set @evolveITrainingProviderPolicy = (select top 1 Id from policy where ApplicationId=@teacherITTServiceId and Name = 'Evolve - Training provider')

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveITrainingProviderPolicy,'organisation.id', 'is', @covUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveITrainingProviderPolicy,'organisation.id', 'is', @boltonUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveITrainingProviderPolicy,'organisation.id', 'is', @bathUniOrgId, getdate(), getdate());


    Set @teacherEmpServiceId = (select top 1 id from [service] where Name = 'Teacher Services - Employer Access - Agent');
    Set @evolveEmpMatRoleId = (select top 1 Id from role where ApplicationId = @teacherEmpServiceId and Name= 'Evolve - Employer Access - Agent MAT');
    Set @evolveEmpMatPolicyId = (select top 1 Id from policy where ApplicationId=@teacherEmpServiceId and Name = 'Evolve - Employer Access - Agent MAT')

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpMatPolicyId,'organisation.id', 'is', @covUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpMatPolicyId,'organisation.id', 'is', @boltonUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpMatPolicyId,'organisation.id', 'is', @bathUniOrgId, getdate(), getdate());

    Set @evolveEmpMatRoleId = (select top 1 Id from role where ApplicationId = @teacherEmpServiceId and Name= 'Teacher Services – Organisations');
    Set @evolveEmpPolicyId = (select top 1 Id from policy where ApplicationId=@teacherEmpServiceId and Name = 'Evolve - Employer Access - Agent')

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpPolicyId,'organisation.id', 'is', @covUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpPolicyId,'organisation.id', 'is', @boltonUniOrgId, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (newid(), @evolveEmpPolicyId,'organisation.id', 'is', @bathUniOrgId, getdate(), getdate());

ROLLBACK TRAN UPDATEHEIPOLICYCONDITIONS
