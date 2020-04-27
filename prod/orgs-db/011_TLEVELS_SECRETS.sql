BEGIN TRANSACTION UPDATESECRETS;
BEGIN TRY  

UPDATE service 
SET 
    clientSecret = 'afyPDjO2$MdBO*l*8XOgu3FfNZ24syDkk$^VE0L8ujbotN$p73',
    apiSecret = 'bL41zJFjrD9Rq08*L&Bwg*WK5cTveqKueoZaKTlcaE%QvW@Y7l'
WHERE id = '2d6be168-6c9d-4a07-be11-cab49f4c9680'
    
--Commit transaction if all went fine
COMMIT TRAN UPDATESECRETS;

END TRY
BEGIN CATCH
     SELECT
    ERROR_NUMBER() AS ErrorNumber  
        , ERROR_SEVERITY() AS ErrorSeverity  
        , ERROR_STATE() AS ErrorState  
        , ERROR_PROCEDURE() AS ErrorProcedure  
        , ERROR_LINE() AS ErrorLine  
        , ERROR_MESSAGE() AS ErrorMessage;  
     --Rollback if there was an error
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN UPDATESECRETS;
END CATCH;