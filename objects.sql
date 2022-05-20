CREATE INDEX offer_available_idx   
    ON  main.offer (has_free_spots);
 
CREATE OR REPLACE TRIGGER main.reduce_avail_spots_tg 
    BEFORE DELETE OR INSERT OR UPDATE OF participants_num ON main.reservation
    FOR EACH ROW
    CALL main.reduce_avail_spots(:new.participants_num, :old.participants_num, :new.offer_id);
    
CREATE OR REPLACE PROCEDURE main.reduce_avail_spots(in_new_part_num IN NUMBER, in_old_part_num IN NUMBER, in_offer_id IN NUMBER)
AS
BEGIN
    UPDATE main.offer SET spots_left = (CASE 
        WHEN (in_old_part_num IS NOT NULL AND in_new_part_num IS NOT NULL) THEN 
            spots_left = spots_left + in_old_part_num- in_new_part_num
        WHEN (in_old_part_num IS NOT NULL) THEN
            spots_left + in_old_part_num
        ELSE spots_left - in_new_part_num
            END) 
        WHERE offer_id = in_offer_id;
EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        DBMS_OUTPUT.PUT_LINE('Number of participants in reservation is above the number of still available spots for offer with id ' || in_offer_id;
END