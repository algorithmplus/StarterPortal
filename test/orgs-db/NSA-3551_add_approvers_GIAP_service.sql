BEGIN TRAN GIAPAPPROVERS
BEGIN TRY

    DECLARE @serviceName_OLD VARCHAR(500) = 'Apply to convert';
    DECLARE @serviceId_OLD UNIQUEIDENTIFIER;
    DECLARE @serviceName_NEW VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId_NEW UNIQUEIDENTIFIER;
    DECLARE @roleName VARCHAR(500) = 'GIAP Approver';
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @userId UNIQUEIDENTIFIER;
    DECLARE @userIdList AS TABLE (user_id NVARCHAR(500), organisation_id NVARCHAR(500));
    DECLARE @approverK2SId UNIQUEIDENTIFIER;
    DECLARE @approverK2SIdList AS TABLE (count NVARCHAR(500), user_id NVARCHAR(500), organisation_id NVARCHAR(500));
    DECLARE @approverMATSI UNIQUEIDENTIFIER;
    DECLARE @approverMATSIdList AS TABLE (count NVARCHAR(500), user_id NVARCHAR(500), organisation_id NVARCHAR(500));


    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId_NEW = (SELECT id FROM service WHERE name = @serviceName_NEW);
    IF (@serviceId_NEW IS NOT NULL)

        BEGIN

        SET @serviceId_OLD = (SELECT id FROM service WHERE name = @serviceName_OLD);
        IF (@serviceId_OLD IS NOT NULL)

            BEGIN

            SET @roleId = (SELECT id FROM Role WHERE name = @roleName);
            IF (@roleId IS NOT NULL)

                BEGIN

                    INSERT INTO @approverK2SIdList (count, user_id, organisation_id) SELECT COUNT(1), us.user_id, us.organisation_id FROM [user_services] us INNER JOIN [user_organisation] uo  on us.user_id = uo.user_id  WHERE service_id = '03bc03c1-8661-4fcd-8ea0-70ee1b9585c8' AND role_id = '10000' GROUP BY us.user_id, us.organisation_id;
                    IF (SELECT COUNT (*) FROM @approverK2SIdList ) > 0

                        BEGIN

                            DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM @approverK2SIdList;
                                OPEN db_cursor;

                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                WHILE @@FETCH_STATUS = 0

                                BEGIN

                                --INSERT into User Services
                                IF NOT EXISTS (SELECT @userId, @orgId from @approverK2SIdList)
                                INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                VALUES (NEWID(), 1, @userId, @orgId, @serviceId_NEW, GETDATE(), GETDATE());

                                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                VALUES  (NEWID(), @userId, @serviceId_NEW, @orgId, @roleId, GETDATE(), GETDATE());


                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                END;
                            CLOSE db_cursor;
                            DEALLOCATE db_cursor;

                        END;

                    END;

                BEGIN

                    INSERT INTO @approverMATSIdList (count, user_id, organisation_id) SELECT COUNT(1), uo.user_id, uo.organisation_id FROM [user_organisation] uo INNER JOIN [organisation] o on o.id = UO.organisation_id WHERE Category = '010' AND role_id = '10000' GROUP BY uo.user_id, uo.organisation_id;

                    IF (SELECT COUNT (*) FROM @approverMATSIdList ) > 0

                        BEGIN

                            DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM @approverMATSIdList;
                                OPEN db_cursor;

                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                WHILE @@FETCH_STATUS = 0

                                BEGIN

                                --INSERT into User Services
                                IF NOT EXISTS (SELECT @userId, @orgId from @approverMATSIdList)
                                INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                VALUES (NEWID(), 1, @userId, @orgId, @serviceId_NEW, GETDATE(), GETDATE());

                                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                VALUES  (NEWID(), @userId, @serviceId_NEW, @orgId, @roleId, GETDATE(), GETDATE());


                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                END;
                            CLOSE db_cursor;
                            DEALLOCATE db_cursor;

                        END;

                    END;

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
