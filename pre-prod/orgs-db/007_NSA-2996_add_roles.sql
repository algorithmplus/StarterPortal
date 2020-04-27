BEGIN TRAN ASSESSMENTSERVICEROLES

BEGIN TRY

    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @applicationId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;

    SET @applicationId = '170f1629-0ae5-4bad-93c0-9b260b025cfe';

    --Role: Assessment Service - Data User
    SET @roleId = NEWID();
    SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId, 'Data User', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Data_User', @numericId, NULL);

    --Role: Assessment Service - School User
    SET @roleId = NEWID();
    SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId, 'School User', @applicationId , 1, GETDATE(), GETDATE(), 'Assessment_Service_School_User', @numericId, NULL);

    --Role: Assessment Service - Service Manager
    SET @roleId = NEWID();
    SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId, 'Service Manager', @applicationId, 1, GETDATE(), GETDATE(), 'Assessment_Service_Service_Manager', @numericId, NULL);

    ROLLBACK TRAN ASSESSMENTSERVICEROLES;

END TRY

BEGIN CATCH

     SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

     --Rollback if there was an error
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN ASSESSMENTSERVICEROLES;

END CATCH;
