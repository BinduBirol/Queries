/* Formatted on 6/28/2018 1:01:25 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM customer_connection
 WHERE     customer_id  IN
              (SELECT customer_id
                 FROM bill_metered
                WHERE BILL_MONTH = 4 AND bill_year = 2018 AND area_id = '01')
       AND SUBSTR (customer_id, 1, 2) ='01'
       and ismetered=1
       and status= 1
       --and status=0