SELECT customer_id
                 FROM bill_metered
                WHERE     bill_month = 6
                      AND bill_year = 2018
                      AND SUBSTR (customer_id, 1, 4) = '1910'