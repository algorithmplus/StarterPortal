BEGIN TRAN UPDATESIMSURL

BEGIN TRY

     DECLARE @serviceId UNIQUEIDENTIFIER = '5f895ff4-6d68-4a5a-ac2b-5ab51c36b09f';

     -- Insert redirect URL into SIMS Test Service
     INSERT INTO serviceRedirectUris (serviceId, redirectUrl)
     VALUES (@serviceId, 'https://preprod.pecuniam-online.co.uk'),
            (@serviceId, 'https://uat-v2.pecuniam-online.co.uk'),
            (@serviceId, 'https://pilot.pecuniam-online.co.uk');

     --Commit transaction if all went fine
     ROLLBACK TRAN UPDATESIMSURL;

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
          ROLLBACK TRAN UPDATESIMSURL;

END CATCH;
