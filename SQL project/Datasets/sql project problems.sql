use company;

select * from employee;
select * from jobdepartment;
select * from salarybonus;
-- Analysis Questions
--  EMPLOYEE INSIGHTS
-- 1.How many unique employees are currently in the system?
SELECT DISTINCT
    (COUNT(emp_id)) AS totalemployees
FROM
    employee;

-- 2. Which departments have the highest number of employees?
SELECT 
     jobdept,COUNT(e.emp_id) AS employee_count
FROM
    employee e
        JOIN
    jobdepartment d ON e.job_id = d.job_id
GROUP BY d.jobdept
ORDER BY employee_count DESC limit 2;


-- 3. What is the average salary per department?
SELECT 
    d.jobdept,round(AVG(s.amount),2) AS avg_salary
FROM
    salarybonus s
        JOIN
    jobdepartment d ON s.job_id = d.job_id
GROUP BY (d.jobdept);
-- .Who are the top 5 highest-paid employees? 
SELECT 
	emp_id, firstname,lastname,amount
FROM
    employee e
        JOIN
    salarybonus s ON e.job_id = s.job_id
ORDER BY (amount) DESC
LIMIT 5;

-- 5.What is the total salary expenditure across the company?
SELECT 
    SUM(annual + bonus) AS totalsalaryexpenditure
FROM
    salarybonus;


-- 2. JOB ROLE AND DEPARTMENT ANALYSIS 
--  1.How many different job roles exist in each department? 
SELECT 
    d.jobdept departments, COUNT(DISTINCT (d.name)) jobroles
FROM
    jobdepartment d
GROUP BY (d.jobdept);


--  2.What is the average salary range per department? 
SELECT 
    d.jobdept,
    MIN(amount) min_salary,
    MAX(amount) max_salary,
    ROUND(AVG(amount), 2) avg_salary
FROM
    jobdepartment d
        JOIN
    salarybonus s ON d.job_Id = s.Job_Id
GROUP BY (jobdept);


--  3.Which job roles offer the highest salary? 
SELECT 
    d.name jobrole, max(s.amount) highestsalary
FROM
    jobdepartment d
        JOIN
    salarybonus s ON d.Job_ID = s.Job_ID
GROUP BY (d.name)
ORDER BY highestsalary DESC
LIMIT 1;


--  4.Which departments have the highest total salary allocation? 
SELECT 
    d.jobdept department, SUM(s.amount + s.bonus) totalsalary
FROM
    salarybonus s
        JOIN
    jobdepartment d ON d.Job_ID = s.Job_ID
GROUP BY (jobdept)
ORDER BY totalsalary DESC
LIMIT 3;
-- 3. QUALIFICATION AND SKILLS ANALYSIS 
--  How many employees have at least one qualification listed? 
SELECT 
     COUNT(distinct emp_id) employee_count
FROM
    qualification;


-- Which positions require the most qualifications? 
select * from qualification;
SELECT 
	Position,Requirements,count(QualID) most_qualified
FROM
    qualification
GROUP BY QualID
;

--  Which employees have the highest number of qualifications?
SELECT 
     e.firstname,e.lastname,count(q.qualId) mostqualified
FROM
    qualification q
        JOIN
    employee e ON q.emp_id=e.emp_id
GROUP BY e.firstname,e.lastname,e.emp_id
ORDER BY mostqualified desc
;


-- 4. LEAVE AND ABSENCE PATTERNS 
--  1.Which year had the most employees taking leaves? 
 select * from leaves;
SELECT
    YEAR(date) AS leave_year,
    COUNT(DISTINCT emp_ID) AS employee_count
FROM leaves
GROUP BY YEAR(date)
ORDER BY employee_count DESC
LIMIT 1;



--  2.What is the average number of leave days taken by its employees per department? 
 -- select * from payroll;
SELECT d.jobdept department,(count(l.leave_id))/(count(e.emp_id)) as avg_leaves from leaves l
JOIN employee e
ON e.emp_id = l.emp_id
JOIN jobdepartment d
ON e.job_id = d.job_id
GROUP BY d.jobdept;

    
--  3.Which employees have taken the most leaves? 
SELECT 
    e.emp_id,
    e.firstname,
    e.lastname,
    COUNT(l.leave_id) no_leave
FROM
    leaves l
        JOIN
    employee e ON e.emp_id = l.emp_id
GROUP BY e.emp_id , e.firstname
ORDER BY no_leave DESC
;



-- 4.What is the total number of leave days taken company-wide? 
SELECT 
    COUNT(leave_id) total_leaves
FROM
    leaves;

--  5.How do leave days correlate with payroll amounts?
SELECT p.leave_id,
    COUNT(l.date) leavedays, sum(p.total_amount) total_payroll
FROM
    payroll p 
    inner join leaves l
    on p.leave_id=l.leave_id
GROUP BY p.leave_id;

-- select * from payroll;


-- 5. PAYROLL AND COMPENSATION ANALYSIS 

--  1.What is the total monthly payroll processed? 

SELECT 
    MONTH(date) monthly_payroll, SUM(total_amount) total_payroll
FROM
    payroll
GROUP BY (monthly_payroll);


--  2.What is the average bonus given per department? 
SELECT 
    d.jobdept, ROUND(AVG(s.bonus), 2) avg_bonus
FROM
    jobdepartment d
        JOIN
    salarybonus s ON d.job_Id = s.job_id
GROUP BY (d.jobdept)
ORDER BY avg_bonus DESC;
--  3.Which department receives the highest total bonuses? 
SELECT 
    d.jobdept department,SUM(s.bonus) totalbonus
FROM
    jobdepartment d
        JOIN 
    salarybonus s on d.job_id=s.job_id
GROUP BY (jobdept)
order by totalbonus desc limit 1;


--  4.What is the average value of total_amount after considering leave deductions?
SELECT 
    round(AVG(total_amount)) avg_payroll_value_after_leavedeductions
FROM
    payroll;
    
    
    
    
    -- Tables We have 
select * from employee;
select * from jobdepartment;
select * from qualification;
select * from salarybonus;
select * from leaves;
select * from payroll;
