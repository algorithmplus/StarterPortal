BEGIN TRAN manageUser
  insert into user_services (id,[status],user_id,organisation_id,service_id,createdAt,updatedAt) VALUES (NEWID(),1,'e04efa71-2d13-4c61-ad15-3977b1929212','e102d4ef-8279-4f9d-a114-af6ce7c5677e','b1f190aa-729a-45fc-a695-4ea209dc79d4',
  GETDATE(),GETDATE());

   insert into user_service_roles (id,user_id,service_id,organisation_id,role_id,createdAt,updatedAt) VALUES (NEWID(),'e04efa71-2d13-4c61-ad15-3977b1929212','b1f190aa-729a-45fc-a695-4ea209dc79d4','e102d4ef-8279-4f9d-a114-af6ce7c5677e',
  'ab168d58-599c-4b48-bc69-27bfd755077d',GETDATE(),GETDATE());

     insert into user_service_roles (id,user_id,service_id,organisation_id,role_id,createdAt,updatedAt) VALUES (NEWID(),'e04efa71-2d13-4c61-ad15-3977b1929212','b1f190aa-729a-45fc-a695-4ea209dc79d4','e102d4ef-8279-4f9d-a114-af6ce7c5677e',
  'a12a2225-7040-498d-9361-a6d04c8b3078',GETDATE(),GETDATE());

ROLLBACK TRAN manageUser
