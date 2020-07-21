BEGIN TRAN UPDATESERVICENAME

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Online Collections Service - including Risk Protection Arrangements';

    UPDATE dbo.service SET NAME = @serviceName where Id = 'b45616a1-19a7-4a2e-966d-9e28c99bc6c6';

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
          ROLLBACK TRAN UPDATESERVICENAME;

END CATCH;