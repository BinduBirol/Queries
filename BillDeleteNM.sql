/* Formatted on 7/29/2018 3:51:09 PM (QP5 v5.227.12220.39754) */
SELECT BILL_ID
  FROM bill_non_metered
 WHERE     BILL_MONTH = 6
       AND BILL_YEAR = 2018
       AND customer_id IN (SELECT CUSTOMER_ID
                             FROM bill_non_metered
                            WHERE BILL_ID LIKE '201806%' AND area_id = '16'
                           MINUS
                           SELECT CUSTOMER_ID
                             FROM bill_non_metered
                            WHERE BILL_ID LIKE '201805%' AND area_id = '16');



SELECT bill_id
  FROM bill_non_metered
 WHERE     bill_month = 6
       AND bill_year = 2018
       AND customer_id IN
              ('180100075',
               '180100088',
               '180100113',
               '180100115',
               '180100120',
               '180100122',
               '180100124',
               '180100153')