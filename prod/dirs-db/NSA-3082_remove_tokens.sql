BEGIN TRANSACTION REMOVETOKENS;

BEGIN TRY

    DECLARE @userId_1 UNIQUEIDENTIFIER;
    DECLARE @userId_2 UNIQUEIDENTIFIER;

    SET @userId_1 = (SELECT sub FROM [user] WHERE email = 'Kahsay.Hagos@merton.gov.uk')
    IF (@userId_1 IS NOT NULL)

        BEGIN

            DELETE FROM [user_device]
                WHERE serialNumber = '2969601120' and uid = @userId_1;

        END;

    SET @userId_2 = (SELECT sub FROM [user] WHERE email = 'tina.selby@southampton.gov.uk')
    IF (@userId_2 IS NOT NULL)

        BEGIN

            DELETE FROM [user_device]
                WHERE serialNumber = '3149011173' and uid = @userId_2;

        END;

    --Commit transaction if all went fine
    ROLLBACK TRAN REMOVETOKENS;

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
        ROLLBACK TRAN REMOVETOKENS;

END CATCH;
