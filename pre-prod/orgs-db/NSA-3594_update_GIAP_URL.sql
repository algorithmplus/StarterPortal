BEGIN TRAN UPDATEGIAPURL

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN

        UPDATE service
            SET serviceHome = 'https://pp.get-information-pupils.service.gov.uk/'
            WHERE id = @serviceId;

        END;

    ROLLBACK TRAN UPDATEGIAPURL

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
          ROLLBACK TRAN UPDATEGIAPURL;

END CATCH;
