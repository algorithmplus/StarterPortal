BEGIN TRAN ASSESSMENTSERVICEROLES

DECLARE @roleId UNIQUEIDENTIFIER
DECLARE @policyId UNIQUEIDENTIFIER
DECLARE @orgId UNIQUEIDENTIFIER

--Role: Assessment Service - Data User
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Data User', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE(), 'Assessment_Service_Data_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'Data User', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Role: Assessment Service - School User
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'School User', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE(), 'Assessment_Service_School_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'School User', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Role: Assessment Service - Service Manager
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '23f20e54-79ea-4146-8e39-18197576f023'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Service Manager', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE(), 'Assessment_Service_Service_Manager', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'Service Manager', '170f1629-0ae5-4bad-93c0-9b260b025cfe', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

ROLLBACK TRAN ASSESSMENTSERVICEROLES;
