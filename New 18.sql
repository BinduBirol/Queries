/* Formatted on 4/26/2018 4:57:16 PM (QP5 v5.227.12220.39754) */
  SELECT customer_id
    FROM customer_connection
   WHERE     customer_id NOT IN
                (SELECT DISTINCT customer_id FROM bill_non_metered)
         AND status = 2
         AND SUBSTR (customer_id, 1, 2) = '01'
ORDER BY customer_id ASC