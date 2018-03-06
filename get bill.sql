/* Formatted on 3/5/2018 5:39:55 PM (QP5 v5.227.12220.39754) */
  SELECT *
    FROM (SELECT bm.BILL_ID,
                 bm.CUSTOMER_ID,
                 bcm.BANK_ID,
                 getBankBranch (BRANCH_ID) BANK_NAME,
                 TO_CHAR (bm.COLLECTION_DATE) COLLECTION_DATE,
                 MON || ', ' || BILL_YEAR DESCRIPTION,
                 BILLED_CONSUMPTION,
                 BILLED_AMOUNT,
                 bm.METER_RENT,
                 CMS_RENT,
                 SURCHARGE_AMOUNT,
                 bm.PAYABLE_AMOUNT,
                 COLLECTED_SURCHARGE,
                 (COLLECTION_AMOUNT + NVL (TAX_AMOUNT, 0)) COLLECTED_AMOUNT,
                 TO_CHAR (LAST_PAY_DATE_WO_SC, 'dd-mm-rrrr') DUE_DATE
            FROM bill_metered bm, bill_collection_metered bcm, MST_MONTH mm
           WHERE     bm.BILL_ID = bcm.BILL_ID(+)
                 AND BM.BILL_MONTH = MM.M_ID
                 AND bm.CUSTOMER_ID = '010200163')
ORDER BY BILL_ID