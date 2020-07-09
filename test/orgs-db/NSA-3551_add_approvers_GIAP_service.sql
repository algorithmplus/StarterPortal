BEGIN TRAN GIAPAPPROVERS

BEGIN TRY

    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName_1 VARCHAR(500) = 'Key to Success (LAs)';
    DECLARE @serviceName_2 VARCHAR(500) = 'Key to Success (Schools)';
    DECLARE @serviceId_1 UNIQUEIDENTIFIER;
    DECLARE @serviceId_2 UNIQUEIDENTIFIER;
    DECLARE @userIdList AS TABLE (user_id NVARCHAR(500), organisation_id NVARCHAR(500));
    DECLARE @userId UNIQUEIDENTIFIER;
    DECLARE @approverK2SIdList AS TABLE (user_id NVARCHAR(500), organisation_id NVARCHAR(500));
    DECLARE @approverK2SId UNIQUEIDENTIFIER;
    DECLARE @approverMATSIdList AS TABLE (user_id NVARCHAR(500), organisation_id NVARCHAR(500));
    DECLARE @approverMATSI UNIQUEIDENTIFIER;

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId_1 = (SELECT id FROM service WHERE name = @serviceName_1);
    IF (@serviceId_1 IS NOT NULL)

        BEGIN

        SET @serviceId_2 = (SELECT id FROM service WHERE name = @serviceName_2);
        IF (@serviceId_2 IS NOT NULL)

            BEGIN
                -- step 1) delete all policies (policy, policy conditions, and policyRoles) linked to the roles with that applicationId

                INSERT INTO @userIdList (user_id, organisation_id) SELECT user_id, organisation_id FROM user_services WHERE service_id = @serviceId_1 OR service_id = @serviceId_2;

                IF (SELECT COUNT (*) FROM @userIdList ) > 0
                    BEGIN

                    --use cursor to loop through the list
                    DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM @userIdList;
                        OPEN db_cursor

                    FETCH NEXT FROM db_cursor INTO @userId, @orgId

                    END;

                    CLOSE db_cursor;
                    DEALLOCATE db_cursor;

            END;

            BEGIN

                INSERT INTO @approverK2SIdList (user_id, organisation_id) SELECT user_id, organisation_id FROM user_organisation WHERE user_id = @userId AND role_id = '10000';
                IF (SELECT COUNT (*) FROM @approverK2SIdList ) > 0

                    BEGIN

                    --INSERT into appropriate columns
                    DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM @approverK2SIdList;
                        OPEN db_cursor;

                        FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                    WHILE @@FETCH_STATUS = 0

                        BEGIN

                        --INSERT into User Services
                        IF NOT EXISTS (SELECT @userId, @orgId from @approverK2SIdList)
                        INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                        VALUES  (NEWID(), 1, @userId, @orgId, @serviceId_1, GETDATE(), GETDATE()),
                                (NEWID(), 1, @userId, @orgId, @serviceId_2, GETDATE(), GETDATE());

                        FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                        END;

                    CLOSE db_cursor;
                    DEALLOCATE db_cursor;

                    END;

            END;

            BEGIN

                INSERT INTO @approverMATSIdList (user_id, organisation_id) SELECT uo.user_id as user_id, o.id as organistion_id FROM [organisation] o INNER JOIN [user_organisation] uo on organisation_id = o.id  WHERE Category = '010' AND role_id = '10000';
                IF (SELECT COUNT (*) FROM @approverMATSIdList ) > 0

                    BEGIN

                    --INSERT into appropriate columns
                    DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM @approverMATSIdList;
                        OPEN db_cursor;

                    FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                    WHILE @@FETCH_STATUS = 0

                        BEGIN

                            --INSERT into User Services
                            IF NOT EXISTS (SELECT @userId, @orgId from @approverMATSIdList)
                            INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                            VALUES  (NEWID(), 1, @userId, @orgId, @serviceId_1, GETDATE(), GETDATE()),
                                    (NEWID(), 1, @userId, @orgId, @serviceId_2, GETDATE(), GETDATE());

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                        END;

                    END;

                    CLOSE db_cursor;
                    DEALLOCATE db_cursor;

            END;

        END;

    ROLLBACK TRAN GIAPAPPROVERS;

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
          ROLLBACK TRAN GIAPAPPROVERS;

END CATCH;
