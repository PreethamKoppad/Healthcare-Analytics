use healthcare_project;

-- Total Patients
Select count(distinct `Patient_ID`) as Total_Patients from patient;

-- Total Doctors
Select count(distinct `Doctor ID`) as Total_Doctors from doctor;

-- Total Visists
select count(distinct `Visit ID`) as Total_Visits from visit;

-- Abnormal Rate
SELECT
    round((SUM(CASE WHEN `Test Result` = 'Abnormal' THEN 1.0 ELSE 0 END) / COUNT(*)) * 100,2) AS Abnormal_Rate
FROM lab_result;
    
-- Average Age of Patients
select round(avg(Age),2) as Average_Age from patient;

-- Average Treatment Cost
select round(avg(`Treatment Cost`),2) as Average_Cost from treatments;

-- Follow-up Rate
select 
	round((sum(case When `Follow Up Required` = "YES" Then 1 Else 0 End) / count(*)) * 100,2) As Follow_Up_Rate
from visit; 

-- Current Year Patients
select 
	count(distinct `Patient ID`) as Current_Year_Patients
from visit
where `Visit Date`=YEAR(CURDATE());

-- Gender wise Patients
select
	Gender, count(distinct Patient_ID) as Patients
from patient
group by Gender;

-- No of Patient From State
select
	State, count(distinct Patient_ID) as Patients
from patient
group by State
order by State desc;

-- Lab Result Distribution
select
	monthname(`Test Date`) as Month,
	sum(case when `Test Result`= "Abnormal" then 1 Else 0 End) as Abnormal,
    sum(case when `Test Result`= "Normal" then 1 Else 0 End) as Normal,
    sum(case when `Test Result`= "Pending" then 1 Else 0 End) as Pending
from lab_result
group by month(`Test Date`), monthname(`Test Date`)
order by month(`Test Date`);

-- Tratment Type Break Down
select
	t.`Treatment Type`,
    count(distinct Patient_ID) as Patients
from patient p
join visit v on p.Patient_ID=v.`Patient ID`
join treatments t on t.`Visit ID`=v.`Visit ID`
group by t.`Treatment Type`
order by Patients desc;

-- Patient Distribution By Age Group
SELECT
    CASE
        WHEN Age < 18 THEN '0-17'
        WHEN Age BETWEEN 18 AND 35 THEN '18-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS Age_Group,
    COUNT(`Patient_ID`) AS `patients`
FROM
    Patient
GROUP BY
    Age_Group
ORDER BY
    `patients` DESC;
    
-- Treatment cost by Specialty
select
	d.Specialty,
    round(sum(t.`Treatment Cost`),2) as Treatment_Cost
from doctor d
join visit v on d.`Doctor ID`=v.`Doctor ID`
join treatments t on v.`Visit ID`=t.`Visit ID`
group by d.Specialty
order by Treatment_Cost desc;

-- Monthly Patient Visit Trend
SELECT
    MONTHNAME(v.`Visit Date`) AS Month,
    SUM(CASE WHEN YEAR(v.`Visit Date`) = 2023 THEN 1 ELSE 0 END) AS `2023`,
    SUM(CASE WHEN YEAR(v.`Visit Date`) = 2024 THEN 1 ELSE 0 END) AS `2024`,
    SUM(CASE WHEN YEAR(v.`Visit Date`) = 2025 THEN 1 ELSE 0 END) AS `2025`
FROM
    visit v
GROUP BY
    MONTH(v.`Visit Date`),
    MONTHNAME(v.`Visit Date`)
ORDER BY
    MONTH(v.`Visit Date`);
    
-- Top 10 Insurence Provider
select
	Insurance_Provider,
    count(distinct patient_ID) as Patients
from patient
group by Insurance_Provider
order by Patients desc
limit 10;
    

	






