BEGIN TRAN MYESFINTERNALUSERS

BEGIN TRY

    DECLARE @orgName VARCHAR(500) = 'Department for Education';
    DECLARE @orgId UNIQUEIDENTIFIER;
    DECLARE @serviceName VARCHAR(500)  = 'Manage your education and skills funding (MYESF)';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId_internal UNIQUEIDENTIFIER;
    DECLARE @roleId UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;

    -- Get Organisation Id based on name, if more than one found it will fail and go to catch block
    SET @orgId = (SELECT id FROM organisation WHERE name = @orgName);
    IF (@orgId IS NOT NULL)
        BEGIN
        -- Get Service Id based on name, if more than one found it will fail and go to catch block
        SET @serviceId = (SELECT id FROM service WHERE name = @serviceName AND clientId = 'MYESF');
        IF (@serviceId IS NOT NULL)
            BEGIN
            --Create Policy for Internal Users
            SET @policyId_internal = NEWID();
                INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, 'MYESF policy - Internal Users', @serviceId, 1, GETDATE(), GETDATE());

                 --Create Policy Conditions for Internal Users
                INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
                VALUES (NEWID(), @policyId_internal, 'organisation.id', 'is', @orgId, GETDATE(), GETDATE());

                   --Create role MYESF - Admin and link to policy
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'MYESF - Admin', @serviceId, 1, GETDATE(), GETDATE(), 'myesf_admin', @numericId, NULL);

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, @roleId, GETDATE(), GETDATE());

            --Create role MYESF - Document Exchange Administrator - Post 16 Funding Provision and link to policy
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'MYESF - Document Exchange Administrator - Post 16 Funding Provision', @serviceId, 1, GETDATE(), GETDATE(), 'myesf_documentexchangeadministratorpost16funding', @numericId, NULL);

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, @roleId, GETDATE(), GETDATE());

            --Create role MYESF - Document Exchange Administrator - Risk Assurance and link to policy
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'MYESF - Document Exchange Administrator - Risk Assurance', @serviceId, 1, GETDATE(), GETDATE(), 'myesf_documentexchange_administrator_riskassurance', @numericId, NULL);

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, @roleId, GETDATE(), GETDATE());

            --Create role MYESF - View as a Provider and link to policy
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'MYESF - View as a Provider', @serviceId, 1, GETDATE(), GETDATE(), 'myesf_view_as_a_provider', @numericId, NULL);

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, @roleId, GETDATE(), GETDATE());

            --Create role MYESF - Contract Admin and link to policy
            SET @roleId = NEWID();
            SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
                INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
                VALUES (@roleId, 'MYESF - Contract Admin', @serviceId, 1, GETDATE(), GETDATE(), 'myesf_contract_admin', @numericId, NULL);

                INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
                VALUES (@policyId_internal, @roleId, GETDATE(), GETDATE());
            END;
        END;

    --COMMIT TRAN IF DRY RUN WAS SUCCESFUL
    ROLLBACK TRAN MYESFINTERNALUSERS;

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
          ROLLBACK TRAN MYESFINTERNALUSERS;

END CATCH;
