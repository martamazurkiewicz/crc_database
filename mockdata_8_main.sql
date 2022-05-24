INSERT ALL
   INTO offer_type (name) VALUES ('Safari')
   INTO offer_type (name) VALUES ('City Breaks')
   INTO offer_type (name) VALUES ('Beach Holidays')
   INTO offer_type (name) VALUES ('Ski Holidays')
   SELECT 1 FROM dual;
commit;
   
INSERT ALL
   INTO destination (country_iso_id, name) VALUES ('PL', 'Warszawa')
   INTO destination (country_iso_id, name) VALUES ('MX', 'Cancun')
   INTO destination (country_iso_id, name) VALUES ('US', 'Newport')
   INTO destination (country_iso_id, name) VALUES ('BS', 'Nassau')
   INTO destination (country_iso_id, name) VALUES ('GB', 'Birmingham')
   INTO destination (country_iso_id, name) VALUES ('UG', 'Kampala')
   SELECT 1 FROM dual;
commit;

INSERT ALL
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (1, 'Safari', 7500.00, 4800.00, to_date('2022-09-10','yyyy-mm-dd'),to_date('2022-09-22','yyyy-mm-dd'), 6, to_date('2022-08','yyyy-mm'), 40)
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (2, 'Visit Birmingham', 2500.00, 900.00, to_date('2022-07-12','yyyy-mm-dd'),to_date('2022-07-22','yyyy-mm-dd'), 5, to_date('2022-07-10','yyyy-mm-dd'), 55)
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (3, 'Bahamas', 5250.00, 4800.00, to_date('2023-01-25','yyyy-mm-dd'),to_date('2023-02-14','yyyy-mm-dd'), 4, to_date('2022-11','yyyy-mm'), 85)
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (3, 'Yucatan', 5100.00, 2600.00, to_date('2022-10-15','yyyy-mm-dd'),to_date('2022-10-30','yyyy-mm-dd'), 2, to_date('2022-10','yyyy-mm'), 130)
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (4, 'Vermont', 4780.00, 2400.00, to_date('2022-12-22','yyyy-mm-dd'),to_date('2023-01-03','yyyy-mm-dd'), 3, to_date('2022-12','yyyy-mm'), 40)
   INTO offer(type_id, name, price, minimal_price, departure_date, comeback_date, destination_id, end_offer_date, spots_left) 
   VALUES (2, 'Warszawa', 800.00, 300.00, to_date('2022-08-11','yyyy-mm-dd'),to_date('2022-08-16','yyyy-mm-dd'), 1, to_date('2022-08','yyyy-mm'), 3)
   SELECT 1 FROM dual;
commit;

INSERT ALL
   INTO client(email) VALUES ('admin@test.com')
   INTO client(email) VALUES ('user@test.com')
   SELECT 1 FROM dual;
commit;