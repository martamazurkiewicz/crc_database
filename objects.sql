CREATE INDEX offer_available_idx   
    ON  main.offer (has_free_spots);
 
CREATE OR REPLACE TRIGGER main.reduce_avail_spots_tg 
    BEFORE DELETE OR INSERT OR UPDATE OF participants_num ON main.reservation
    FOR EACH ROW
    BEGIN
        main.reduce_avail_spots(:new.participants_num, :old.participants_num, :new.offer_id);
    END;

-- this procedure (trigger) works for action done via web page, so it returns the check_violation to server   
CREATE OR REPLACE PROCEDURE main.reduce_avail_spots (in_new_part_num IN NUMBER, in_old_part_num IN NUMBER, in_offer_id IN NUMBER)
AS
  check_violation EXCEPTION;
  PRAGMA exception_init(check_violation, -2290);
BEGIN
    UPDATE main.offer SET spots_left = (CASE 
        WHEN (in_old_part_num IS NOT NULL AND in_new_part_num IS NOT NULL) THEN 
            spots_left + in_old_part_num- in_new_part_num
        WHEN (in_old_part_num IS NOT NULL) THEN
            spots_left + in_old_part_num
        ELSE spots_left - in_new_part_num
            END)
        WHERE offer_id = in_offer_id;
    commit;
EXCEPTION
    WHEN check_violation THEN
        RAISE_APPLICATION_ERROR(sqlcode, 'Not enought free spots in choosen offer');
        --DBMS_OUTPUT.PUT_LINE('Number of participants in reservation is above the number of still available spots for offer with id ' || in_offer_id);
END;

CREATE TRIGGER main.client_pk_insert
BEFORE INSERT ON main.client 
FOR EACH ROW 
BEGIN
  :new.client_id := main.client_seq.nextval;
END;

CREATE TRIGGER main.dest_pk_insert
BEFORE INSERT ON main.destination
FOR EACH ROW 
BEGIN
    country_pkg.validate_country_code(:new.country_iso_id);
    :new.destination_id := main.destination_seq.nextval;
END;

CREATE OR REPLACE TRIGGER main.dest_validate_country
BEFORE UPDATE OF country_iso_id ON main.destination
FOR EACH ROW
BEGIN
    country_pkg.validate_country_code(:new.country_iso_id);
END;

CREATE TRIGGER main.offer_pk_insert
BEFORE INSERT ON main.offer
FOR EACH ROW 
BEGIN
  :new.offer_id := main.offer_seq.nextval;
END;

CREATE TRIGGER main.offer_type_pk_insert
BEFORE INSERT ON main.offer_type
FOR EACH ROW 
BEGIN
  :new.type_id := main.offer_type_seq.nextval;
END;