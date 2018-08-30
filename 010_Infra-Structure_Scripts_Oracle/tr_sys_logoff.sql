-- https://docs.oracle.com/cd/E18283_01/appdev.112/e10766/tdddg_triggers.htm#BABGEAIA

/*
Creating Triggers that Log LOGON and LOGOFF Events
This tutorial shows how to use the CREATE TRIGGER statement to create two triggers, hr_logon_trigger and hr_logoff_trigger. After someone logs on as user HR, hr_logon_trigger adds a row to the table HR_USERS_LOG. Before someone logs off as user HR, hr_logoff_trigger adds a row to the table HR_USERS_LOG.

hr_logon_trigger and hr_logoff_trigger are system triggers. hr_logon_trigger is a BEFORE trigger, and hr_logoff_trigger is an AFTER trigger.
*/

CREATE OR REPLACE TRIGGER hr_logoff_trigger
  BEFORE LOGOFF
  ON HR.SCHEMA
BEGIN
  INSERT INTO hr_users_log (user_name, activity, event_date)
  VALUES (USER, 'LOGOFF', SYSDATE);
END;