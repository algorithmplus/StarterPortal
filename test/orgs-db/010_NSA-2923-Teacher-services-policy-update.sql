BEGIN TRAN TSEMPACCESS
BEGIN TRY
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyidOrg as UNIQUEIDENTIFIER;
    DECLARE @roleId as UNIQUEIDENTIFIER;
    DECLARE @numericId as BIGINT;

    SET @serviceId = (SELECT id FROM Service WHERE name = 'Evolve - Employer Access - Schools');

    SET @policyidOrg = (SELECT id FROM [Policy] WHERE name = 'TA Administration' and ApplicationId=@serviceId);

    DELETE from PolicyCondition where PolicyId=@policyidOrg;

     INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt, UpdatedAt)
        VALUES (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '01', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '02', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '03', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '05', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '06', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '07', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '08', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '10', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '11', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '12', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '14', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '15', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '18', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '24', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '25', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '26', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '28', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '29', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '30', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '32', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '33', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '34', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '35', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '36', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '38', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '39', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '40', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '41', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '42', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '43', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '44', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '45', GETDATE(), GETDATE()),

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '46', GETDATE(), GETDATE()),

ROLLBACK TRAN TSEMPACCESS

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
              ROLLBACK TRAN TSEMPACCESS;
END CATCH;
