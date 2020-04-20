BEGIN TRAN PROFILEPOSTLOGOUT

    insert into servicePostLogoutRedirectUris (serviceId,redirectUrl) VALUES ('c31b5da5-4538-4188-aa3a-d53593af98e3', 'https://test-services.signin.education.gov.uk/signout');

ROLLBACK TRAN PROFILEPOSTLOGOUT
