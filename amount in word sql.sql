/* Formatted on 6/26/2018 12:52:52 PM (QP5 v5.227.12220.39754) */
UPDATE bill_metered
   SET AMOUNT_IN_WORD = number_spellout_func (PAYABLE_AMOUNT)
 WHERE bill_id = '201805040600002'