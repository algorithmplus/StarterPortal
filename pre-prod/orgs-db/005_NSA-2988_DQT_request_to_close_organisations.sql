BEGIN TRAN CLOSEORGSDQT

DECLARE @closedStatus AS INTEGER = 2;

--create list with all the organisations that need to be closed
DECLARE @orgNamesList AS TABLE (Value NVARCHAR(500));
INSERT INTO @orgNamesList (Value) VALUES
    ('A+ Teachers'),
    ('Abacus Resourcing'),
    ('Academy Recruitment'),
    ('Ace Appointments Midlands Ltd'),
    ('Action First Recruitment Ltd'),
    ('Admiral Recruitment Ltd'),
    ('Advantage Education Limited - 148'),
    ('Advocate Education'),
    ('Alderwood Education'),
    ('Amdas Education'),
    ('Ampersand Education Recruitment Ltd'),
    ('Ashley Recruitment Consultants Ltd'),
    ('Assist Education Resourcing Ltd'),
    ('Baker Harding'),
    ('Beaver Employment Ltd'),
    ('Bell Education Limited'),
    ('Bernard Teaching Agency'),
    ('Black Country Supply Service'),
    ('Blueleaf Education'),
    ('Bourne Teachers Ltd'),
    ('BT Managed Services'),
    ('C2C Recruitment Services'),
    ('Cer Education'),
    ('Children''s Hospice South West'),
    ('Clever Clogs Education Recruitment Plc'),
    ('Coen Recruitment Ltd'),
    ('Connaught Education'),
    ('Connect 2 Recruit Ltd'),
    ('Cover'),
    ('Eddison Knight Recruitment'),
    ('Education Appointments Ltd'),
    ('Education Personnel (Textbook Recruitment)'),
    ('Education Professionals'),
    ('Education Recruitment Limited'),
    ('Education Resourcing Limited'),
    ('Education Staffing Solutions'),
    ('Education VIP''s - 142'),
    ('Educatus Recruitment Ltd'),
    ('Elite Education Limited - 181'),
    ('Eteach Group Services Limited'),
    ('Events 23'),
    ('First Call Teachers Ltd'),
    ('First Choice Recruitment'),
    ('First Class Teachers Ltd'),
    ('Flex Staffing Ltd (Education Dvision)'),
    ('G4S Employment Screening & Vetting'),
    ('General Teaching Council for Scotland'),
    ('Global Recruit Ltd'),
    ('GMD Education Ltd'),
    ('Green Inc (eu) Limited'),
    ('Growing Minds'),
    ('Hexa Education'),
    ('Hudson James Associates Ltd'),
    ('Humberside Engineering Training Association Ltd'),
    ('In 2 School''s Limited'),
    ('Inclusive Education Limited'),
    ('Inspire Learning Partners'),
    ('International Teacher Recruitment'),
    ('ITP Education Resourcing'),
    ('Jobline Staffing'),
    ('Kernow Ed Ltd'),
    ('Key Stage Recruitment Ltd'),
    ('Key Stage Teachers'),
    ('KS Recruitment Ltd'),
    ('LCJ Education Services Ltd'),
    ('Logic Schools Services'),
    ('Lost and Found recruitment LTD'),
    ('LSG Recruitment'),
    ('Manpower UK Limited'),
    ('MEI'),
    ('Middle Management Recruitment'),
    ('MMB Education Limited'),
    ('Monarch Education - 154'),
    ('Nottingham Music Tuition Ltd'),
    ('Nottingham Tutorial College'),
    ('NP Teaching'),
    ('Paph Co-Operative CIC'),
    ('Parkside Education'),
    ('Pear Education Ltd'),
    ('Pearson TQ Education and Training'),
    ('Personnel Selection'),
    ('Pertemps Group'),
    ('Prestige Teachers Ltd'),
    ('Primary PPA Cover td'),
    ('Pritchard Recruitment Ltd'),
    ('Professional Supply Service - 160'),
    ('PTA Global Recruitment Ltd'),
    ('Qsted Ltd'),
    ('Recruitateacher'),
    ('SANZA Teaching Agency Limited'),
    ('School Staffing Ltd'),
    ('Service Children''s Education'),
    ('Servoca Education Resourcing Ltd'),
    ('SNAP Education LTD'),
    ('Standby Education'),
    ('STC Consortium Limited'),
    ('Strictly Education Ltd'),
    ('Supply Care Solutions'),
    ('Supply Teacher.Jobs'),
    ('Supply Teaching Staff Ltd'),
    ('Supplymatch Ltd'),
    ('Supreme Education'),
    ('Swale Home Education'),
    ('Symphony Recruitment Ltd'),
    ('T Recruitment Ltd'),
    ('TaskMaster Resourcing'),
    ('Teach 24 Limited'),
    ('Teach in Herts (manged by Herts for Learning)'),
    ('Teach Me Education'),
    ('Teacher Search Ltd'),
    ('Teacher Solutions Limited'),
    ('TeacherHub'),
    ('TeacherIn'),
    ('teachethica (UK) Limited'),
    ('Teachweb Limited'),
    ('Thames Teachers Ltd'),
    ('The HUb Recruitment Consultancy Ltd'),
    ('The Peoples Agency'),
    ('The Southover Partnership - 114'),
    ('The Supply Agency'),
    ('The Supply People Ltd'),
    ('Top Tutors (AOY)'),
    ('Trust Education - 140'),
    ('TutorBubble Ltd'),
    ('Uber Education Ltd'),
    ('We Are Recruitment'),
    ('Winners Recruitment Ltd'),
    ('Wydelta LTD'),
    ('Xpert Education LTD'),
    ('Yorkshire and Humberside Teacher Agency Ltd'),
    ('Yorkshire Education Solutions'),
    ('YoungEducation Ltd');

--here we will store the value for the current org to be closed
DECLARE @orgName AS VARCHAR(500);

--use cursor to loop through the list
DECLARE db_cursor CURSOR FOR
SELECT Value FROM @orgNamesList
OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @orgName

WHILE @@FETCH_STATUS = 0

BEGIN
    --execute following update if there is only one organisation with this name
    IF (SELECT COUNT(*) FROM organisation WHERE name = @orgName)  = 1
        BEGIN
            UPDATE organisation
            SET Status = @closedStatus, ClosedOn = GETDATE()
            WHERE name = @orgName
                AND status <> @closedStatus
        END;

    ELSE
        IF (SELECT COUNT(*) FROM organisation WHERE name = @orgName)  = 0
            PRINT 'The organisation ' + @orgName + ' was not found';
        ELSE
            PRINT 'The organisation ' + @orgName + ' was not closed as it could not be uniquely identified';

    -- get next organisation name
    FETCH NEXT FROM db_cursor INTO @orgName;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;

ROLLBACK TRAN CLOSEORGSDQT