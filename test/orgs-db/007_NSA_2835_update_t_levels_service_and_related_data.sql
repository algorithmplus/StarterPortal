BEGIN TRAN TLEVELSCLEANUP

BEGIN TRY

    DECLARE @serviceNameToCleanup VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @policyIdList AS TABLE (Value UNIQUEIDENTIFIER);
    DECLARE @ncfeOrgId UNIQUEIDENTIFIER = '848d7fb9-adbd-47ec-a975-3ff9314323ea';

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

            -- Step 2) modify user_service_roles so that we only have them pointing to one of the (duplicated) administrator roles
            UPDATE user_service_roles
                SET role_id='4100b34b-15e5-4429-b132-8b3dba5a0eb2',
                    UpdatedAt=GETDATE()
                WHERE id='52266a6f-fcae-4365-9297-b9603f3df12b';

            -- Step 3) delete the roles we don't need anymore
            DELETE FROM user_service_roles
                WHERE service_id = @serviceId
                    AND role_id IN ('cc3430da-5856-44ac-8241-32cd116ed0e2',
                                    '0337dc13-55e5-4769-8c27-5447c3479358',
                                    '2a957dee-f416-433e-86b5-6695ac858136',
                                    'eb762845-5273-4649-a05a-6eb233766372',
                                    '5af605ca-2d99-4a0b-b779-714ef9408d26',
                                    '10d11be6-387a-4f03-bf9e-d7ccff9a509c',
                                    '962ef9b4-63bd-4f14-87d8-ec8101823acc');

            DELETE FROM Role
                WHERE ApplicationId = @serviceId
                    AND id IN ('cc3430da-5856-44ac-8241-32cd116ed0e2',
                                '0337dc13-55e5-4769-8c27-5447c3479358',
                                '2a957dee-f416-433e-86b5-6695ac858136',
                                'eb762845-5273-4649-a05a-6eb233766372',
                                '5af605ca-2d99-4a0b-b779-714ef9408d26',
                                '10d11be6-387a-4f03-bf9e-d7ccff9a509c',
                                '962ef9b4-63bd-4f14-87d8-ec8101823acc');

            -- Step 4) modify the roles we want to keep (Site Administrator, T Level Reviewer and Providers Editor)
            UPDATE role
                SET code='t_levels_site_administrator',
                    UpdatedAt=GETDATE()
                WHERE id='4100b34b-15e5-4429-b132-8b3dba5a0eb2'

            UPDATE role
                SET code='t_levels_reviewer',
                    UpdatedAt=GETDATE()
                WHERE id='d2132f32-597d-4efb-b9a1-6df866bdee0a';

                UPDATE role
                    SET code='t_levels_providers_editor',
                        UpdatedAt=GETDATE()
                    WHERE id='1e595172-c8d2-40b4-a221-d45643d32772';

            -- select * from role where applicationId = @serviceId

            -- Step 5) add new policy and link with the three roles we kept
            --Create Policy
            SET @policyId = NEWID();
            INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
            VALUES (@policyId, 'T Levels and Certification', @serviceId, 1, GETDATE(), GETDATE());

            --Create Policy Conditions
            INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
            VALUES (NEWID(), @policyId, 'organisation.id', 'is', @ncfeOrgId, GETDATE(), GETDATE());

            --Link Policy with roles kept
            INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
            VALUES 
                (@policyId, '4100b34b-15e5-4429-b132-8b3dba5a0eb2', GETDATE(), GETDATE()),
                (@policyId, '1e595172-c8d2-40b4-a221-d45643d32772', GETDATE(), GETDATE()),
                (@policyId, 'd2132f32-597d-4efb-b9a1-6df866bdee0a', GETDATE(), GETDATE());

            -- select * from Policy WHERE applicationId = @serviceId
            -- select * from PolicyRole WHERE policyId = @policyId

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
