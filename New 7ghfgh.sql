/* Formatted on 4/25/2018 11:01:29 AM (QP5 v5.227.12220.39754) */
  SELECT tmp1.customer_id,
         meter_id,
         meter_sl_no,
         meter_mfg,
         mfg_name,
         meter_year,
         measurement_type,
         tmp1.unit,
         evc_sl_no,
         evc_model,
         evc_year,
         meter_type,
         type_name meter_type_name,
         g_rating,
         rating_name g_rating_name,
         conn_size,
         max_reading,
         ini_reading,
         pressure,
         temperature,
         tmp1.meter_rent,
         vat_rebate,
         TO_CHAR (installed_date, 'DD-MM-YYYY') installed_date,
         installed_by,
         tmp1.status,
         remarks
    FROM (SELECT *
            FROM customer_meter
           WHERE customer_meter.customer_id = '010200163') tmp1
         LEFT OUTER JOIN MST_METER_MFG ON tmp1.meter_mfg = MST_METER_MFG.MFG_ID
         LEFT OUTER JOIN MST_EVC_MODEL
            ON tmp1.evc_model = MST_EVC_MODEL.MODEL_ID
         LEFT OUTER JOIN MST_METER_TYPE
            ON tmp1.meter_type = MST_METER_TYPE.TYPE_ID
         LEFT OUTER JOIN MST_METER_GRATING
            ON tmp1.g_rating = MST_METER_GRATING.RATING_ID
ORDER BY installed_date DESC