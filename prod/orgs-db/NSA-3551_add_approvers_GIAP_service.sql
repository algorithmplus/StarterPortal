BEGIN TRAN GIAPAPPROVERS
BEGIN TRY

    DECLARE @serviceId_OLD_1 UNIQUEIDENTIFIER = (SELECT id FROM service WHERE name ='Key to Success (Schools)');
    DECLARE @serviceId_OLD_2 UNIQUEIDENTIFIER = (SELECT id FROM service WHERE name ='Key to Success (LAs)');
    DECLARE @serviceName_NEW VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId_NEW UNIQUEIDENTIFIER;
    DECLARE @roleName VARCHAR(500) = 'GIAP Approver';
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @userId UNIQUEIDENTIFIER;
    DECLARE @userRoleId UNIQUEIDENTIFIER;
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @userIdList AS TABLE (count NVARCHAR(500), user_id NVARCHAR(500), organisation_id NVARCHAR(500), service_id NVARCHAR(500));
    DECLARE @userIdRoleList AS TABLE (count NVARCHAR(500), user_id NVARCHAR(500), organisation_id NVARCHAR(500), service_id NVARCHAR(500), role_id NVARCHAR(500));

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId_NEW = (SELECT id FROM service WHERE name = @serviceName_NEW);
    IF (@serviceId_NEW IS NOT NULL)

        BEGIN

        SET @roleId = (SELECT id FROM Role WHERE name = @roleName);
        IF (@roleId IS NOT NULL)

            BEGIN

                INSERT INTO @userIdList (count, user_id, organisation_id, service_id) SELECT COUNT(1), user_id, organisation_id, service_id FROM [user_services] WHERE service_id = @serviceId_NEW GROUP BY user_id, organisation_id, service_id;
                IF (SELECT COUNT (*) FROM @userIdList ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id, service_id FROM @userIdList;
                            OPEN db_cursor;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId, @serviceId;

                    END;
                    CLOSE db_cursor;
                    DEALLOCATE db_cursor;

            BEGIN

                INSERT INTO @userIdRoleList (count, user_id, organisation_id, service_id, role_id) SELECT COUNT(1), user_id, organisation_id, service_id, role_id FROM [user_service_roles]  WHERE service_id = @serviceId_NEW AND role_id = @roleId GROUP BY user_id, organisation_id, service_id, role_id;
                IF (SELECT COUNT (*) FROM @userIdList ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id,  service_id, role_id FROM @userIdRoleList;
                            OPEN db_cursor;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId, @serviceId, @userRoleId;

                    END;
                    CLOSE db_cursor;
                    DEALLOCATE db_cursor;


            BEGIN

                SELECT us.user_id, us.organisation_id, uo.role_id INTO #approverK2SIdList FROM [user_services] us INNER JOIN [user_organisation] uo ON uo.user_id = us.user_id AND uo.organisation_id = us.organisation_id WHERE us.service_id = @serviceId_OLD_1 AND uo.role_id = 10000
                UNION
                SELECT us.user_id, us.organisation_id, uo.role_id FROM [user_services] us INNER JOIN [user_organisation] uo ON uo.user_id = us.user_id AND uo.organisation_id = us.organisation_id WHERE us.service_id = @serviceId_OLD_2 AND uo.role_id = 10000

               -- INSERT INTO @approverK2SIdList (count, user_id, organisation_id) select us.user_id, us.organisation_id, uo.role_id from user_services us INNER JOIN user_organisation uo on uo.user_id=us.user_id where us.service_id=@serviceId_OLD_2 and uo.role_id=10000

                IF (SELECT COUNT (*) FROM #approverK2SIdList ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM #approverK2SIdList;
                        OPEN db_cursor;

                        FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                        WHILE @@FETCH_STATUS = 0

                            BEGIN
                                --INSERT into User Services
                                IF (SELECT count(*) from user_services WHERE user_id = @userId AND organisation_id = @orgId AND service_id = @serviceId_NEW) = 0
                                    BEGIN

                                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                    VALUES (NEWID(), 1, @userId, @orgId, @serviceId_NEW, GETDATE(), GETDATE());

                                    END;

                                IF (SELECT count(*) from user_service_roles WHERE user_id = @userId AND organisation_id = @orgId AND service_id = @serviceId_NEW AND role_id = @roleId) = 0
                                    BEGIN

                                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                    VALUES  (NEWID(), @userId, @serviceId_NEW, @orgId, @roleId, GETDATE(), GETDATE());

                                    END;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                            END;

                        CLOSE db_cursor;
                        DEALLOCATE db_cursor;

                    END;


                SELECT uo.user_id, uo.organisation_id, uo.role_id INTO #approverMATIdList FROM [user_organisation] uo INNER JOIN [organisation] o ON uo.organisation_id = o.id WHERE o.Category = 010 AND uo.role_id = 10000

                --INSERT INTO approverMATIdList (count, user_id, organisation_id) SELECT COUNT(1), uo.user_id, uo.organisation_id FROM [user_organisation] uo INNER JOIN [organisation] o on o.id = uo.organisation_id  WHERE o.Category = '010' AND uo.role_id = '10000' GROUP BY uo.user_id, uo.organisation_id;
                IF (SELECT COUNT (*) FROM #approverMATIdList ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM #approverMATIdList;
                        OPEN db_cursor;

                        FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                        WHILE @@FETCH_STATUS = 0

                            BEGIN
                                --INSERT into User Services
                                IF (SELECT count(*) from user_services WHERE user_id = @userId AND organisation_id = @orgId AND service_id = @serviceId_NEW) = 0
                                  BEGIN

                                    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                    VALUES (NEWID(), 1, @userId, @orgId, @serviceId_NEW, GETDATE(), GETDATE());

                                    END;

                                IF (SELECT count(*) from user_service_roles WHERE user_id = @userId AND organisation_id = @orgId AND service_id = @serviceId_NEW AND role_id = @roleId) = 0
                                    BEGIN

                                    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                    VALUES  (NEWID(), @userId, @serviceId_NEW, @orgId, @roleId, GETDATE(), GETDATE());

                                    END;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                            END;

                        CLOSE db_cursor;
                        DEALLOCATE db_cursor;

                        END;

                    DROP TABLE #approverK2SIdList
                    DROP TABLE #approverMATIdList

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
