/* Formatted on 6/26/2018 4:45:53 PM (QP5 v5.227.12220.39754) */
  SELECT customer_id,
         billing_month,
         billing_year,
         SUM (NVL (PMIN_LOAD, 0)) pmin_load
    FROM VIEW_METER_READING
GROUP BY customer_id, billing_month, billing_year) tm
           WHERE     bill.bill_id = govt.bill_id
                 AND bill.bill_id = pb.bill_id
                 AND BILL.CUSTOMER_ID = tm.CUSTOMER_ID
                 AND BILL.BILL_MONTH = tm.billing_month
                 AND BILL.BILL_YEAR = tm.billing_year
                 AND bill.bill_id = '201805030200201'