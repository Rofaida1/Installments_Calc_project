CREATE OR REPLACE PROCEDURE generate_installments AS
   v_contract_id contracts.contract_id%TYPE;
   v_installment_id installments_paid.installment_id%TYPE;
   v_inst_date date;
   v_inst_amount number;  v_paid number := 0; v_NDate_factor number;
   v_years number;   inst_count number;
  
   CURSOR contract_curs IS
      SELECT *
      FROM contracts;

BEGIN
   for rec in contract_curs
   loop
      v_contract_id := rec.contract_id;
      v_years:=TRUNC(MONTHS_BETWEEN(rec.contract_enddate, rec.contract_startdate) / 12);

      BEGIN
         if rec.contract_payment_type = 'ANNUAL' THEN
            v_NDate_factor := 1;
        elsif rec.contract_payment_type = 'QUARTER' THEN
            v_NDate_factor := 4;
         ELSIF rec.contract_payment_type = 'MONTHLY' THEN
            v_NDate_factor := 12;
         ELSIF rec.contract_payment_type = 'HALF_ANNUAL' THEN
            v_NDate_factor := 2;

         END IF;
      END;

      -- Loop to insert rows for each quarter using a WHILE loop
      DECLARE
         i NUMBER := 1;
      
      BEGIN
      inst_count:= v_years * v_NDate_factor;
         WHILE i <= inst_count
         LOOP
            -- Calculate dates and amount of installments
            v_inst_date := ADD_MONTHS(rec.contract_startdate, (i - 1) * (12 / v_NDate_factor));
            v_inst_amount := ROUND((rec.contract_total_fees - rec.contract_deposit_fees) /inst_count, 2);

            SELECT INSTALLMENTS_PAID_SEQ.nextval INTO v_installment_id FROM dual;

            INSERT INTO INSTALLMENTS_PAID (
               INSTALLMENT_ID,
               CONTRACT_ID,
               INSTALLMENT_DATE,
               INSTALLMENT_AMOUNT,
               PAID
            ) VALUES (
               v_installment_id,
               v_contract_id,
               v_inst_date,
               v_inst_amount,
               v_paid
            );

            -- Increment the loop counter
            i := i + 1;


         END LOOP;
      END;
   END LOOP;
   
END generate_installments;
/
show errors;