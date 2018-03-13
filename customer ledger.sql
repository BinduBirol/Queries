/* Formatted on 3/13/2018 12:01:41 PM (QP5 v5.227.12220.39754) */
  SELECT *
    FROM (SELECT bnm.BILL_ID,
                 bnm.CUSTOMER_ID,
                 getBankBranch (BRANCH_ID) BANK_NAME,
                 TO_CHAR (bnm.COLLECTION_DATE) COLLECTION_DATE,
                 MON || ', ' || BILL_YEAR DESCRIPTION,
                 TOTAL_CONSUMPTION BILLED_CONSUMPTION,
                 BILLED_AMOUNT,
                 NULL METER_RENT,
                 NULL CMS_RENT,
                 ACTUAL_SURCHARGE SURCHARGE_AMOUNT,
                 ACTUAL_PAYABLE_AMOUNT PAYABLE_AMOUNT,
                 COLLECTED_SURCHARGE,
                 COLLECTED_PAYABLE_AMOUNT COLLECTED_AMOUNT,
                 TO_CHAR (DUE_DATE, 'dd-mm-rrrr') DUE_DATE
            FROM bill_non_metered bnm, MST_MONTH mm
           WHERE BNM.BILL_MONTH = MM.M_ID AND bnm.CUSTOMER_ID = '010117602'
          UNION ALL
          SELECT NULL BILL_ID,
                 CUSTOMER_ID,
                 getBankBranch (BRANCH_ID) BANK_NAME,
                 TO_CHAR (TRANS_DATE) COLLECTION_DATE,
                 'Advanced' DESCRIPTION,
                 NULL BILLED_CONSUMPTION,
                 NULL BILLED_AMOUNT,
                 NULL METER_RENT,
                 NULL CMS_RENT,
                 NULL SURCHARGE_AMOUNT,
                 NULL PAYABLE_AMOUNT,
                 NULL COLLECTED_SURCHARGE,
                 ADVANCED_AMOUNT COLLECTED_AMOUNT,
                 NULL DUE_DATE
            FROM bill_coll_advanced
           WHERE status = 1 AND CUSTOMER_ID = '010117602')
ORDER BY BILL_ID