SELECT bill.bill_id, bill.customer_id,
                 
                 billed_consumption,
                 payable_amount
                 
            FROM bill_metered bill,
                 summary_margin_govt govt,
                 summary_margin_pb pb,
                 (  SELECT customer_id,
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
                 AND bill.status = 0
                 AND area_id = '01'
                 AND customer_category = '02'
                 AND Bill_Month = 5
                 AND Bill_Year = 2018
                 
                 --group by bill.bill_id