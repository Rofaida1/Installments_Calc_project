# Installments_Calc_project
This repository contains a PL/SQL stored procedure named generate_installments designed to automate the generation of installment records for contracts in a database system. The procedure calculates installment dates and amounts based on contract details such as start date, end date, total fees, deposit fees, and payment frequency


1- Procedure Overview:
The generate_installments procedure iterates through each contract stored in the contracts table. For each contract, it calculates the number of installments based on the payment frequency specified in the contract. Then, it generates installment records and inserts them into the installments_paid table.

2- Usage:
To use this procedure, follow these steps:

- Ensure that the necessary tables (contracts and installments_paid) are created in the database.
- Create the stored procedure generate_installments by executing the provided script in your Oracle database environment.
- Call the generate_installments procedure whenever you need to generate installment records for contracts.

3- Dependencies:
This procedure assumes the existence of the following:

- Tables: contracts and installments_paid.
- Sequence: INSTALLMENTS_PAID_SEQ for generating unique installment IDs.
- Valid contract records in the contracts table with appropriate details such as start date, end date, total fees, deposit fees, and payment frequency.
  
4- Input:
The generate_installments procedure does not accept any input parameters. It retrieves contract details from the contracts table.

5- Output:
The procedure generates installment records and inserts them into the installments_paid table.

6- Error Handling:
Any errors encountered during the execution of the procedure will be displayed in the output.

