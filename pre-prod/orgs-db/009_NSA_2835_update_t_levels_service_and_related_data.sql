BEGIN TRAN TLEVELSCLEANUP

BEGIN TRY

    DECLARE @serviceNameToCleanup VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @policyIdList AS TABLE (Value UNIQUEIDENTIFIER);

    DECLARE @ncfeOrgId UNIQUEIDENTIFIER = '848d7fb9-adbd-47ec-a975-3ff9314323ea';
    DECLARE @pearsonOrgId UNIQUEIDENTIFIER = '256b4cdd-b478-45ca-8303-b674412ad11e';
    DECLARE @cityGuildsOrgId UNIQUEIDENTIFIER = 'b42eadb8-288f-4a45-b67d-39a9b5d95c7e';
    
    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceNameToCleanup);

    IF (@serviceId IS NOT NULL)
        BEGIN

            -- step 1) delete all policies (policy, policy conditions, and policyRoles) linked to the roles with that applicationId
            INSERT INTO @policyIdList (Value) SELECT id FROM Policy WHERE ApplicationId = @serviceId;

            IF (SELECT COUNT (*) FROM @policyIdList ) > 0
                BEGIN

                    --use cursor to loop through the list
                    DECLARE db_cursor CURSOR FOR
                    SELECT Value FROM @policyIdList
                    OPEN db_cursor
                    FETCH NEXT FROM db_cursor INTO @policyId

                    WHILE @@FETCH_STATUS = 0

                    BEGIN

                        DELETE FROM PolicyCondition
                            WHERE PolicyId = @policyId;

                        DELETE FROM PolicyRole
                            WHERE PolicyId = @policyId;

                        FETCH NEXT FROM db_cursor INTO @policyId;

                    END

                END

            DELETE FROM Policy
                WHERE ApplicationId = @serviceId;

            -- Step 2) delete the roles we don't need anymore
            DELETE FROM user_service_roles
                WHERE service_id = @serviceId
                    AND role_id IN ('5234a62e-4965-4b53-a054-08753aa47a98',
                                    '99795df7-894c-4167-88cd-37a4bdeaa476',
                                    'e0b7305b-8849-485f-9b6c-be3a13b49e23',
                                    '853159da-2ccf-4762-9c30-c573582b1b5e');                             
                                    
            DELETE FROM Role
                WHERE ApplicationId = @serviceId
                    AND id IN ('5234a62e-4965-4b53-a054-08753aa47a98',
                                '99795df7-894c-4167-88cd-37a4bdeaa476',
                                'e0b7305b-8849-485f-9b6c-be3a13b49e23',
                                '853159da-2ccf-4762-9c30-c573582b1b5e');

            -- Step 3) modify the roles we want to keep (Site Administrator, T Level Reviewer and Providers Editor)
            UPDATE role
                SET code='t_levels_site_administrator',
                    UpdatedAt=GETDATE()
                WHERE id='4100b34b-15e5-4429-b132-8b3dba5a0eb2';

            UPDATE role
                SET code='t_levels_reviewer',
                    UpdatedAt=GETDATE()
                WHERE id='d2132f32-597d-4efb-b9a1-6df866bdee0a';

            UPDATE role
                SET name='Providers Editor',
                    code='t_levels_providers_editor',
                    UpdatedAt=GETDATE()
                WHERE id='1e595172-c8d2-40b4-a221-d45643d32772';

            -- Step 4) add new policy and link with the three roles we kept
            --Create Policy
            SET @policyId = NEWID();
            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId, 'T Levels and Certification', @serviceId, 1, GETDATE(), GETDATE());

            --Create Policy Conditions
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES (NEWID(), @policyId, 'organisation.id', 'is', @ncfeOrgId, GETDATE(), GETDATE()),
                (NEWID(), @policyId, 'organisation.id', 'is', @pearsonOrgId, GETDATE(), GETDATE()),
                (NEWID(), @policyId, 'organisation.id', 'is', @cityGuildsOrgId, GETDATE(), GETDATE());

            --Link Policy with roles kept
            INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
            VALUES 
                (@policyId, '4100b34b-15e5-4429-b132-8b3dba5a0eb2', GETDATE(), GETDATE()),
                (@policyId, '1e595172-c8d2-40b4-a221-d45643d32772', GETDATE(), GETDATE()),
                (@policyId, 'd2132f32-597d-4efb-b9a1-6df866bdee0a', GETDATE(), GETDATE());

        END

    ROLLBACK TRAN TLEVELSCLEANUP;

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
          ROLLBACK TRAN TLEVELSCLEANUP;

END CATCH;
