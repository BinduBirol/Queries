/* Formatted on 4/17/2018 5:20:29 PM (QP5 v5.227.12220.39754) */
UPDATE customer_connection
   SET status = 0
 WHERE     CUSTOMER_ID IN
              (SELECT customer_id
                 FROM customer_connection
                WHERE     CUSTOMER_ID NOT IN
                             (SELECT DISTINCT CUSTOMER_ID
                                FROM burner_qnt_change)
                      AND status = 1
                      AND ismetered = 0)
       AND status = 1