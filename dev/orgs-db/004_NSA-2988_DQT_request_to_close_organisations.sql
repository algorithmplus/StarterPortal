BEGIN TRAN CLOSEORGSDQT

DECLARE @closedStatus AS INTEGER = 2;

--create list with all the organisations that need to be closed
DECLARE @orgLegacyIdsList AS TABLE (Value NVARCHAR(500));
INSERT INTO @orgLegacyIdsList (Value) VALUES
    ('1031959'),
    ('11330'),
    ('820'),
    ('1031300'),
    ('4420');

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