BEGIN TRAN ADDUKRPNTOROATPORGS

UPDATE organisation
    SET UKPRN= '10043978', UpdatedAt=GETDATE()
    WHERE id='339ee051-204e-463b-b9b2-85d7699723f4';

UPDATE organisation
    SET UKPRN= '10052835', UpdatedAt=GETDATE()
    WHERE id='a055d692-6559-487a-80ae-661a5e0f53e2';

UPDATE organisation
    SET UKPRN= '10059861', UpdatedAt=GETDATE()
    WHERE id='31547868-b2a4-42e1-b03d-0113ceada4b5';

UPDATE organisation
    SET UKPRN= '10060111', UpdatedAt=GETDATE()
    WHERE id='e355d003-4ff1-4490-b051-879157b64a2c';

ROLLBACK TRAN ADDUKRPNTOROATPORGS
