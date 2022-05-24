CREATE OR REPLACE 
PACKAGE PROMO_PKG AS 
    TYPE price_diff_rec_type IS RECORD (r_offer_id NUMBER, r_price_diff NUMBER(7,2));
    TYPE price_diff_arr_type IS TABLE OF price_diff_rec_type;
    TYPE offers_arr_type IS TABLE OF NUMBER;
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_days_left IN NUMBER DEFAULT 7);
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_offers_arr offers_arr_type);
END PROMO_PKG;

CREATE OR REPLACE
PACKAGE BODY PROMO_PKG AS
    
    PROCEDURE save_price_diff(diff_arr IN price_diff_arr_type)
    AS
    BEGIN
            FORALL rc_num IN diff_arr.first..diff_arr.last
                MERGE INTO main.offer_price_archive p
                     USING (SELECT null FROM DUAL)
                    ON (p.offer_id = diff_arr(rc_num).r_offer_id)
                WHEN MATCHED THEN UPDATE
                    SET p.price_diff = p.price_diff + diff_arr(rc_num).r_price_diff
                WHEN NOT MATCHED THEN 
                INSERT (offer_id, price_diff)
                    VALUES (diff_arr(rc_num).r_offer_id, diff_arr(rc_num).r_price_diff);
        commit;
    END;
    
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_days_left IN NUMBER DEFAULT 7)
    AS 
    CURSOR lc_discouned_offers IS SELECT offer_id, price, minimal_price FROM main.offer 
        WHERE (SYSDATE + in_days_left >= end_offer_date AND end_offer_date >= SYSDATE) FOR UPDATE OF price;
    ln_new_price NUMBER;
    price_diff_rec price_diff_rec_type;
    price_diff_arr price_diff_arr_type := price_diff_arr_type();
    BEGIN
        FOR off IN lc_discouned_offers LOOP
            price_diff_arr.EXTEND;
            IF off.price*(1-in_discount_pct/100) >= off.minimal_price THEN 
                ln_new_price := off.price*(1-in_discount_pct/100);
            ELSE
                ln_new_price := off.minimal_price;
            END IF;
            UPDATE main.offer SET price = ln_new_price
                    WHERE CURRENT OF lc_discouned_offers;               
            price_diff_rec.r_offer_id := off.offer_id;
            price_diff_rec.r_price_diff := off.price - ln_new_price;
            price_diff_arr(price_diff_arr.LAST) := price_diff_rec;
        END LOOP;
        promo_pkg.save_price_diff(price_diff_arr);
    END seasonal_promo;

  PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_offers_arr IN offers_arr_type) AS
  ln_old_price NUMBER;
  price_diff_arr price_diff_arr_type := price_diff_arr_type();
  BEGIN
    FORALL off IN in_offers_arr.first..in_offers_arr.last
            UPDATE (SELECT offer_id, price, minimal_price, (SELECT offer.price FROM dual) old_price FROM offer)
                SET price = (CASE WHEN (price*(1-in_discount_pct/100)) >= minimal_price 
                THEN price*(1-in_discount_pct/100)
                ELSE minimal_price END)
                    WHERE offer_id = in_offers_arr(off)
                RETURNING offer_id, old_price - price BULK COLLECT INTO price_diff_arr;
    promo_pkg.save_price_diff(price_diff_arr);
  END seasonal_promo;

END PROMO_PKG;