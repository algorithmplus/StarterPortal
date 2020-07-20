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

                    SELECT DISTINCT user_id, organisation_id, service_id INTO #TempTableServices
                    FROM [user_services] where service_id = @serviceId_NEW;

                    SELECT DISTINCT uo.user_id, uo.organisation_id, us.service_id INTO #TempTableMATServices
                    FROM [user_organisation] uo INNER JOIN [organisation] o on o.id = uo.organisation_id INNER JOIN [user_services] us on us.organisation_id = uo.organisation_id WHERE o.Category = '010' AND role_id = '10000';

                    SELECT DISTINCT us.user_id, us.service_id, us.organisation_id INTO #TempTableK2SServices
                    FROM [user_services] us INNER JOIN [user_organisation] uo on uo.user_id = us.user_id WHERE us.service_id = @serviceId_OLD AND uo.role_id = '10000';

                    SELECT DISTINCT user_id, service_id, organisation_id, role_id INTO #TempTableRoles
                    FROM [user_service_roles] where service_id = @serviceId_NEW and role_id = @roleId

                    SELECT DISTINCT usr.user_id, usr.service_id,  usr.organisation_id, usr.role_id INTO #TempTableMATRoles
                    FROM [user_organisation] uo INNER JOIN [organisation] o on o.id = uo.organisation_id INNER JOIN [user_service_roles] usr on usr.organisation_id = uo.organisation_id WHERE o.Category = '010' AND uo.role_id = '10000';

                    SELECT DISTINCT usr.user_id, usr.service_id, usr.organisation_id, usr.role_id INTO #TempTableK2SRoles
                    FROM [user_service_roles] usr INNER JOIN [user_organisation] uo  on uo.organisation_id = usr.organisation_id WHERE usr.service_id = @serviceId_OLD AND uo.role_id = '10000';

                END;

                BEGIN

                    SELECT user_id, organisation_id, service_id INTO #TempTableUserServices FROM #TempTableServices
                    UNION
                    SELECT user_id, organisation_id, service_id FROM #TempTableMATServices
                    UNION
                    SELECT  user_id, organisation_id, service_id FROM #TempTableK2SServices

                END;

                BEGIN

                    SELECT user_id, organisation_id, service_id, role_id INTO #TempTableUserRoles FROM #TempTableRoles
                    UNION
                    SELECT user_id, organisation_id, service_id, role_id FROM #TempTableMATRoles
                    UNION
                    SELECT  user_id, organisation_id, service_id, role_id FROM #TempTableK2SRoles

                END;

                BEGIN

                IF (SELECT COUNT (*) FROM #TempTableUserServices ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM #TempTableUserServices;
                        OPEN db_cursor;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                            WHILE @@FETCH_STATUS = 0

                                BEGIN

                                --INSERT into User Services
                                INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
                                VALUES (NEWID(), 1, @userId, @orgId, @serviceId_NEW, GETDATE(), GETDATE());

                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                END;

                            CLOSE db_cursor;
                            DEALLOCATE db_cursor;

                    END

                END;

                BEGIN

                IF (SELECT COUNT (*) FROM #TempTableUserRoles ) > 0

                    BEGIN

                        DECLARE db_cursor CURSOR FOR SELECT user_id, organisation_id FROM #TempTableUserRoles;
                        OPEN db_cursor;

                            FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                            WHILE @@FETCH_STATUS = 0

                                BEGIN

                                --INSERT into User Service Roles
                                INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
                                VALUES (NEWID(), @userId, @serviceId_NEW, @orgId, @roleId, GETDATE(), GETDATE());

                                FETCH NEXT FROM db_cursor INTO @userId, @orgId;

                                END;

                            CLOSE db_cursor;
                            DEALLOCATE db_cursor;

                    END

                END;

                BEGIN

                    WITH cte AS (
                        SELECT
                            user_id,
                            organisation_id,
                            ROW_NUMBER() OVER (
                                PARTITION BY
                                    user_id,
                                    organisation_id
                                ORDER BY
                                    user_id,
                                    organisation_id
                            ) row_num
                        FROM
                            user_services where service_id = @serviceId_NEW
                    )
                    DELETE FROM cte
                    WHERE row_num > 1;

                END;

                BEGIN

                    WITH cte AS (
                        SELECT
                            user_id,
                            organisation_id,
                            ROW_NUMBER() OVER (
                                PARTITION BY
                                    user_id,
                                    organisation_id
                                ORDER BY
                                    user_id,
                                    organisation_id
                            ) row_num
                        FROM
                            user_service_roles where service_id = @serviceId_NEW AND role_id = @roleId
                    )
                    DELETE FROM cte
                    WHERE row_num > 1;

                END;

            END;

                DROP TABLE #TempTableUserRoles;
                DROP TABLE #TempTableMATRoles;
                DROP TABLE #TempTableK2SRoles;
                DROP TABLE #TempTableRoles;
                DROP TABLE #TempTableUserServices;
                DROP TABLE #TempTableMATServices;
                DROP TABLE #TempTableK2SServices;
                DROP TABLE #TempTableServices;

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
