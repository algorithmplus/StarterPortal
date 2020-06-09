BEGIN TRAN UPDATETVORG

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'BEDDINGTON PARK ACADEMY TRUST';
    DECLARE @orgId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName AND Category = '013');
    IF (@orgId IS NOT NULL)

        BEGIN

        UPDATE organisation
            SET UKPRN = '10060971', updatedAt=GETDATE()
            WHERE id = @orgId;

        END;

    ROLLBACK TRAN UPDATETVORG

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
          ROLLBACK TRAN UPDATETVORG;

END CATCH;
