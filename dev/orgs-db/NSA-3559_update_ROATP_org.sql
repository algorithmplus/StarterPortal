BEGIN TRAN UPDATEROATPORG

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'DV8 TRAINING LTD';
    DECLARE @orgId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName AND Category = '008');
    IF (@orgId IS NOT NULL)

        BEGIN

        UPDATE organisation
            SET name = 'BIG CREATIVE TRAINING LTD', updatedAt=GETDATE()
            WHERE id = @orgId AND UKPRN = '10002073' ;

        END;

    ROLLBACK TRAN UPDATEROATPORG

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
          ROLLBACK TRAN UPDATEROATPORG;

END CATCH;
