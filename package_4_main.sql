CREATE OR REPLACE PACKAGE BODY COUNTRY_PKG AS

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
    SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].name') INTO lv_id FROM dual;
    IF lv_id IS NULL THEN
        RAISE country_not_found_error;
    END IF;
EXCEPTION WHEN OTHERS THEN
    country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_name');
    dbms_output.put_line('Error occured. Check  main.country_api_error table');
END validate_country_code;
  
FUNCTION find_country_name(iv_code IN VARCHAR2) RETURN VARCHAR2 
AS
    lv_name  VARCHAR2(200);
BEGIN
    SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].name') INTO lv_name FROM dual;
    IF lv_name IS NULL THEN
        RAISE country_not_found_error;
    END IF;
    RETURN lv_name;
EXCEPTION 
    WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_name');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        return null;
END find_country_name;
    
FUNCTION find_country_region(iv_code IN VARCHAR2) RETURN VARCHAR2
AS
    lv_region  VARCHAR2(200);
BEGIN
    SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].region.value') INTO lv_region FROM dual;
    IF lv_region IS NULL THEN
        RAISE country_not_found_error;
    END IF;
    RETURN lv_region;
EXCEPTION 
    WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_region');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        return null;
END;
  
END COUNTRY_PKG;