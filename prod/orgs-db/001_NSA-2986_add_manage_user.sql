BEGIN TRAN ADDMANAGEUSER

    INSERT INTO user_services (id, status, user_id, organisation_id, service_id, createdAt, updatedAt)
    VALUES (NEWID(), 1,'8896fe1b-cea4-440f-bd39-a05000f89835','7d48d8ff-a322-4f22-8a79-c0425ac69749', 'b1f190aa-729a-45fc-a695-4ea209dc79d4', GETDATE(), GETDATE());

    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '8896fe1b-cea4-440f-bd39-a05000f89835', 'b1f190aa-729a-45fc-a695-4ea209dc79d4', '7d48d8ff-a322-4f22-8a79-c0425ac69749', '94632326-d3c7-4706-b2df-047031b655be', GETDATE(), GETDATE());

    INSERT INTO user_service_roles (id, user_id, service_id, organisation_id, role_id, createdAt, updatedAt)
    VALUES (NEWID(), '8896fe1b-cea4-440f-bd39-a05000f89835', 'b1f190aa-729a-45fc-a695-4ea209dc79d4', '7d48d8ff-a322-4f22-8a79-c0425ac69749', 'ff896869-b6f6-4d3d-a6b3-fe85fda51527', GETDATE(), GETDATE());

ROLLBACK TRAN ADDMANAGEUSER
