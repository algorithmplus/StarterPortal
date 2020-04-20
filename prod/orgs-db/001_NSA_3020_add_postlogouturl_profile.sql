BEGIN TRAN PROFILEPOSTLOGOUT

    insert into servicePostLogoutRedirectUris (serviceId,redirectUrl) VALUES ('0b030112-b8b1-4a70-a47a-316af0c22e71', 'https://services.signin.education.gov.uk/signout');

ROLLBACK TRAN PROFILEPOSTLOGOUT
