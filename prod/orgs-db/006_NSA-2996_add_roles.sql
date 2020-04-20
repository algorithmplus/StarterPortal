BEGIN TRAN ASSESSMENTSERVICEROLES
DECLARE @roleId UNIQUEIDENTIFIER
DECLARE @applicationId UNIQUEIDENTIFIER
SET @applicationId = 'addcd09d-95cb-4eb9-8546-ffc1e420fead';
--Role: Assessment Service - Data User
SET @roleId = NEWID();
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Data User', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Data_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
--Role: Assessment Service - School User
SET @roleId = NEWID();
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'School User', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_School_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
--Role: Assessment Service - Service Manager
SET @roleId = NEWID();
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Service Manager', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Service_Manager', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
ROLLBACK TRAN ASSESSMENTSERVICEROLES
