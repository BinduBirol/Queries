/* Formatted on 6/21/2018 12:56:13 PM (QP5 v5.227.12220.39754) */
UPDATE customer_connection
   SET status = 2
 WHERE customer_id IN
          ('010200594',
           '010200623',
           '010200625',
           '010200627',
           '010200628',
           '010200629',
           '010200630',
           '010200631')