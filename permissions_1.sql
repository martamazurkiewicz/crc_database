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


-- grant MAIN (company offers & reservation schema) permission to access web
BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => '*', 
    ace        => xs$ace_type(
    privilege_list => xs$name_list('http'),
                              principal_name => 'MAIN',
                              principal_type => xs_acl.ptype_db)); 
END;
COMMIT;

-- choose right tablespace
ALTER USER main quota 100M on data;