CREATE OR REPLACE FUNCTION available_offers_paginated(start_row_num IN NUMBER DEFAULT 1, per_page IN NUMBER DEFAULT 30)
RETURN SYS_REFCURSOR
AS
    lc_av_off SYS_REFCURSOR;
BEGIN
    OPEN lc_av_off FOR SELECT * FROM (SELECT ao.*, rownum rn FROM (SELECT * FROM main.available_offers ORDER BY offer_id) ao WHERE rownum < start_row_num+per_page) WHERE rn >= start_row_num;
    RETURN lc_av_off;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        null;
    WHEN OTHERS THEN
        RAISE;
END;

create or replace FUNCTION number_of_pages(per_page IN NUMBER DEFAULT 30) RETURN NUMBER
AS 
ln_pages NUMBER;
BEGIN
    SELECT FLOOR(COUNT(offer_id)/per_page) INTO ln_pages FROM available_offers;
    RETURN ln_pages;
END;