BEGIN TRANSACTION ANON_DATA;
BEGIN TRY  

--do stuff here
DECLARE @CursorTestID VARCHAR(100);
DECLARE @RunningTotal BIGINT = 0;
 
DECLARE CUR_TEST CURSOR FAST_FORWARD FOR
    SELECT sub
FROM dbo.[user];
 
OPEN CUR_TEST
FETCH NEXT FROM CUR_TEST INTO @CursorTestID
 
WHILE @@FETCH_STATUS = 0
BEGIN

    DECLARE @SALT NVARCHAR(MAX)
    DECLARE @GIVEN NVARCHAR(MAX)
    DECLARE @FAMILY NVARCHAR(MAX)
    DECLARE @EMAIL NVARCHAR(MAX)

    EXEC GenerateRandomString 10, @SALT OUTPUT
    EXEC GenerateRandomString 10, @GIVEN OUTPUT
    EXEC GenerateRandomString 10, @FAMILY OUTPUT
    EXEC GenerateRandomString 10, @EMAIL OUTPUT

    UPDATE [dbo].[user]
SET
	[given_name] = @GIVEN,
	[family_name] = @FAMILY,
    email = CONCAT(@EMAIL, '@education.gov.uk'),
    [salt] = @SALT
WHERE
	sub = @CursorTestID;

    SET @RunningTotal += 1

    FETCH NEXT FROM CUR_TEST INTO @CursorTestID
END
CLOSE CUR_TEST
DEALLOCATE CUR_TEST

PRINT @RunningTotal;
    
--Commit transaction if all went fine
COMMIT TRAN ANON_DATA;

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
          ROLLBACK TRAN ANON_DATA;
END CATCH;