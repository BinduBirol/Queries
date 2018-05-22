
INSERT INTO JALALABAD.TEMP_SMS_LOCAL (
   CUSTOMER_ID, MOBILE_NO, TEXT, 
    STATUS)
select aa.CUSTOMER_ID, MOBILE,
'Dear Customer(ID-'||aa.CUSTOMER_ID||'),You have no unpaid gas bill upto April,2018. Helpline-16511.' txt,
'N'
from
(SELECT distinct CUSTOMER_ID
  FROM customer_connection 
 WHERE     status = 1
 and ismetered=0
       AND CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM TEMP_SMS_LOCAL)) aa,CUSTOMER_PERSONAL_INFO bb
       where aa.CUSTOMER_ID=bb.CUSTOMER_ID