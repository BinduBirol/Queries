/* Formatted on 4/17/2018 5:15:26 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM customer_connection
 WHERE     CUSTOMER_ID not IN
              (SELECT DISTINCT CUSTOMER_ID FROM burner_qnt_change)
       AND status = 1
       AND ismetered = 0
       AND SUBSTR (customer_id, 1, 2) = '01'