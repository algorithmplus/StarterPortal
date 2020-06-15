BEGIN TRAN MTCSERVICEROLE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Multiplication tables check';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @applicationId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;

    -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        --Role: MTC Service - Technical Support
        SET @roleId = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
            INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
            VALUES (@roleId, 'Technical Support', @serviceId, 1, GETDATE(), GETDATE(), 'mtc_tech_support', @numericId, NULL);

        END;

    ROLLBACK TRAN MTCSERVICEROLE;

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
          ROLLBACK TRAN MTCSERVICEROLE;

END CATCH;
