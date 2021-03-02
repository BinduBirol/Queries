/* Formatted on 9/16/2019 12:36:35 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM (                                                           --- cash bg
        SELECT SUM (CASH), SUM (BG), 'Cb3D' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                               AND status = 1
                               AND DUE_MONTH_COUNT < 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                               AND status = 1
                               AND DUE_MONTH_COUNT < 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0)
        UNION
        SELECT SUM (CASH), SUM (BG), 'Ca3D' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                               AND status = 1
                               AND DUE_MONTH_COUNT >= 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                               AND status = 1
                               AND DUE_MONTH_COUNT >= 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0)
        UNION
        SELECT SUM (CASH), SUM (BG), 'Cb3G' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                               AND status = 1
                               AND DUE_MONTH_COUNT < 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                               AND status = 1
                               AND DUE_MONTH_COUNT < 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0)
        UNION
        SELECT SUM (CASH), SUM (BG), 'Ca3G' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                               AND status = 1
                               AND DUE_MONTH_COUNT >= 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT CUSTOMER_ID
                          FROM BALANCING_REPORT_HELPER
                         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                               AND status = 1
                               AND DUE_MONTH_COUNT >= 3) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0)) cb,
       (                                                            --advanced
        SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Cb3D' flag
          FROM bill_coll_advanced
         WHERE     customer_id IN
                      (SELECT CUSTOMER_ID
                         FROM BALANCING_REPORT_HELPER
                        WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                              AND status = 1
                              AND DUE_MONTH_COUNT < 3)
               AND status = 1
        UNION
        SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Ca3D' flag
          FROM bill_coll_advanced
         WHERE     customer_id IN
                      (SELECT CUSTOMER_ID
                         FROM BALANCING_REPORT_HELPER
                        WHERE     SUBSTR (customer_id, 1, 4) = '0101'
                              AND status = 1
                              AND DUE_MONTH_COUNT >= 3)
               AND status = 1
        UNION
        SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Cb3G' flag
          FROM bill_coll_advanced
         WHERE     customer_id IN
                      (SELECT AA.CUSTOMER_ID customer_id
                         FROM (SELECT CUSTOMER_ID
                                 FROM BALANCING_REPORT_HELPER
                                WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                                      AND status = 1
                                      AND DUE_MONTH_COUNT < 3) aa,
                              customer_connection cc
                        WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                              AND CC.STATUS = 1)
               AND status = 1
        UNION
        SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Ca3G' flag
          FROM bill_coll_advanced
         WHERE     customer_id IN
                      (SELECT CUSTOMER_ID
                         FROM BALANCING_REPORT_HELPER
                        WHERE     SUBSTR (customer_id, 1, 4) = '0109'
                              AND status = 1
                              AND DUE_MONTH_COUNT >= 3)
               AND status = 1) adv,
       --burner
       (SELECT SUM (single), SUM (double), 'Ca3D' flag
          FROM (SELECT SUM (NEW_APPLIANCE_QNT) single, 0 double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0101'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT >= 3
                                    AND APPLIANCE_TYPE_CODE = 01
                           GROUP BY BRH.CUSTOMER_ID)
                UNION
                SELECT 0 single, SUM (NEW_APPLIANCE_QNT) double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0101'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT >= 3
                                    AND APPLIANCE_TYPE_CODE = 02
                           GROUP BY BRH.CUSTOMER_ID))
        UNION
        SELECT SUM (single), SUM (double), 'Cb3D' flag
          FROM (SELECT SUM (NEW_APPLIANCE_QNT) single, 0 double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0101'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT < 3
                                    AND APPLIANCE_TYPE_CODE = 01
                           GROUP BY BRH.CUSTOMER_ID)
                UNION
                SELECT 0 single, SUM (NEW_APPLIANCE_QNT) double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0101'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT < 3
                                    AND APPLIANCE_TYPE_CODE = 02
                           GROUP BY BRH.CUSTOMER_ID))
        UNION
        SELECT SUM (single), SUM (double), 'Ca3G' flag
          FROM (SELECT SUM (NEW_APPLIANCE_QNT) single, 0 double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0109'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT >= 3
                                    AND APPLIANCE_TYPE_CODE = 01
                           GROUP BY BRH.CUSTOMER_ID)
                UNION
                SELECT 0 single, SUM (NEW_APPLIANCE_QNT) double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0109'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT >= 3
                                    AND APPLIANCE_TYPE_CODE = 02
                           GROUP BY BRH.CUSTOMER_ID))
        UNION
        SELECT SUM (single), SUM (double), 'Cb3G' flag
          FROM (SELECT SUM (NEW_APPLIANCE_QNT) single, 0 double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0109'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT < 3
                                    AND APPLIANCE_TYPE_CODE = 01
                           GROUP BY BRH.CUSTOMER_ID)
                UNION
                SELECT 0 single, SUM (NEW_APPLIANCE_QNT) double
                  FROM BURNER_QNT_CHANGE
                 WHERE pid IN
                          (  SELECT MAX (pid)
                               FROM BURNER_QNT_CHANGE bqc,
                                    BALANCING_REPORT_HELPER brh
                              WHERE     BQC.CUSTOMER_ID = BRH.CUSTOMER_ID
                                    AND SUBSTR (BRH.CUSTOMER_ID, 1, 4) = '0109'
                                    AND brh.status = 1
                                    AND DUE_MONTH_COUNT < 3
                                    AND APPLIANCE_TYPE_CODE = 02
                           GROUP BY BRH.CUSTOMER_ID))) brnr,
       (SELECT COUNT (*) COUNT, 'Cb3D' flag
          FROM BALANCING_REPORT_HELPER
         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
               AND status = 1
               AND DUE_MONTH_COUNT < 3
        UNION
        SELECT COUNT (*) COUNT, 'Ca3D' flag
          FROM BALANCING_REPORT_HELPER
         WHERE     SUBSTR (customer_id, 1, 4) = '0101'
               AND status = 1
               AND DUE_MONTH_COUNT >= 3
        UNION
        SELECT COUNT (*) COUNT, 'Cb3G' flag
          FROM BALANCING_REPORT_HELPER
         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
               AND status = 1
               AND DUE_MONTH_COUNT < 3
        UNION
        SELECT COUNT (*) COUNT, 'Ca3G' flag
          FROM BALANCING_REPORT_HELPER
         WHERE     SUBSTR (customer_id, 1, 4) = '0109'
               AND status = 1
               AND DUE_MONTH_COUNT >= 3) cnt
 WHERE adv.flag = cb.flag AND brnr.flag = adv.flag AND cnt.flag = adv.flag