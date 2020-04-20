BEGIN TRAN PROFILEPOSTLOGOUT

    insert into servicePostLogoutRedirectUris (serviceId,redirectUrl) VALUES ('dd4122b1-263a-4312-8f68-a26c208f72bf', 'https://pp-services.signin.education.gov.uk/signout');

ROLLBACK TRAN PROFILEPOSTLOGOUT
