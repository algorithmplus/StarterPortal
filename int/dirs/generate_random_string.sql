CREATE PROCEDURE GenerateRandomString
    @sLength tinyint ,
    -- LENGTH OF STRING TO GENERATE
    @RandomString nvarchar(MAX) OUTPUT
-- RETURNED RANDOM STRING

AS

SET NOCOUNT ON

DECLARE @Count tinyint, @NextC char(1)

SET @Count = 1
SET @RandomString = ''

WHILE @Count <= @sLength
BEGIN

    SELECT @NextC = CHAR(ROUND(RAND() * 81 + 33, 0))

    IF ASCII(@NextC) not IN (34, 39, 40, 41, 44, 46, 96, 58, 59) AND ASCII(@NextC) < 123
        AND ASCII(@NextC) > 48
		BEGIN
        SELECT @RandomString = @RandomString + @NextC
        SET @Count = @Count + 1
    END
END
 
GO