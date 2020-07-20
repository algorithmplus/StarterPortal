BEGIN TRAN ADDMANAGEROLE

BEGIN TRY

    DECLARE @serviceName VARCHAR(500) = 'Get information about pupils';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @roleName VARCHAR(500) = 'GIAP Admin';
    DECLARE @roleId UNIQUEIDENTIFIER;

    -- Step 1) get organisation Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM service WHERE name = @serviceName);
    IF (@serviceId IS NOT NULL)

        BEGIN
        -- Step 1) get role Id based on name, if more than one found it will fail and go to catch block
        SET @roleId = (SELECT id FROM Role WHERE name = @roleName);
        IF (@roleId IS NOT NULL)

            BEGIN

                UPDATE user_service_roles
                    SET service_id = @serviceId, updatedAt = GETDATE()
                    WHERE role_id = @roleId;
            END;

            BEGIN

                UPDATE user_services
                    SET service_id = @serviceId, updatedAt  = GETDATE()
                    WHERE user_id IN ('095f46ce-7192-4d94-a744-b6a68445664c',
                                    'b3dcf295-ee54-41f5-84b5-dd315de19deb',
                                    'd1103cf8-9d98-46b2-b3dc-f36911baf3b2',
                                    '23947f14-d2cf-4a24-a9e8-0c41a75e92a0',
                                    'de33fab2-1b23-4879-9c8a-1a30023a4fb2',
                                    'ad40a258-9509-4280-97a2-2008993ee265',
                                    'e4cef589-5594-4856-b2fd-21123fb3ffd3',
                                    '4d283109-c085-4f46-9bb2-371b75fc273b',
                                    '34b1fc92-47f5-43bf-8f48-4470f0d36e3d',
                                    '63643fe0-dfad-4d10-8449-216467baf825',
                                    '720a9a48-d737-4456-967e-68114738fb0d',
                                    '6a043c8c-50ca-4158-8e22-78cf8267f84a',
                                    '6e4d4b01-e09a-430d-9def-7ed7686f7e36',
                                    '1b6d617b-9e4d-42ed-b4d7-9dc99bfa4997',
                                    '3a7e1dbd-346a-4ae9-9636-9dae77329323',
                                    '204545c3-4f34-4075-bcc3-50a06d4a22bc',
                                    '127bee3a-6100-4081-bd5d-64abce42eed7')
                    AND service_id = 'b1f190aa-729a-45fc-a695-4ea209dc79d4'
                    AND createdAt like '2020-07-14 18:0%'

            END;

        END;

    ROLLBACK TRAN ADDMANAGEROLE;

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
          ROLLBACK TRAN ADDMANAGEROLE;

END CATCH;
