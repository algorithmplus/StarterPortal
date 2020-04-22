BEGIN TRAN TLEVELSCLEANUP

BEGIN TRY

    DECLARE @serviceNameToCleanup VARCHAR(500) = 'T Level Results and Certification';
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyId UNIQUEIDENTIFIER;
    DECLARE @policyIdList AS TABLE (Value UNIQUEIDENTIFIER);

    --get service Id based on name, if more than one found it will fail and go to catch block
    SET @serviceId = (SELECT id FROM Service WHERE name = @serviceNameToCleanup);

    IF (@serviceId IS NOT NULL)
        BEGIN

            -- step 1) delete all policies (policy, policy conditions, and policyRoles) linked to the roles with that applicationId
            
            --SELECT * FROM Policy WHERE ApplicationId = @serviceId;
        
            INSERT INTO @policyIdList (Value) SELECT id FROM Policy WHERE ApplicationId = @serviceId;
            
            --SELECT * FROM PolicyRole WHERE PolicyId IN (SELECT id FROM Policy WHERE ApplicationId = @serviceId)
            --SELECT * FROM @policyIdList

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

            -- SELECT * FROM Policy WHERE ApplicationId = @serviceId;
            -- SELECT * FROM PolicyRole WHERE PolicyId IN (SELECT id FROM Policy WHERE ApplicationId = @serviceId)

            -- Step 2) modify user_service_roles so that we only have them pointing to one of the (duplicated) administrator roles
            UPDATE user_service_roles
                SET role_id='4100b34b-15e5-4429-b132-8b3dba5a0eb2', UpdatedAt=GETDATE()
                WHERE id='52266a6f-fcae-4365-9297-b9603f3df12b';

            -- Step 3) delete the roles we don't need anymore
            --TODO

            -- Step 4) modify the roles we want to keep (Site Administrator, T Level Reviewer and Providers Editor)
            --TODO

            -- Step 5) add new policy and link with the three roles we kept
            --TODO

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