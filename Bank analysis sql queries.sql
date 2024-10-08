-- create database for bank loan analysis
create database BankLoan

-- use created bank loan
use BankLoan

-- check data is present in table or not
select * from Bank_Loan_Data

-- Find the total no of loan Applications
select count(*)as Total_Loan_Applications from Bank_Loan_Data

-- Find Total no of loan applications for last month of year 2021 or MTD Applications
select count(*)as MTD_Total_loan_Applications from Bank_Loan_Data 
where month(issue_date)=12 and YEAR(issue_date)=2021

-- Month over Month(MOM) Applications formula= (MTD-PMTD) / PMTD
-- Previous Month to Date(PMTD)
select count(*)as PMTD_Applications from Bank_Loan_Data 
where month(issue_date)=11 and year(issue_date)=2021

-- Total Funded Amount
select sum(loan_amount)as Funded_Amount from Bank_Loan_Data

--MTD Funded Amount
select sum(loan_amount)as MTD_Funded_Amout from Bank_Loan_Data
where month(issue_date)=12 and year(issue_date)=2021

--month over month (MoM) Funded Amount
-- formula=  (MTD-PMTD) / PMTD

select sum(loan_amount)as PMTD_Funded_amount from Bank_Loan_Data
where month(issue_date)=11 and year(issue_date)=2021

-- Total Amount received
select sum(total_payment) as Total_Amount_Received from Bank_Loan_Data

-- MTD Amount received
select sum(total_payment) as mtd_amount_received from Bank_Loan_Data
where month(issue_date)=12 and year(issue_date)=2021

-- MoM Amount received
-- formula = (MTD-PMTD) / PMTD
select sum(total_payment) as PMTD_amount_received from Bank_Loan_Data
where month(issue_date)=11 and year(issue_date)=2021

-- Average Interest rate
select round(sum(int_rate)/count(int_rate)*100,2)as avg_interest_rate from Bank_Loan_Data
select round(AVG(int_rate)*100,2)as avg_interest_rate from Bank_Loan_Data

-- MTD AVG Interest rate
select round(avg(int_rate)*100,2)as MTD_avg_interest_rate from Bank_Loan_Data
where month(issue_date)=12 and year(issue_date)=2021

--Mom aVg Interest rate
-- formula = (MTD-PMTD) / PMTD
select round(avg(int_rate)*100,2)as PMTD_avg_interest_rate from Bank_Loan_Data
where month(issue_date)=11 and year(issue_date)=2021

-- Avg Dti rate
select round(avg(dti)*100,2)as avg_dti from Bank_Loan_Data

-- MTd aVg dti rate
select round(avg(dti)*100,2)as MTD_avg_dti from Bank_Loan_Data
where month(issue_date)=12 and year(issue_date)=2021

--Mom avg dti rate
-- formula= (MTD-PMTD) / PMTD
select round(avg(dti)*100,2) as PMTD_avg_dti from Bank_Loan_Data
where month(issue_date)=11 and year(issue_date)=2021

-- Good loan applications percentage
select 
	(count(
	case 
	when loan_status='fully paid' or loan_status='current' 
	then id
	end))*100/count(id) as good_loan_percentage
from Bank_Loan_Data

-- good loan applications
select count(*) as good_loan_applications from Bank_Loan_Data 
where loan_status='current' or loan_status='fully paid'

-- good loan funded amount
select sum(loan_amount)as good_loan_funded_amount from Bank_Loan_Data
where loan_status!='charged off'

-- good loan total received amount
select sum(total_payment)as good_loan_received_amount from Bank_Loan_Data
where loan_status!='charged off'

-- Bad loan application percentage
select
	(count(
	case
		WHEN loan_status='charged off'
		THEN id
		END
	))*100/count(id)as bad_loan_application_rate from Bank_Loan_Data

-- Bad loan applications
select count(id) from Bank_Loan_Data where loan_status='charged off'

-- Bad loan funded amount
select sum(loan_amount) from Bank_Loan_Data where loan_status='charged off'

-- Bad loan received amount
select sum(total_payment) from Bank_Loan_Data where loan_status='charged off'

-- Loan Status
select
	loan_status,
	count(*) as Total_Loan_Applications,
	sum(loan_amount)as Total_funded_amount,
	sum(total_payment)as Total_received_amount,
	round(avg(int_rate)*100,2)as Avg_interest_rate,
	round(avg(dti)*100,2)as avg_dti_rate
from
	Bank_Loan_Data
	group by loan_status

-- Loan Status by MTD 
select
	loan_status,
	sum(loan_amount) as MTD_funded_amount,
	sum(total_payment)as MTD_received_amount
from
	Bank_Loan_Data
	where MONTH(issue_date)=12 and YEAR(issue_date)=2021
	group by loan_status

-- PMTD loan status
select
	loan_status,
	sum(loan_amount) as PMTD_funded_amount,
	sum(total_payment)as PMTD_received_amount
from
	Bank_Loan_Data
	where MONTH(issue_date)=11 and year(issue_date)=2021
	group by loan_status

-- Monthly Trend by issue Date
select 
	MONTH(issue_date) as month_num,
	DateName(month,issue_date) as Mon_Name,
	count(id) as Total_Applications,
	sum(loan_amount)as funded_amount,
	sum(total_payment)as received_amount 
from 
	Bank_Loan_Data
	group by month(issue_date),DateName(month,issue_date) 
	order by MONTH(issue_date)

-- Regional wise analysis
select
	address_state,
	count(id) as No_of_applications,
	sum(loan_amount) as funded_amount,
	sum(total_payment) as received_amount
from
	Bank_Loan_Data
	group by address_state

-- loan term analysis
select
	term,
	count(id) as NO_of_applications,
	sum(loan_amount) as funded_amount,
	sum(total_payment) as received_amount
from
	Bank_Loan_Data
	group by term
	order by term

-- employee length analysis
select
	emp_length,
	count(id) as No_of_applications,
	sum(loan_amount) as funded_amount,
	sum(total_payment) as received_amount
from
	Bank_Loan_Data
	group by emp_length
	order by emp_length

-- loan purpose breakdown analysis
select
	purpose,
	count(id) as No_of_applications,
	sum(loan_amount) as funded_amount,
	sum(total_payment) as received_amount
from
	Bank_Loan_Data
	group by purpose
	order by No_of_applications desc

-- Home Ownership Analysis
select
	home_ownership,
	count(id) as No_of_applications,
	sum(loan_amount) as funded_amount,
	sum(total_payment) as received_amount
from
	Bank_Loan_Data
	group by home_ownership
	order by No_of_applications desc