/* Formatted on 4/17/2018 5:07:05 PM (QP5 v5.227.12220.39754) */
SELECT DISTINCT CUSTOMER_ID FROM burner_qnt_change
MINUS
SELECT DISTINCT CUSTOMER_ID
  FROM burner_qnt_change
 WHERE pid  IN (  SELECT MAX (pid)
                   FROM burner_qnt_change
               GROUP BY CUSTOMER_ID, APPLIANCE_TYPE_CODE)