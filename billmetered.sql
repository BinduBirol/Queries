/* Formatted on 6/26/2018 4:41:15 PM (QP5 v5.227.12220.39754) */
  SELECT brm.READING_ID,
         mr.READING_PURPOSE,
         mr.PREV_READING,
         mr.CURR_READING,
         mr.DIFFERENCE,
         mr.PRESSURE_FACTOR,
         mr.HHV_NHV,
         mr.RATE,
         tmp1.*
    FROM BILLING_READING_MAP brm,
         METER_READING mr,
         (SELECT bill.bill_id,
                 bill_month,
                 bill_year,
                 bill.customer_id,
                 INITCAP (customer_name) CUSTOMER_NAME,
                 proprietor_name,
                 customer_category,
                 customer_category_name,
                 area_id,
                 INITCAP (area_name) area_name,
                 address,
                 PHONE,
                 MOBILE,
                 TO_CHAR (issue_date, 'dd-MM-YYYY') issue_date,
                 TO_CHAR (last_pay_date_wo_sc_view, 'dd-MM-YYYY')
                    last_pay_date_wo_sc_view,
                 TO_CHAR (last_pay_date_w_sc_view, 'dd-MM-YYYY')
                    last_pay_date_w_sc_view,
                 TO_CHAR (last_pay_date_w_sc_view + 1, 'dd-MM-YYYY')
                    last_disconn_reconn_date,
                 minimum_load,
                 other_consumption,
                 mixed_consumption,
                 billed_consumption,
                 payable_amount,
                 amount_in_word,
                 govt.VAT_AMOUNT govt_total,
                 gas_bill,
                 min_load_bill,
                 bill.meter_rent,
                 hhv_nhv_bill,
                 adjustment_amount,
                 ADJUSTMENT_COMMENTS,
                 SURCHARGE_PERCENTAGE,
                 bill.SURCHARGE_AMOUNT,
                 pb.OTHERS_AMOUNT pb_others,
                 pb.OTHERS_COMMENTS pb_others_comments,
                 PB.Gas_Bill + govt.SD_AMOUNT INDIVIDUAL_GAS_BILL,
                 vat_rebate_percent,
                 vat_rebate_amount,
                 pb.total_amount pb_total,
                 bill.status,
                 TO_CHAR (bill.SURCHARGE_ISSUE_DATE, 'dd-MM-YYYY')
                    SURCHARGE_ISSUE_DATE,
                 tm.pmin_load
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
                 AND bill.bill_id = '201805030200201') tmp1
   WHERE BRM.BILL_ID = +tmp1.BILL_ID AND BRM.READING_ID = +MR.READING_ID
ORDER BY tmp1.CUSTOMER_CATEGORY, tmp1.CUSTOMER_ID