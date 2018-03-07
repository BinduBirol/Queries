/* Formatted on 3/6/2018 5:43:03 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM (SELECT ROWNUM serial, tmp1.*
          FROM (  SELECT BQC.PID,
                         BQC.CUSTOMER_ID,
                         CPI.FULL_NAME,
                         BQC.APPLIANCE_TYPE_CODE,
                         AI.APPLIANCE_NAME,
                         BQC.OLD_APPLIANCE_QNT,
                         BQC.NEW_APPLIANCE_QNT,
                         BQC.NEW_PERMANENT_DISCON_QNT,
                         BQC.NEW_TEMPORARY_DISCONN_QNT,
                         BQC.NEW_INCREASED_QNT,
                           BQC.NEW_RECONN_QNT_4M_TEMPORARY
                         + BQC.NEW_RECONN_QNT_4M_TEMP_HALF
                            NEW_RECONN_QNT_4M_TEMPORARY,
                         BQC.NEW_RECONN_QNT_4M_PERMANENT,
                         BQC.DISCONN_CAUSE,
                         BQC.TOTAL_TDISCONNECTED_QNT,
                         BQC.TOTAL_PDISCONNECTED_QNT,
                         TRUNC (EFFECTIVE_DATE) EFFECTIVE_DATE,
                         TO_CHAR (EFFECTIVE_DATE, 'dd-MM-YYYY')
                            EFFECTIVE_DATE_VIEW,
                         REMARKS,
                         MST_AREA.AREA_ID,
                         MST_AREA.AREA_NAME
                    FROM BURNER_QNT_CHANGE BQC,
                         CUSTOMER_PERSONAL_INFO CPI,
                         MST_AREA,
                         CUSTOMER,
                         APPLIANCE_INFO AI
                   WHERE     BQC.CUSTOMER_ID = CPI.CUSTOMER_ID
                         AND CUSTOMER.CUSTOMER_ID = CPI.CUSTOMER_ID
                         AND BQC.APPLIANCE_TYPE_CODE = AI.APPLIANCE_ID
                         AND AI.AREA_ID = MST_AREA.Area_Id
                         AND CUSTOMER.AREA = MST_AREA.AREA_ID
                         --AND (MST_AREA.Area_Id = '01')
                         AND BQC.CUSTOMER_ID='010106429'
                ORDER BY effective_date, pid ASC) tmp1) tmp2
 WHERE serial BETWEEN 1 AND 1000