BEGIN TRAN ASSESSMENTSERVICEROLES

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Assessment Service';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;
    DECLARE @roleId_1 UNIQUEIDENTIFIER;
    DECLARE @roleId_2 UNIQUEIDENTIFIER;
    DECLARE @roleId_3 UNIQUEIDENTIFIER;
    DECLARE @roleId_4 UNIQUEIDENTIFIER;
    DECLARE @roleId_5 UNIQUEIDENTIFIER;
    DECLARE @roleId_6 UNIQUEIDENTIFIER;

    -- Get Service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'assessmentService');
    IF (@serviceId IS NOT NULL)

        BEGIN

            --Role: Assessment Service - School Practitioner
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'School Practitioner', @serviceId, 1, GETDATE(), GETDATE(), 'assessment_service_school_practitioner', @numericId, NULL);

            --Role: Assessment Service - School Administration
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'School Administration', @serviceId, 1, GETDATE(), GETDATE(), 'assessment_service_school_administration', @numericId, NULL);


        END;

        -- Get Role Id based on name, if more than one found it will fail and go to catch block
        SET @roleId_1 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Data User');
        IF (@roleId_1 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_data_user', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_1;

            END;

        SET @roleId_2 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Test Developer');
        IF (@roleId_2 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_test_developer', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_2;

            END;

        SET @roleId_3 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Service Manager');
        IF (@roleId_3 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_service_manager', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_3;

            END;

        SET @roleId_4 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Support');
        IF (@roleId_4 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_support', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_4;

            END;

        SET @roleId_5 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Help Desk');
        IF (@roleId_5 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_help_desk', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_5;

            END;

        SET @roleId_6 = (SELECT id FROM Role WHERE ApplicationId = @serviceId AND Name = 'Reviewer');
        IF (@roleId_6 IS NOT NULL)

            BEGIN

                UPDATE Role
                    SET Code = 'assessment_service_reviewer', UpdatedAt = GETDATE()
                    WHERE Id = @roleId_6;

            END;

    ROLLBACK TRAN ASSESSMENTSERVICEROLES;

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
          ROLLBACK TRAN ASSESSMENTSERVICEROLES;

END CATCH;
