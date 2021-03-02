DROP VIEW JALALABAD.MVIEW_CUSTOMER_INFO;

/* Formatted on 1/27/2020 1:36:51 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW JALALABAD.MVIEW_CUSTOMER_INFO
(
   CUSTOMER_ID,
   APP_SL_NO,
   ISMETERED,
   CONNECTION_TYPE,
   HAS_SUB_CONNECTION,
   PARENT_CONNECTION,
   MIN_LOAD,
   MAX_LOAD,
   HHV_NHV,
   PAY_WITHIN_WO_SC,
   PAY_WITHIN_W_SC,
   CONNECTION_DATE,
   MINISTRY_ID,
   VAT_REBATE,
   CONNECTION_STATUS,
   FULL_NAME,
   FATHER_NAME,
   MOTHER_NAME,
   PROPRIETOR_NAME,
   ORGANIZATION_NAME,
   GENDER,
   EMAIL,
   PHONE,
   MOBILE,
   FAX,
   FREEDOM_FIGHTER,
   WAIVER_APPLIANCE_ID,
   NATIONAL_ID,
   PASSPORT_NO,
   LICENSE_NUMBER,
   TIN_NO,
   VAT_REG_NO,
   CATEGORY_ID,
   CATEGORY_NAME,
   CATEGORY_TYPE,
   ROAD_HOUSE_NO,
   POST_OFFICE,
   POST_CODE,
   ADDRESS_LINE1,
   ADDRESS_LINE2,
   DIVISION_ID,
   DIVISION_NAME,
   DIST_ID,
   DIST_NAME,
   UPAZILA_ID,
   UPAZILA_NAME,
   MINISTRY_NAME,
   AREA_ID,
   AREA_NAME,
   ADDRESS,
   CREATED_ON,
   CREATED_BY,
   STATUS,
   ZONE,
   IS_BULKED,
   sub_customers
)
AS
   SELECT C.CUSTOMER_ID,
          -- NEW_APPLIANCE_QNT,
          C.APP_SL_NO,
          ISMETERED,
          CONNECTION_TYPE,
          HAS_SUB_CONNECTION,
          PARENT_CONNECTION,
          MIN_LOAD,
          MAX_LOAD,
          HHV_NHV,
          PAY_WITHIN_WO_SC,
          PAY_WITHIN_W_SC,
          TO_CHAR (CONNECTION_DATE, 'DD-MM-YYYY') CONNECTION_DATE,
          MINISTRY.MINISTRY_ID,
          VAT_REBATE,
          DECODE (CCONN.STATUS, NULL, 2, CCONN.STATUS) CONNECTION_STATUS,
          FULL_NAME,
          FATHER_NAME,
          MOTHER_NAME,
          PROPRIETOR_NAME,
          NVL (ORGANIZATION_NAME, 'NOT GIVEN') ORGANIZATION_NAME,
          GENDER,
          NVL (EMAIL, 'NOT GIVEN') EMAIL,
          PHONE,
          MOBILE,
          FAX,
          FREEDOM_FIGHTER,
          WAIVER_APPLIANCE_ID,
          NATIONAL_ID,
          PASSPORT_NO,
          LICENSE_NUMBER,
          NVL (CPI.TIN_NO, '0') TIN_NO,
          VAT_REG_NO,
          MCC.CATEGORY_ID,
          MCC.CATEGORY_NAME,
          MCC.CATEGORY_TYPE CATEGORY_TYPE,
          ROAD_HOUSE_NO,
          POST_OFFICE,
          POST_CODE,
          ADDRESS_LINE1,
          ADDRESS_LINE2,
          DIVISION.DIVISION_ID,
          DIVISION.DIVISION_NAME,
          DISTRICT.DIST_ID,
          DISTRICT.DIST_NAME,
          UPAZILA.UPAZILA_ID,
          UPAZILA.UPAZILA_NAME,
          MINISTRY.MINISTRY_NAME,
          AREA_ID,
          AREA_NAME,
          INITCAP (
             DECODE (Address_Line2,
                     NULL, Address_Line1,
                     '', Address_Line1,
                     Address_Line2) /*
              || DECODE (Address_Line2,
                         NULL, '',
                         '', '',
                         CHR (10) || Address_Line2)
              || DECODE (Upazila_Name,
                         NULL, '',
                         '', '',
                         CHR (10) || 'Upazila :' || Upazila_Name)
              || DECODE (Post_office,
                         NULL, '',
                         '', '',
                         ', Post Office : ' || Post_office)
              || DECODE (Post_Code,
                         NULL, '',
                         '', '',
                         ', Post Code : ' || Post_Code)
              || DECODE (Division_Name,
                         NULL, '',
                         '', '',
                         CHR (10) || 'Division : ' || Division_Name)
              || DECODE (Dist_Name,
                         NULL, '',
                         '', '',
                         ', District : ' || Dist_Name))*/
                                   )
             Address,
          CREATED_ON,
          CREATED_BY,
          CCONN.STATUS,
          C.ZONE,
          cconn.IS_BULKED,
          sub_customers
     FROM Customer C,
          Customer_Connection CCONN,
          Customer_Personal_Info CPI,
          Mst_Customer_Category MCC,
          Customer_Address CA,
          Division,
          District,
          Upazila,
          Mst_Ministry MINISTRY,
          Mst_Area MA,
          (SELECT PARENT_CONNECTION as p_conn,
         
            LISTAGG (CUSTOMER_ID, ',') WITHIN GROUP (ORDER BY CUSTOMER_ID) as sub_customers
                FROM customer_connection
               WHERE PARENT_CONNECTION IN (SELECT customer_id
                                             FROM customer_connection
                                            WHERE HAS_SUB_CONNECTION = 'Y')
            GROUP BY PARENT_CONNECTION) t_sub
    -- BURNER_QNT_CHANGE
    WHERE     C.CUSTOMER_ID = CCONN.CUSTOMER_ID(+)
          and C.CUSTOMER_ID = t_sub.p_conn(+)
          AND C.CUSTOMER_ID = CPI.CUSTOMER_ID(+)
          AND C.CUSTOMER_CATEGORY = MCC.CATEGORY_ID(+)
          AND C.CUSTOMER_ID = CA.CUSTOMER_ID(+)
          AND CA.DIVISION = DIVISION.DIVISION_ID(+)
          AND CA.DISTRICT = DISTRICT.DIST_ID(+)
          AND CA.UPAZILA = UPAZILA.UPAZILA_ID(+)
          AND CCONN.MINISTRY_ID = MINISTRY.MINISTRY_ID(+)
          AND C.AREA = MA.AREA_ID(+);
