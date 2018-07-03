/* Formatted on 7/1/2018 4:13:20 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM customer_connection
 WHERE     SUBSTR (customer_id, 1, 2) = '19'
       AND ismetered = 1
       AND customer_id NOT IN
              (SELECT customer_id
                 FROM bill_metered
                WHERE     bill_month = 5
                      AND bill_year = 2018
                      AND SUBSTR (customer_id, 1, 2) = '19')
                      and status= 1