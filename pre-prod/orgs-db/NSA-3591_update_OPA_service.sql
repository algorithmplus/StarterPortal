BEGIN TRAN UPDATEOPASERVICE

BEGIN TRY

     DECLARE @serviceName VARCHAR(500) = 'OPAFastForm';
     DECLARE @serviceId UNIQUEIDENTIFIER;
     DECLARE @roleName_1 VARCHAR(500) = 'OPA Administrator';
     DECLARE @roleId_1 UNIQUEIDENTIFIER;
     DECLARE @roleName_2 VARCHAR(500) = 'OPA End User';
     DECLARE @roleId_2 UNIQUEIDENTIFIER;

     -- Step 1) get service Id based on name, if more than one found it will fail and go to catch block
     SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
     IF (@serviceId IS NOT NULL)

        BEGIN

         -- Step 2a) get service Id based on name, if more than one found it will fail and go to catch block
         SET @roleId_1 = (SELECT id FROM Role WHERE name = @roleName_1);
         IF (@roleId_1 IS NOT NULL)

            BEGIN

            -- Step 2b) get role Id based on name, if more than one found it will fail and go to catch block
            SET @roleId_2 = (SELECT id FROM Role WHERE name = @roleName_2);
            IF (@roleId_2 IS NOT NULL)

                BEGIN

                    UPDATE service
                        SET clientId = 'ESFAOnlineCollectionsOPAFastForm'
                        WHERE id = @serviceId;

                END;

                BEGIN

                    INSERT INTO serviceParams (serviceId, paramName, paramValue)
                    VALUES (@serviceId, 'serviceId', UPPER(@serviceId));

                    INSERT INTO serviceGrantTypes (serviceId, grantType)
                    VALUES (@serviceId, 'refresh_token');

                END;

                BEGIN

                    UPDATE user_service_roles
                        SET service_id = @serviceId, updatedAt = GETDATE()
                        WHERE role_id = @roleId_1;

                    UPDATE user_service_roles
                        SET service_id = @serviceId, updatedAt = GETDATE()
                        WHERE role_id = @roleId_2;

                END;

            END;

        END;

     --Commit transaction if all went fine
     ROLLBACK TRAN UPDATEOPASERVICE;

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
          ROLLBACK TRAN UPDATEOPASERVICE;

END CATCH;
