BEGIN TRAN TSEMPACCESS
BEGIN TRY
    DECLARE @serviceId UNIQUEIDENTIFIER;
    DECLARE @policyidOrg as UNIQUEIDENTIFIER;
    DECLARE @roleId as UNIQUEIDENTIFIER;
    DECLARE @numericId as BIGINT;

    SET @serviceId = (SELECT id FROM Service WHERE name = 'Teacher Services - Employer Access - Schools');

    -- Cleaning in prod before setting new policies
    IF(select count(*) from PolicyCondition where PolicyId in (select id from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools')) = 3
    BEGIN
        DELETE from PolicyCondition where PolicyId in (select id from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools');
    END;
    ELSE
    BEGIN
        PRINT 'PolicyCondition not deleted for the service  ' + @serviceId;
    END;

    IF(select count(*) from PolicyRole where PolicyId in (select id from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools')) = 1
    BEGIN
        DELETE from PolicyRole where PolicyId in (select id from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools');
    END;
    ELSE
    BEGIN
        PRINT 'PolicyRole not deleted for the service  ' + @serviceId;
    END;

    IF(select count(*) from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools') = 1
    BEGIN
        DELETE from [Policy] where ApplicationId=@serviceId and name='Evolve - Employer Access - Schools';
    END;
    ELSE
    BEGIN
        PRINT 'Policy not deleted for the service  ' + @serviceId;
    END;

    IF(SELECT COUNT(*) FROM ROLE WHERE name = 'Teacher Services – Employers') = 0
    BEGIN
        SET @roleId = NEWID();
        SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
        INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
        VALUES (@roleId, 'Teacher Services – Employers', @serviceId, 1, GETDATE(), GETDATE(), 'EvolveEmpAccessSchool', @numericId, null);
    END ;

    ELSE
    BEGIN
        SET @roleId = (SELECT id FROM Role WHERE name = 'Teacher Services – Employers')
    END;

    IF(SELECT COUNT(*) FROM POLICY WHERE name = 'TA Administration') = 0
    BEGIN
        SET @policyidOrg = NEWID();
        INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
        VALUES (@policyidOrg, 'TA Administration', @serviceId, 1, getdate(), getdate());
    END;

    ELSE

    BEGIN
        SET @policyidOrg = (SELECT id FROM [Policy] WHERE name = 'TA Administration' and ApplicationId=@serviceId);
    END;

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

         (NEWID(), @policyidOrg, 'organisation.type.id', 'is', '46', GETDATE(), GETDATE());

    -- adding policy to role
    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyidOrg, @roleId, GETDATE(), GETDATE());

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
