SELECT * FROM bank_loan_data;
-- Key Performance Indicators (KPIs) :

--Total Loan Applications
SELECT count(id) FROM bank_loan_data;

SELECT count(id) AS MTD_Loan_Applications FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 AND year(issue_date) = 2021;

SELECT count(id) AS PMTD_Loan_Applications FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND year(issue_date) = 2021;
--MOM=(MTD-PMTD)/PMTD
---------------------------------------------------------------------------------------------------------------------------------------------------


-- Total Funded Amount
SELECT sum(loan_amount) AS total_funded_amount FROM bank_loan_data;

SELECT sum(loan_amount) AS MTD_total_funded_amount FROM bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021;

SELECT sum(loan_amount) AS PMTD_total_funded_amount FROM bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021;
--MOM=(MTD-PMTD)/PMTD
---------------------------------------------------------------------------------------------------------------------------------------------------


-- Total Amount Received
SELECT sum(total_payment) AS total_amount_received FROM bank_loan_data;

SELECT sum(total_payment) AS MTD_total_amount_received FROM bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021;

SELECT sum(total_payment) AS PMTD_total_amount_received FROM bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021;
--MOM=(MTD-PMTD)/PMTD
---------------------------------------------------------------------------------------------------------------------------------------------------


-- Average Iterest Rate
SELECT * FROM bank_loan_data;

SELECT ROUND(avg(int_rate),4)* 100 AS Avg_interest_rate FROM bank_loan_data;

SELECT ROUND(avg(int_rate),4)* 100 AS MTD_Avg_interest_rate FROM bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021;

SELECT ROUND(avg(int_rate),4)* 100 AS PMTD_Avg_interest_rate FROM bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021;
--MOM=(MTD-PMTD)/PMTD
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Average Debt-to-Income Ratio (DTI): 
SELECT * FROM bank_loan_data;

SELECT ROUND(avg(dti), 4)*100 AS avg_dti FROM bank_loan_data;

SELECT ROUND(avg(dti), 4)*100 AS MTD_avg_dti FROM bank_loan_data
WHERE month(issue_date) = 12 AND year(issue_date) = 2021;

SELECT ROUND(avg(dti), 4)*100 AS PMTD_avg_dti FROM bank_loan_data
WHERE month(issue_date) = 11 AND year(issue_date) = 2021;

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Good Loan v/s Bad Loan KPI’s

-- Good Loan
SELECT * FROM bank_loan_data;

-- Good Loan Application Percentage
SELECT 
	(count(CASE WHEN loan_status = 'Fully paid' OR Loan_status = 'Current' 
	 THEN id END)*100.0)
	 /
	 COUNT(id) AS good_loan_percentage
FROM bank_loan_data;

-- Good Loan Applications
SELECT 
	count(CASE WHEN loan_status = 'Fully paid' OR Loan_status = 'Current' 
	 THEN id END) AS good_loan_applications
FROM bank_loan_data;
-- OR 
SELECT count(id) AS good_loan_applications FROM bank_loan_data
	WHERE loan_status = 'Fully paid' OR Loan_status = 'Current';

-- Good Loan Funded Amount
SELECT sum(loan_amount) AS good_loan_funded_amount FROM bank_loan_data
	WHERE loan_status = 'Fully paid' OR Loan_status = 'Current';

-- Good Loan Total Received Amount
SELECT sum(total_payment) AS good_loan_received_amount FROM bank_loan_data
	WHERE loan_status = 'Fully paid' OR Loan_status = 'Current';
---------------------------------------------------------------------------------------------------------------------------------------------------


-- Bad Loan
SELECT * FROM bank_loan_data;

--Bad Loan Application Percentage
SELECT 
	(count(CASE WHEN loan_status = 'Charged Off' 
	 THEN id END)*100.0)
	 /
	 COUNT(id) AS bad_loan_percentage
FROM bank_loan_data;

-- Bad Loan Applications
SELECT count(id) AS bad_loan_applications FROM bank_loan_data
WHERE loan_status = 'Charged off';

-- Bad Loan Funded Amount
SELECT sum(loan_amount) AS bad_loan_funded_amount FROM bank_loan_data
	WHERE loan_status = 'charged off';

-- Bad Loan Total Received Amount
SELECT sum(total_payment) AS bad_loan_received_amount FROM bank_loan_data
	WHERE loan_status = 'charged off';

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Loan Status Grid View
SELECT 
	loan_status,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received,
	round(avg(int_rate*100),2) AS average_interest_rate,
	round(avg(dti*100),2) AS average_dti
FROM bank_loan_data
GROUP BY loan_status;

-- Loan Status MTD
SELECT loan_status,
	sum(loan_amount) AS MTD_Funded_amount,
	sum(total_payment) AS MTD_amount_recieved
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

------------------------------------------------------------------------------------------------------------------------------------------------

-- CHARTS

-- 1. Monthly Trends by Issue Date
SELECT 
	MONTH(issue_date) AS Month_number,
	DATENAME(MONTH,issue_date) AS month_name,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY MONTH(issue_date) , DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date);

-- 2. Regional Analysis by State 
SELECT 
	address_state,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- 3. Loan Term Analysis 
SELECT 
	term,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- 4. Employee Length Analysis 
SELECT 
	emp_length,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- 5. Loan Purpose Breakdown 
SELECT 
	purpose,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- 6. Home Ownership Analysis 
SELECT 
	home_ownership,
	count(id) AS total_loan_applications,
	sum(loan_amount) AS total_funded_amount,
	sum(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;