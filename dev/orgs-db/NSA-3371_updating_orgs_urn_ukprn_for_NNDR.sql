BEGIN TRAN UPDATEORGSFORNNDR

BEGIN TRY

    DECLARE @orgName_1 VARCHAR(500) = 'THE COUNTY HIGH SCHOOL, LEFTWICH';
    DECLARE @orgId_1 UNIQUEIDENTIFIER;
    DECLARE @orgName_2 VARCHAR(500) = 'BOLTON BROW PRIMARY ACADEMY';
    DECLARE @orgId_2 UNIQUEIDENTIFIER;

    SET @orgId_1 = (SELECT id FROM organisation WHERE name = @orgName_1 and Category = '013');
    IF (@orgId_1 IS NOT NULL)
        BEGIN
            UPDATE organisation
                SET UKPRN = '10038674', URN = '138743', updatedAt = GETDATE()
                WHERE id = @orgId_1;
        END;
    SET @orgId_2 = (SELECT id FROM organisation WHERE name = @orgName_2 and Category = '013');
    IF (@orgId_2 IS NOT NULL)
        BEGIN
            UPDATE organisation
                SET UKPRN = '10035110', URN = '137392', updatedAt = GETDATE()
                WHERE id = @orgId_2;
        END;

    ROLLBACK TRAN UPDATEORGSFORNNDR

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
          ROLLBACK TRAN UPDATEORGSFORNNDR;

END CATCH;
