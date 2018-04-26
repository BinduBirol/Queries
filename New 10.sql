/* Formatted on 4/26/2018 4:58:16 PM (QP5 v5.227.12220.39754) */
UPDATE customer_connection
   SET status = 2
 WHERE     CUSTOMER_ID IN
              (SELECT customer_id
    FROM customer_connection
   WHERE     customer_id NOT IN
                (SELECT DISTINCT customer_id FROM bill_non_metered)
         AND status = 0
         AND SUBSTR (customer_id, 1, 2) = '01')
       AND status = 0