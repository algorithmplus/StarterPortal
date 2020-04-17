BEGIN TRAN CLOSEORGSDQT

DECLARE @closedStatus AS INTEGER = 2;

--create list with all the organisations that need to be closed
DECLARE @orgNamesList AS TABLE (Value NVARCHAR(100));
INSERT INTO @orgNamesList VALUES ('A+ Teachers');
INSERT INTO @orgNamesList VALUES ('Abacus Resourcing');
INSERT INTO @orgNamesList VALUES ('Academy Recruitment');
INSERT INTO @orgNamesList VALUES ('Ace Appointments Midlands Ltd');
INSERT INTO @orgNamesList VALUES ('Action First Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Admiral Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Advantage Education Limited - 148');
INSERT INTO @orgNamesList VALUES ('Advocate Education');
INSERT INTO @orgNamesList VALUES ('Alderwood Education');
INSERT INTO @orgNamesList VALUES ('Amdas Education');
INSERT INTO @orgNamesList VALUES ('Ampersand Education Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Ashley Recruitment Consultants Ltd');
INSERT INTO @orgNamesList VALUES ('Assist Education Resourcing Ltd');
INSERT INTO @orgNamesList VALUES ('Baker Harding');
INSERT INTO @orgNamesList VALUES ('Beaver Employment Ltd');
INSERT INTO @orgNamesList VALUES ('Bell Education Limited');
INSERT INTO @orgNamesList VALUES ('Bernard Teaching Agency');
INSERT INTO @orgNamesList VALUES ('Black Country Supply Service');
INSERT INTO @orgNamesList VALUES ('Blueleaf Education');
INSERT INTO @orgNamesList VALUES ('Bourne Teachers Ltd');
INSERT INTO @orgNamesList VALUES ('BT Managed Services');
INSERT INTO @orgNamesList VALUES ('C2C Recruitment Services');
INSERT INTO @orgNamesList VALUES ('Cer Education');
INSERT INTO @orgNamesList VALUES ('Children''s Hospice South West');
INSERT INTO @orgNamesList VALUES ('Clever Clogs Education Recruitment Plc');
INSERT INTO @orgNamesList VALUES ('Coen Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Connaught Education');
INSERT INTO @orgNamesList VALUES ('Connect 2 Recruit Ltd');
INSERT INTO @orgNamesList VALUES ('Cover');
INSERT INTO @orgNamesList VALUES ('Eddison Knight Recruitment');
INSERT INTO @orgNamesList VALUES ('Education Appointments Ltd');
INSERT INTO @orgNamesList VALUES ('Education Personnel (Textbook Recruitment)');
INSERT INTO @orgNamesList VALUES ('Education Professionals');
INSERT INTO @orgNamesList VALUES ('Education Recruitment Limited');
INSERT INTO @orgNamesList VALUES ('Education Resourcing Limited');
INSERT INTO @orgNamesList VALUES ('Education Staffing Solutions');
INSERT INTO @orgNamesList VALUES ('Education VIP''s - 142');
INSERT INTO @orgNamesList VALUES ('Educatus Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Elite Education Limited - 181');
INSERT INTO @orgNamesList VALUES ('Eteach Group Services Limited');
INSERT INTO @orgNamesList VALUES ('Events 23');
INSERT INTO @orgNamesList VALUES ('First Call Teachers Ltd');
INSERT INTO @orgNamesList VALUES ('First Choice Recruitment');
INSERT INTO @orgNamesList VALUES ('First Class Teachers Ltd');
INSERT INTO @orgNamesList VALUES ('Flex Staffing Ltd (Education Dvision)');
INSERT INTO @orgNamesList VALUES ('G4S Employment Screening & Vetting');
INSERT INTO @orgNamesList VALUES ('General Teaching Council for Scotland');
INSERT INTO @orgNamesList VALUES ('Global Recruit Ltd');
INSERT INTO @orgNamesList VALUES ('GMD Education Ltd');
INSERT INTO @orgNamesList VALUES ('Green Inc (eu) Limited');
INSERT INTO @orgNamesList VALUES ('Growing Minds');
INSERT INTO @orgNamesList VALUES ('Hexa Education');
INSERT INTO @orgNamesList VALUES ('Hudson James Associates Ltd');
INSERT INTO @orgNamesList VALUES ('Humberside Engineering Training Association Ltd');
INSERT INTO @orgNamesList VALUES ('In 2 School''s Limited');
INSERT INTO @orgNamesList VALUES ('Inclusive Education Limited');
INSERT INTO @orgNamesList VALUES ('Inspire Learning Partners');
INSERT INTO @orgNamesList VALUES ('International Teacher Recruitment');
INSERT INTO @orgNamesList VALUES ('ITP Education Resourcing');
INSERT INTO @orgNamesList VALUES ('Jobline Staffing');
INSERT INTO @orgNamesList VALUES ('Kernow Ed Ltd');
INSERT INTO @orgNamesList VALUES ('Key Stage Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Key Stage Teachers');
INSERT INTO @orgNamesList VALUES ('KS Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('LCJ Education Services Ltd');
INSERT INTO @orgNamesList VALUES ('Logic Schools Services');
INSERT INTO @orgNamesList VALUES ('Lost and Found recruitment LTD');
INSERT INTO @orgNamesList VALUES ('LSG Recruitment');
INSERT INTO @orgNamesList VALUES ('Manpower UK Limited');
INSERT INTO @orgNamesList VALUES ('MEI');
INSERT INTO @orgNamesList VALUES ('Middle Management Recruitment');
INSERT INTO @orgNamesList VALUES ('MMB Education Limited');
INSERT INTO @orgNamesList VALUES ('Monarch Education - 154');
INSERT INTO @orgNamesList VALUES ('Nottingham Music Tuition Ltd');
INSERT INTO @orgNamesList VALUES ('Nottingham Tutorial College');
INSERT INTO @orgNamesList VALUES ('NP Teaching');
INSERT INTO @orgNamesList VALUES ('Paph Co-Operative CIC');
INSERT INTO @orgNamesList VALUES ('Parkside Education');
INSERT INTO @orgNamesList VALUES ('Pear Education Ltd');
INSERT INTO @orgNamesList VALUES ('Pearson TQ Education and Training');
INSERT INTO @orgNamesList VALUES ('Personnel Selection');
INSERT INTO @orgNamesList VALUES ('Pertemps Group');
INSERT INTO @orgNamesList VALUES ('Prestige Teachers Ltd');
INSERT INTO @orgNamesList VALUES ('Primary PPA Cover td');
INSERT INTO @orgNamesList VALUES ('Pritchard Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Professional Supply Service - 160');
INSERT INTO @orgNamesList VALUES ('PTA Global Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Qsted Ltd');
INSERT INTO @orgNamesList VALUES ('Recruitateacher');
INSERT INTO @orgNamesList VALUES ('SANZA Teaching Agency Limited');
INSERT INTO @orgNamesList VALUES ('School Staffing Ltd');
INSERT INTO @orgNamesList VALUES ('Service Children''s Education');
INSERT INTO @orgNamesList VALUES ('Servoca Education Resourcing Ltd');
INSERT INTO @orgNamesList VALUES ('SNAP Education LTD');
INSERT INTO @orgNamesList VALUES ('Standby Education');
INSERT INTO @orgNamesList VALUES ('STC Consortium Limited');
INSERT INTO @orgNamesList VALUES ('Strictly Education Ltd');
INSERT INTO @orgNamesList VALUES ('Supply Care Solutions');
INSERT INTO @orgNamesList VALUES ('Supply Teacher.Jobs');
INSERT INTO @orgNamesList VALUES ('Supply Teaching Staff Ltd');
INSERT INTO @orgNamesList VALUES ('Supplymatch Ltd');
INSERT INTO @orgNamesList VALUES ('Supreme Education');
INSERT INTO @orgNamesList VALUES ('Swale Home Education');
INSERT INTO @orgNamesList VALUES ('Symphony Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('T Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('TaskMaster Resourcing');
INSERT INTO @orgNamesList VALUES ('Teach 24 Limited');
INSERT INTO @orgNamesList VALUES ('Teach in Herts (manged by Herts for Learning)');
INSERT INTO @orgNamesList VALUES ('Teach Me Education');
INSERT INTO @orgNamesList VALUES ('Teacher Search Ltd');
INSERT INTO @orgNamesList VALUES ('Teacher Solutions Limited');
INSERT INTO @orgNamesList VALUES ('TeacherHub');
INSERT INTO @orgNamesList VALUES ('TeacherIn');
INSERT INTO @orgNamesList VALUES ('teachethica (UK) Limited');
INSERT INTO @orgNamesList VALUES ('Teachweb Limited');
INSERT INTO @orgNamesList VALUES ('Thames Teachers Ltd');
INSERT INTO @orgNamesList VALUES ('The HUb Recruitment Consultancy Ltd');
INSERT INTO @orgNamesList VALUES ('The Peoples Agency');
INSERT INTO @orgNamesList VALUES ('The Southover Partnership - 114');
INSERT INTO @orgNamesList VALUES ('The Supply Agency');
INSERT INTO @orgNamesList VALUES ('The Supply People Ltd');
INSERT INTO @orgNamesList VALUES ('Top Tutors (AOY)');
INSERT INTO @orgNamesList VALUES ('Trust Education - 140');
INSERT INTO @orgNamesList VALUES ('TutorBubble Ltd');
INSERT INTO @orgNamesList VALUES ('Uber Education Ltd');
INSERT INTO @orgNamesList VALUES ('We Are Recruitment');
INSERT INTO @orgNamesList VALUES ('Winners Recruitment Ltd');
INSERT INTO @orgNamesList VALUES ('Wydelta LTD');
INSERT INTO @orgNamesList VALUES ('Xpert Education LTD');
INSERT INTO @orgNamesList VALUES ('Yorkshire and Humberside Teacher Agency Ltd');
INSERT INTO @orgNamesList VALUES ('Yorkshire Education Solutions');
INSERT INTO @orgNamesList VALUES ('YoungEducation Ltd');

--where we will store the value for the current org to be closed
DECLARE @orgName AS VARCHAR(100);

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