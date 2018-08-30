DROP PROCEDURE send_email_simple;

CREATE OR REPLACE PROCEDURE send_email_simple (
    p_to        IN VARCHAR2,
    p_from      IN VARCHAR2,
    p_message   IN VARCHAR2,
    p_smtp_host IN VARCHAR2,
    p_smtp_port IN NUMBER DEFAULT 25
    )
    
AS

  l_mail_conn   UTL_SMTP.connection;
  
BEGIN

    EXECUTE IMMEDIATE 'ALTER SESSION SET smtp_out_server = ''127.0.0.1''';

    l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
    
    UTL_SMTP.helo(l_mail_conn, p_smtp_host);
    UTL_SMTP.mail(l_mail_conn, p_from);
    UTL_SMTP.rcpt(l_mail_conn, p_to);
    UTL_SMTP.data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
    UTL_SMTP.quit(l_mail_conn);
  
END;
/


BEGIN
  send_email_simple (
    p_to        => 'me@mycompany.com',
    p_from      => 'admin@mycompany.com',
    p_message   => 'This is a test message.',
    p_smtp_host => 'smtp.office365.com'
    );
END;
/


BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'prds_dev_email.xml', 
    description  => 'Email for PRDS_Dev',
    principal    => 'PRDS_DEV',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl => 'prds_dev_email.xml',
    host => 'smtp.office365.com', 
    lower_port => 25,
    upper_port => 25); 
  COMMIT;
END;
/

select acl, principal  
from dba_network_acl_privileges;
/

select acl, principal  
from dba_network_acl_privileges  
where principal like 'APEX%';
/

DECLARE
  ACL_PATH  VARCHAR2(4000);
BEGIN
  -- Look for the ACL currently assigned to '*' and give APEX_050100
  -- the "connect" privilege if APEX_050100 does not have the privilege yet.
 
  SELECT ACL INTO ACL_PATH FROM DBA_NETWORK_ACLS
   WHERE HOST = '*' AND LOWER_PORT IS NULL AND UPPER_PORT IS NULL;
 
  IF DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE(ACL_PATH, 'APEX_050100',
     'connect') IS NULL THEN
      DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(ACL_PATH,
     'APEX_050100', TRUE, 'connect');
  END IF;
 
EXCEPTION
  -- When no ACL has been assigned to '*'.
  WHEN NO_DATA_FOUND THEN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL('power_users.xml',
    'ACL that lets power users to connect to everywhere',
    'APEX_050100', TRUE, 'connect');
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL('power_users.xml','*');
END;
/
COMMIT;

