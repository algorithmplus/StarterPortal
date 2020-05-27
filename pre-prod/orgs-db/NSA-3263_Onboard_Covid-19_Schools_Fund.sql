BEGIN TRAN COVID19_SCHOOLS_FUND_FORM

BEGIN TRY

 DECLARE @roleid UNIQUEIDENTIFIER;
    DECLARE @policyid UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;
    DECLARE @collectionServiceId UNIQUEIDENTIFIER = (select id from service where name ='Online Collections Service')
    SET @roleid = newid();
    SET @numericId = NEXT VALUE FOR role_numeric_id_sequence;
    INSERT INTO Role (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt, Code, NumericId, ParentId)
    VALUES (@roleid, 'Coronavirus (COVID-19) Schools Fund', @collectionServiceId, 1, getdate(), getdate(), 'COVID-19_SCHOOLS_FUND_FORM_ACCESS', @numericId, null);

    INSERT INTO serviceParams (serviceId, paramName, paramValue)
    VALUES (@collectionServiceId, 'COVID-19_SCHOOLS_FUND_FORM_ACCESS', 'https://form-sso.education.gov.uk/service/trail-page');

    -- COVID-19 Schools Fund orgs category access
    SET @policyid = newid();
    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyid, 'COVID-19 Schools Fund - Orgs category', @collectionServiceId, 1, getdate(), getdate());
    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyid, @roleid, getdate(), getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.status.id', 'is', '1', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.status.id', 'is', '4', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.status.id', 'is', '3', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.category.id', 'is', '001', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.category.id', 'is', '002', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.category.id', 'is', '010', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.category.id', 'is', '013', getdate(),
getdate());
    -- COVID-19 Schools Fund orgs types access
    SET @policyid = newid();
    INSERT INTO Policy (Id, Name, ApplicationId, Status, CreatedAt, UpdatedAt)
    VALUES (@policyid, 'COVID-19 Schools Fund - Orgs type', @collectionServiceId, 1, getdate(), getdate());
    INSERT INTO PolicyRole (PolicyId, RoleId, CreatedAt, UpdatedAt)
    VALUES (@policyid, @roleid, getdate(), getdate());

    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '01', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '02', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '03', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '05', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '07', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '08', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '12', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '14', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '15', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '28', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '33', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '34', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '35', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '36', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '38', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '40', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '41', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '42', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '43', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '44', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '45', getdate(),
getdate());
    INSERT INTO PolicyCondition (Id, PolicyId, Field, Operator, Value, CreatedAt,
UpdatedAt)
    VALUES (newid(), @policyid, 'organisation.type.id', 'is', '46', getdate(),
getdate());

    ROLLBACK TRAN COVID19_SCHOOLS_FUND_FORM

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
          ROLLBACK TRAN COVID19_SCHOOLS_FUND_FORM;

END CATCH;
