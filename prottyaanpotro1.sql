/* Formatted on 3/12/2018 11:24:44 AM (QP5 v5.227.12220.39754) */
  SELECT CUSTOMER_ID,
         FULL_NAME,
         FATHER_NAME,
         ADDRESS_LINE1,
         PHONE,
         SDATE,
         TO_DATE (SYSDATE, 'dd-mm-yyyy') prattayandate,
         NEXTDAY,
         PYEAR,
         SUM (OLD_APPLIANCE_QNT_BILLCALL) OLD_APPLIANCE_QNT_BILLCALL,
         SUM (MAX_LOAD) MAX_LOAD
    FROM (SELECT CUSTOMER_ID,
                 FULL_NAME,
                 FATHER_NAME,
                 ADDRESS_LINE1,
                 PHONE,
                 SDATE,
                 NEXTDAY,
                 PYEAR,
                 OLD_APPLIANCE_QNT_BILLCALL,
                 MAX_LOAD
            FROM (SELECT cp.CUSTOMER_ID,
                         cp.FULL_NAME,
                         cp.FATHER_NAME,
                         cp.ADDRESS_LINE1,
                         cp.MOBILE PHONE,
                         TO_CHAR (SYSDATE) SDATE,
                         TO_CHAR (SYSDATE + 20) NEXTDAY,
                         EXTRACT (YEAR FROM SYSDATE) - 1 PYEAR,
                         OLD_APPLIANCE_QNT_BILLCALL,
                         NVL (MAX_LOAD, 0) MAX_LOAD
                    FROM (SELECT OLD_APPLIANCE_QNT_BILLCALL, Customer_id
                            FROM burner_qnt_change
                           WHERE pid IN (SELECT MAX (PID)
                                           FROM burner_qnt_change
                                          WHERE customer_id = '010114230')) tab1,
                         MVIEW_CUSTOMER_INFO cp
                   WHERE CP.CUSTOMER_ID = TAB1.CUSTOMER_ID)
          UNION ALL
          SELECT CUSTOMER_ID,
                 FULL_NAME,
                 FATHER_NAME,
                 ADDRESS_LINE1,
                 PHONE,
                 SDATE,
                 NEXTDAY,
                 PYEAR,
                 NVL (NEW_DOUBLE_BURNER_QNT_BILLCAL, 0)
                    NEW_DOUBLE_BURNER_QNT_BILLCAL,
                 MAX_LOAD
            FROM (SELECT CUSTOMER_ID,
                         FULL_NAME,
                         FATHER_NAME,
                         ADDRESS_LINE1,
                         MOBILE PHONE,
                         TO_CHAR (SYSDATE) SDATE,
                         TO_CHAR (SYSDATE + 20) NEXTDAY,
                         EXTRACT (YEAR FROM SYSDATE) - 1 PYEAR,
                         NULL NEW_DOUBLE_BURNER_QNT_BILLCAL,
                         MAX_LOAD
                    FROM MVIEW_CUSTOMER_INFO
                   WHERE CUSTOMER_ID = '010114230'))
GROUP BY CUSTOMER_ID,
         FULL_NAME,
         FATHER_NAME,
         ADDRESS_LINE1,
         SDATE,
         NEXTDAY,
         PYEAR,
         PHONE