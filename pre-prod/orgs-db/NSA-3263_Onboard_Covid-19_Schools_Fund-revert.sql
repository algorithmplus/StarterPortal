BEGIN TRAN COVID19_SCHOOLS_FUND_FORM_REVERT

BEGIN TRY

 DECLARE @roleid UNIQUEIDENTIFIER;
    DECLARE @policyid UNIQUEIDENTIFIER;
    DECLARE @numericId BIGINT;
    DECLARE @collectionServiceId UNIQUEIDENTIFIER = (select id from service where name ='Online Collections Service')
    DECLARE @role1Id UNIQUEIDENTIFIER = (select Id from Role where Name='Coronavirus (COVID-19) Schools Fund' AND applicationId =@collectionServiceId)
    DECLARE @policy1Id UNIQUEIDENTIFIER = (select Id from Policy where Name='COVID-19 Schools Fund - Orgs category' AND ApplicationId =@collectionServiceId)
    DECLARE @policy2Id UNIQUEIDENTIFIER = (select Id from Policy where Name='COVID-19 Schools Fund - Orgs type' AND ApplicationId =@collectionServiceId)


    DELETE from PolicyCondition where PolicyId=@policy1Id
    DELETE from PolicyRole where PolicyId=@policy1Id AND RoleId=@role1Id
    DELETE from Policy where Id=@policy1Id AND ApplicationId=@collectionServiceId

    DELETE from PolicyCondition where PolicyId=@policy2Id
    DELETE from PolicyRole where PolicyId=@policy2Id AND RoleId =@role1Id
    DELETE from Policy where Id=@policy2Id AND ApplicationId =@collectionServiceId

    DELETE from invitation_service_roles where role_id=@role1Id
    DELETE from user_service_roles where role_id=@role1Id
    DELETE from Role where Id=@role1Id
    DELETE from serviceParams where paramName='COVID-19_SCHOOLS_FUND_FORM_ACCESS' AND serviceId =@collectionServiceId

    ROLLBACK TRAN COVID19_SCHOOLS_FUND_FORM_REVERT

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
          ROLLBACK TRAN COVID19_SCHOOLS_FUND_FORM_REVERT;

END CATCH;
