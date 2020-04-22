BEGIN TRANSACTION DELETEROLE;
BEGIN TRY  

IF (SELECT COUNT(*)
FROM ROLE
WHERE name = 'ASP Ofsted Download' AND ApplicationId = 'df2ae7f3-917a-4489-8a62-8b9b536a71cc')  = 1
BEGIN
    DELETE FROM
            Role
        WHERE
            name = 'ASP Ofsted Download' AND
        ApplicationId = 'df2ae7f3-917a-4489-8a62-8b9b536a71cc';
END
ELSE
BEGIN
    IF (SELECT COUNT(*)
    FROM ROLE
    WHERE name = 'ASP Ofsted Download' AND ApplicationId = 'df2ae7f3-917a-4489-8a62-8b9b536a71cc') > 1
        PRINT 'The role `ASP Ofsted Download has duplicates';
    ELSE 
        PRINT 'The role `ASP Ofsted Download` does not exist'
END


    --Commit transaction if all went fine
    ROLLBACK TRAN DELETEROLE;

    END TRY
BEGIN CATCH
     SELECT
    ERROR_NUMBER() AS ErrorNumber  
        , ERROR_SEVERITY() AS ErrorSeverity  
        , ERROR_STATE() AS ErrorState  
        , ERROR_PROCEDURE() AS ErrorProcedure  
        , ERROR_LINE() AS ErrorLine  
        , ERROR_MESSAGE() AS ErrorMessage;  
     --Rollback if there was an error
     IF @@TRANCOUNT > 0
          ROLLBACK TRAN DELETEROLE;
END CATCH;