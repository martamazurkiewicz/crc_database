--set wallet for MAIN schema. Without wallet web connections cannot work
BEGIN
   UTL_HTTP.SET_WALLET('');
END;
COMMIT;

--SELECT UTL_HTTP.REQUEST('https://www.google.com') from DUAL;