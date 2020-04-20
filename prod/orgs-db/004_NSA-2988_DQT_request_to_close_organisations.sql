BEGIN TRAN CLOSEORGSDQT

DECLARE @closedStatus AS INTEGER = 2;

--create list with all the organisations that need to be closed
DECLARE @orgLegacyIdsList AS TABLE (Value NVARCHAR(500));
INSERT INTO @orgLegacyIdsList (Value) VALUES
    ('3000055'),
    ('3513690'),
    ('3400727'),
    ('3000061'),
    ('3411563'),
    ('3500393'),
    ('3000062'),
    ('3517123'),
    ('3000064'),
    ('3000065'),
    ('3508135'),
    ('3000069'),
    ('3500793'),
    ('3000074'),
    ('3500954'),
    ('3000076'),
    ('3409601'),
    ('3000077'),
    ('3508134'),
    ('3000081'),
    ('3500627'),
    ('3518008'),
    ('3400409'),
    ('3000086'),
    ('3517145'),
    ('3508248'),
    ('3000094'),
    ('3400766'),
    ('3000097'),
    ('3517912'),
    ('3000104'),
    ('3500611'),
    ('3000106'),
    ('3400334'),
    ('3504728'),
    ('3500441'),
    ('3000108'),
    ('3515370'),
    ('3000111'),
    ('3501070'),
    ('3400168'),
    ('3508325'),
    ('3500617'),
    ('3400801'),
    ('3500790'),
    ('3000127'),
    ('3517622'),
    ('3000132'),
    ('3000133'),
    ('3500889'),
    ('3510595'),
    ('3400246'),
    ('3000142'),
    ('3500890'),
    ('3400255'),
    ('3400174'),
    ('3500288'),
    ('3000144'),
    ('3000147'),
    ('3000150'),
    ('3500747'),
    ('3000153'),
    ('3500279'),
    ('3405804'),
    ('3517166'),
    ('3409196'),
    ('3400761'),
    ('3500507'),
    ('3407088'),
    ('3526720'),
    ('3400223'),
    ('3401908'),
    ('3000162'),
    ('3517150'),
    ('3501069'),
    ('3000167'),
    ('3400206'),
    ('3511206'),
    ('3000171'),
    ('3508225'),
    ('3000173'),
    ('3000174'),
    ('3511302'),
    ('3526507'),
    ('3517038'),
    ('3000181'),
    ('3508154'),
    ('3500304'),
    ('3518011'),
    ('3000195'),
    ('3000197'),
    ('3000198'),
    ('3000199'),
    ('3500628'),
    ('3511301'),
    ('3000206'),
    ('3000210'),
    ('3517820'),
    ('3517523'),
    ('3000217'),
    ('3000218'),
    ('3000219'),
    ('3500932'),
    ('3000222'),
    ('3000223'),
    ('3400487'),
    ('3000227'),
    ('3508381'),
    ('3000228'),
    ('3406626'),
    ('3408686'),
    ('3517268'),
    ('3511177'),
    ('3526756'),
    ('3507960'),
    ('3508251'),
    ('3400664'),
    ('3500400'),
    ('3000240'),
    ('3000242'),
    ('3516589'),
    ('3403492'),
    ('3000253'),
    ('3511175'),
    ('3510987'),
    ('3000259'),
    ('3518020'),
    ('3508256'),
    ('3500991'),
    ('3000263'),
    ('3400219'),
    ('3405802');

--here we will store the value for the current org to be closed
DECLARE @orgLegacyId AS VARCHAR(500);

--use cursor to loop through the list
DECLARE db_cursor CURSOR FOR
SELECT Value FROM @orgLegacyIdsList
OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @orgLegacyId

WHILE @@FETCH_STATUS = 0

BEGIN
    --execute following update if there is only one organisation with this legacyId
    IF (SELECT COUNT(*) FROM organisation WHERE legacyId = @orgLegacyId)  = 1
        BEGIN
            UPDATE organisation
            SET Status = @closedStatus, ClosedOn = GETDATE()
            WHERE legacyId = @orgLegacyId
                AND status <> @closedStatus
        END;

    ELSE
        IF (SELECT COUNT(*) FROM organisation WHERE legacyId = @orgLegacyId)  = 0
            PRINT 'The organisation ' + @orgLegacyId + ' was not found';
        ELSE
            PRINT 'The organisation ' + @orgLegacyId + ' was not closed as it could not be uniquely identified';

    -- get next organisation legacyId
    FETCH NEXT FROM db_cursor INTO @orgLegacyId;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;

ROLLBACK TRAN CLOSEORGSDQT