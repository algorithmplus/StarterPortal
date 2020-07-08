BEGIN TRANSACTION REMOVEUSER;

BEGIN TRY

    DECLARE @userId UNIQUEIDENTIFIER;

    SET @userId = (SELECT sub FROM [user] WHERE email = 'ao_perason_re@tleveltest.com')
    IF (@userId IS NOT NULL)

        BEGIN

            DELETE FROM [invitation]
                WHERE email = 'ao_perason_re@tleveltest.com';

            DELETE FROM [user]
                WHERE sub = @userId

        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN REMOVEUSER;

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
        ROLLBACK TRAN REMOVEUSER;

END CATCH;
