/* Formatted on 4/26/2018 5:04:24 PM (QP5 v5.227.12220.39754) */
SELECT customer_id
  FROM customer_connection
 WHERE     status = 2
       AND SUBSTR (customer_id, 1, 2) = '01'
       --AND SUBSTR (customer_id, 3, 4) = '01'