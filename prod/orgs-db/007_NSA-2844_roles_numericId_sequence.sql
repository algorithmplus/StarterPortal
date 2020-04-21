BEGIN TRAN ROLENUMERICIDSEQUENCE

IF NOT EXISTS(SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[role_numeric_id_sequence]') AND type = 'SO')

    CREATE SEQUENCE [dbo].[role_numeric_id_sequence]
        AS [bigint]
        START WITH 197
        INCREMENT BY 1
        MINVALUE 197
        MAXVALUE 9223372036854775807
        CACHE 50
GO

ROLLBACK TRAN ROLENUMERICIDSEQUENCE
