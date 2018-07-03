/* Formatted on 7/1/2018 4:29:35 PM (QP5 v5.227.12220.39754) */
UPDATE customer_connection
   SET status = 2
 WHERE     SUBSTR (customer_id, 1, 2) = '18'
       AND ismetered = 0
       AND customer_id not IN
              (SELECT customer_id
                 FROM bill_non_metered
                WHERE     bill_month = 5
                      AND bill_year = 2018
                      AND SUBSTR (customer_id, 1, 2) = '18'
                      --AND status = 2
                      )