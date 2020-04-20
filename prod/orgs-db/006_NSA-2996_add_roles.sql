BEGIN TRAN ASSESSMENTSERVICEROLES

DECLARE @roleId UNIQUEIDENTIFIER
DECLARE @policyId UNIQUEIDENTIFIER
DECLARE @orgId UNIQUEIDENTIFIER

--Role: Assessment Service - Data User
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Data User', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE(), 'Assessment_Service_Data_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'Data User', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Role: Assessment Service - School User
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'School User', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE(), 'Assessment_Service_School_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'School User', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

--Role: Assessment Service - Service Manager
SET @roleId = NEWID();
SET @policyId = NEWID();
SET @orgId = '7d48d8ff-a322-4f22-8a79-c0425ac69749'
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Service Manager', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE(), 'Assessment_Service_Service_Manager', (SELECT MAX(NumericId) FROM Role) + 1, NULL);

    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyId, 'Service Manager', 'addcd09d-95cb-4eb9-8546-ffc1e420fead', 1, GETDATE(), GETDATE());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
    VALUES (NEWID(), @policyId, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyId, @roleId, GETDATE(), GETDATE());

ROLLBACK TRAN ASSESSMENTSERVICEROLES;
