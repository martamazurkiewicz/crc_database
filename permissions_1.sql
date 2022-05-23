-- grant ADMIN (dba) permission to access web

BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => '*', 
    ace        => xs$ace_type(
    privilege_list => xs$name_list('http'),
                              principal_name => 'ADMIN',
                              principal_type => xs_acl.ptype_db)); 
END;
COMMIT;

BEGIN
   UTL_HTTP.SET_WALLET('');
END;
COMMIT;


SELECT UTL_HTTP.REQUEST('https://www.google.com') from DUAL;

-- create main (company offers & reservation schema), quota should probably be more than 100M
CREATE USER main
    IDENTIFIED BY password 
    DEFAULT TABLESPACE data
    QUOTA 100M ON data; 
GRANT CONNECT, RESOURCE TO main;
GRANT CREATE SESSION, CREATE TABLE TO main;
GRANT CREATE TRIGGER TO main;
GRANT CREATE SEQUENCE TO main;
GRANT CREATE VIEW TO main;
COMMIT;

-- grant main permission to access web
BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => '*', 
    ace        => xs$ace_type(
    privilege_list => xs$name_list('http'),
                              principal_name => 'MAIN',
                              principal_type => xs_acl.ptype_db)); 
END;
COMMIT;

-- create web (user used by web server without its own data, uses main schema tables)
CREATE USER web
    IDENTIFIED BY password
    DEFAULT TABLESPACE data; 
GRANT CONNECT TO web;
GRANT CREATE SESSION TO web;
GRANT SELECT ON main.available_offers TO web;
GRANT EXECUTE ON main.number_of_pages TO web;
GRANT EXECUTE ON main.available_offers_paginated TO web;
COMMIT;