create or replace PACKAGE COUNTRY_PKG AS 

  PROCEDURE validate_country_code(iv_code IN VARCHAR2);
  FUNCTION find_country_name (iv_code IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION find_country_region (iv_code IN VARCHAR2) RETURN VARCHAR2;
  country_not_found_error EXCEPTION;
  api_error EXCEPTION;

END COUNTRY_PKG;

create or replace PACKAGE BODY COUNTRY_PKG AS

PROCEDURE save_api_error(iv_sqlcode VARCHAR2, iv_sqlerrms VARCHAR2, iv_location VARCHAR2)
AS
PRAGMA autonomous_transaction;
BEGIN
    INSERT INTO main.country_api_error(sqlcode, sqlerrms, location) VALUES (iv_sqlcode, iv_sqlerrms, iv_location);
    commit;
END save_api_error;

PROCEDURE validate_country_code(iv_code IN VARCHAR2) AS
  lv_id  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].id') INTO lv_id FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.validate_country_code');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_id IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
END validate_country_code;
  
FUNCTION find_country_name(iv_code IN VARCHAR2) RETURN VARCHAR2 
AS
    lv_name  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].name') INTO lv_name FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_name');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_name IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
    RETURN lv_name;
END find_country_name;
    
FUNCTION find_country_region(iv_code IN VARCHAR2) RETURN VARCHAR2
AS
    lv_region  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].region.value') INTO lv_region FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_region');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_region IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
    RETURN lv_region;
END find_country_region;
  
END COUNTRY_PKG;