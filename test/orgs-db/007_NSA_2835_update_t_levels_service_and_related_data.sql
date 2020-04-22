BEGIN TRAN TLEVELSCLEANUP

BEGIN TRY

    --do sth

    ROLLBACK TRAN TLEVELSCLEANUP;

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
          ROLLBACK TRAN TLEVELSCLEANUP;

END CATCH;