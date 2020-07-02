BEGIN TRAN TLEVELSURL

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @serviceId UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'TLevelsRC');
    IF (@serviceId IS NOT NULL)

        BEGIN

            UPDATE service
                SET serviceHome = 'https://manage-tlevel-results.tlevels.gov.uk/home'
                WHERE id = @serviceId;

        END;

     --Commit transaction if all went fine
     ROLLBACK TRAN TLEVELSURL;

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
          ROLLBACK TRAN TLEVELSURL;

END CATCH;
