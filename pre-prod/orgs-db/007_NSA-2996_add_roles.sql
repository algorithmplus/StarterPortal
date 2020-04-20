BEGIN TRAN ASSESSMENTSERVICEROLES
DECLARE @roleId UNIQUEIDENTIFIER
DECLARE @applicationId UNIQUEIDENTIFIER
--Role: Assessment Service - Data User
SET @roleId = NEWID();
SET @applicationId = '170f1629-0ae5-4bad-93c0-9b260b025cfe';
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Data User', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Data_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
--Role: Assessment Service - School User
SET @roleId = NEWID();
SET @applicationId = '170f1629-0ae5-4bad-93c0-9b260b025cfe';
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'School User', @applicationId , 1, GETDATE(), GETDATE(), 'Assessment_Service_School_User', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
--Role: Assessment Service - Service Manager
SET @roleId = NEWID();
SET @applicationId = '170f1629-0ae5-4bad-93c0-9b260b025cfe';
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleId, 'Service Manager', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Service_Manager', (SELECT MAX(NumericId) FROM Role) + 1, NULL);
ROLLBACK TRAN ASSESSMENTSERVICEROLES;
