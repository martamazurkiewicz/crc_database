--set wallet for MAIN schema. Without wallet web connections cannot work
BEGIN
   UTL_HTTP.SET_WALLET('');
END;
COMMIT;

--SELECT UTL_HTTP.REQUEST('https://www.google.com') from DUAL;

GRANT SELECT ON main.available_offers TO web;
GRANT EXECUTE ON main.number_of_pages TO web;
GRANT EXECUTE ON main.available_offers_paginated TO web;
GRANT SELECT, INSERT, UPDATE, DELETE ON main.client TO web;
GRANT SELECT, DELETE ON main.reservation TO web;
GRANT INSERT(client_id, offer_id, participants_num) ON main.reservation TO web;
GRANT UPDATE(participants_num) ON main.reservation TO web;
GRANT EXECUTE ON main.reduce_avail_spots TO web;
commit;