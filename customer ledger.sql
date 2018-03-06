/* Formatted on 2/18/2018 6:19:04 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM (SELECT TMP1.*
          FROM (SELECT NVL (BCNM.ROWID, 'DRINi8AEAAABkheAA7') AR,
                       bnm.BILL_ID,
                       bnm.CUSTOMER_ID,
                       bcnm.BANK_ID,
                       (SELECT BANK_NAME
                          FROM MST_BANK_INFO
                         WHERE BANK_ID = bcnm.BANK_ID)
                          BANK_NAME,
                       TO_CHAR (bnm.COLLECTION_DATE) COLLECTION_DATE,
                       MON || ', ' || BILL_YEAR DESCRIPTION,
                       TOTAL_CONSUMPTION BILLED_CONSUMPTION,
                       BILLED_AMOUNT,
                       NULL METER_RENT,
                       NULL CMS_RENT,
                       ACTUAL_SURCHARGE SURCHARGE_AMOUNT,
                       ACTUAL_PAYABLE_AMOUNT PAYABLE_AMOUNT,
                       COLLECTED_SURCHARGE_AMOUNT COLLECTED_SURCHARGE,
                       COLLECTED_BILL_AMOUNT COLLECTED_AMOUNT,
                       TO_CHAR (DUE_DATE, 'dd-mm-rrrr') DUE_DATE
                  FROM bill_non_metered bnm,
                       BILL_COLLECTION_NON_METERED bcnm,
                       MST_MONTH mm
                 WHERE     bnm.BILL_ID = bcnm.BILL_ID(+)
                       AND BNM.BILL_MONTH = MM.M_ID
                       AND bnm.CUSTOMER_ID = '010120610') TMP1,
               (SELECT COUNT (*) AS NUM
                  FROM (SELECT A.CUSTOMER_ID,
                               A.ROWID BR,
                               A.BILL_ID,
                               A.COLLECTED_BILL_AMOUNT COLLECTED_AMOUNT
                          FROM BILL_COLLECTION_NON_METERED A,
                               (SELECT BILL_ID,
                                       COLLECTED_BILL_AMOUNT COLLECTED_AMOUNT
                                  FROM BILL_COLLECTION_NON_METERED) B
                         WHERE     A.BILL_ID = B.BILL_ID
                               AND A.COLLECTED_BILL_AMOUNT <
                                      B.COLLECTED_AMOUNT
                               AND A.CUSTOMER_ID = '010120610')) TMP3,
               if TMP3.NUM= ''
                               begin
                               (SELECT A.CUSTOMER_ID,
                       A.ROWID BR,
                       A.BILL_ID,
                       A.COLLECTED_BILL_AMOUNT COLLECTED_AMOUNT
                  FROM BILL_COLLECTION_NON_METERED A,
                       (SELECT BILL_ID,
                               COLLECTED_BILL_AMOUNT COLLECTED_AMOUNT
                          FROM BILL_COLLECTION_NON_METERED) B
                 WHERE     A.BILL_ID = B.BILL_ID
                       AND A.COLLECTED_BILL_AMOUNT < B.COLLECTED_AMOUNT
                       AND A.CUSTOMER_ID = '010120610') TMP2




           WHERE TMP1.AR != TMP2.BR
          end

          UNION ALL
          SELECT NULL AR,
                 BILL_ID,
                 CUSTOMER_ID,
                 BANK_ID,
                 NULL BANK_NAME,
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
           WHERE status = 1 AND CUSTOMER_ID = '010120610')
ORDER BY BILL_ID