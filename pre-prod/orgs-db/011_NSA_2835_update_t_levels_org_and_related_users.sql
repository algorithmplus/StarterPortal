BEGIN TRAN TLEVELSORGUPDATE

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'PEARSON EDUCATION LIMITED';
    DECLARE @serviceName VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceId UNIQUEIDENTIFIER;

    --get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceName);

    IF (@serviceId IS NOT NULL)
        BEGIN
            -- Step 2) update the users to point to the correct organisation
            UPDATE
                user_service_roles
            SET organisation_id = @orgId
                WHERE service_id = @serviceId
                    AND user_id IN ('40244261-f436-40c7-b0ef-4e63a84c35c5',
                                    '38d8ec21-0c43-4502-89cc-19f108974cfa',
                                    '83e3f2bb-1a0d-49d4-a339-b8f7335855e8',
                                    'ca66df7f-efec-439f-9ae1-dec7cfb9a993',
                                    '3e301ab4-132c-4957-9263-2f36d18dd577',
                                    '274035ad-8e52-476c-b049-a4b420bede18',
                                    'f7d24b86-23af-41e8-9c8f-62af2099c00e',
                                    '4c937d74-6bb1-4ae0-a619-ca7a81f46847',
                                    '64e08cac-758a-4d88-9ee3-9ee042303057',
                                    '562ef3b5-bda6-4ae3-b0b2-9fc1f8f5371f',
                                    'ca66df7f-efec-439f-9ae1-dec7cfb9a993',
                                    '607d4c1a-b6a6-4468-8c34-c9c7175ac3ad',
                                    'ca66df7f-efec-439f-9ae1-dec7cfb9a993',
                                    '16bead47-f7dc-4408-9c3f-e1b07a492dbd',
                                    '316f9334-0a3e-4d1f-a153-8167233db761',
                                    '42fed53b-612f-4511-8e3c-53600e3d54ce',
                                    '62ce8769-c5aa-4d1b-9975-9edd1b7c9551',
                                    'ca8ea889-6384-41cd-9114-ad968214f2d8',
                                    '4e6e86bf-197c-4324-8b50-b0f48776553f',
                                    '0707240d-5811-4a9b-8aa9-c3ebc8483ecc',
                                    '5d6bd691-7942-4ce4-a388-27b0d6e8ea6d',
                                    'f7d24b86-23af-41e8-9c8f-62af2099c00e');
            UPDATE
                user_services
            SET organisation_id = @orgId
                WHERE service_id = @serviceId
                    AND user_id IN ('4e6e86bf-197c-4324-8b50-b0f48776553f',
                                    '274035ad-8e52-476c-b049-a4b420bede18',
                                    '16bead47-f7dc-4408-9c3f-e1b07a492dbd',
                                    '64e08cac-758a-4d88-9ee3-9ee042303057',
                                    '40244261-f436-40c7-b0ef-4e63a84c35c5',
                                    '607d4c1a-b6a6-4468-8c34-c9c7175ac3ad',
                                    '316f9334-0a3e-4d1f-a153-8167233db761',
                                    '5d6bd691-7942-4ce4-a388-27b0d6e8ea6d',
                                    'ca66df7f-efec-439f-9ae1-dec7cfb9a993',
                                    '562ef3b5-bda6-4ae3-b0b2-9fc1f8f5371f',
                                    '62ce8769-c5aa-4d1b-9975-9edd1b7c9551',
                                    'ca8ea889-6384-41cd-9114-ad968214f2d8',
                                    '42fed53b-612f-4511-8e3c-53600e3d54ce',
                                    '0707240d-5811-4a9b-8aa9-c3ebc8483ecc',
                                    '4c937d74-6bb1-4ae0-a619-ca7a81f46847',
                                    '83e3f2bb-1a0d-49d4-a339-b8f7335855e8',
                                    '3e301ab4-132c-4957-9263-2f36d18dd577',
                                    '38d8ec21-0c43-4502-89cc-19f108974cfa',
                                    'f7d24b86-23af-41e8-9c8f-62af2099c00e');
        END

    ROLLBACK TRAN TLEVELSORGUPDATE;

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
          ROLLBACK TRAN TLEVELSORGUPDATE;

END CATCH;
