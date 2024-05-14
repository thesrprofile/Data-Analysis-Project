SELECT * FROM patients;


 
 -- Show first name, last name, and gender of patients whose gender is 'M'
 
select first_name, last_name, gender from patients where gender = 'M';


-- Show first name and last name of patients who does not have allergies. (null)

select 
	first_name, 
    last_name from patients 
    where  allergies IS null;

-- Show first name of patients that start with the letter 'C'

select 
	first_name 
    from patients 
    where first_name 
LIKE 'c%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name from patients
where weight between 100 AND 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'


update patients SET allergies= 'NKA'  where allergies IS null;

-- Show first name and last name concatinated into one column to show their full name.

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient.


select first_name, last_name, province_name from patients
join province_names on province_names.province_id = patients.province_id;


-- Show how many patients have a birth_date with 2010 as the birth year.

select count(*) from patients where year(birth_date) = 2010;


-- Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name,max(height) from patients;



-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

select * from patients where patient_id in (1,45,534,879,1000);


-- Show the total number of admissions

select count(patient_id) from admissions;


-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

select * from admissions where admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.
select patient_id, count(patient_id) from admissions where patient_id = 579;


-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

select distinct(city) from patients where province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

select first_name, last_name, birth_date from patients
where height > 160 and weight > 70;



-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

select first_name, last_name, allergies from patients 
where allergies not null and city= 'Hamilton';


-- Show unique birth years from patients and order them by ascending.
select distinct(year(birth_date)) from  patients  order by birth_date asc;

-- Show unique first names from the patients table which only occurs once in the list.

-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
-- If only 1 person is named 'Leo' then include them in the output.

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id, first_name from patients 
where first_name like 's____%s';

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.


SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';


-- Display every patient's first_name.
-- Order the list by the length of each name and then by alphabetically.

select first_name from patients order by len(first_name), first_name asc;



-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;
  
  
  -- Show first and last name, allergies from patients which have allergies to 
  -- either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.


select first_name, last_name, allergies from patients where allergies in  ('Penicillin', 'Morphine')
order by allergies, first_name, last_name asc;



-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

select patient_id, diagnosis from admissions group by patient_id, diagnosis
having count(*) > 1;
 
 
-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

SELECT
  city,
  COUNT(*) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC, city asc;


-- Show first name, last name and role of every person that is either patient or doctor.
--The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' as role FROM patients
    union all
select first_name, last_name, 'Doctor' from doctors;



-- Show all allergies ordered by popularity. Remove NULL values from query.

SELECT
  allergies,
  COUNT(*) AS total_diagnosis
FROM patients
WHERE
  allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC




-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.


select first_name, last_name,birth_date from patients
where year(birth_date) between 1970 and 1979
order by birth_date asc;



-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane


select concat(upper(last_name),',', lower(first_name)) as new_name_format 
from patients
order by first_name desc;


-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.


SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000


-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'


select max(weight) - min(weight) as weight from patients
where last_name= 'Maroni';



-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.


select day(admission_date) as day_number, count(*) as number_of_addmission
from admissions
group by day_number
order by number_of_addmission desc;


-- Show all columns for patient_id 542's most recent admission_date.

SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);
  
  
  
  
  -- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
  
  
  SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    attending_doctor_id IN (1, 5, 19)
    AND patient_id % 2 != 0
  )
  OR 
  (
    attending_doctor_id LIKE '%2%'
    AND len(patient_id) = 3
  )
  
  
  -- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.


SELECT
  first_name,
  last_name,
  count(*) as admissions_total
from admissions a
  join doctors ph on ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id;


-- For each doctor, display their id, full name, and the first and last admission date they attended.


 
 select
  doctor_id,
  first_name || ' ' || last_name as full_name,
  min(admission_date) as first_admission_date,
  max(admission_date) as last_admission_date
from admissions a
  join doctors ph on a.attending_doctor_id = ph.doctor_id
group by doctor_id;



-- Display the total amount of patients for each province. Order by descending.


SELECT
  province_name,
  COUNT(*) as patient_count
FROM patients pa
  join province_names pr on pr.province_id = pa.province_id
group by pr.province_id
order by patient_count desc;


-- For every admission, display the patient's full name, 
-- their admission diagnosis, and their doctor's full name who diagnosed their problem.



select 
	concat(patients.first_name,' ',patients.last_name) as patients_name, 
	diagnosis,
    concat(doctors.first_name,' ',doctors.last_name) as doctors_name
    from patients 
join admissions  on admissions.patient_id =  patients.patient_id
join doctors  on doctors.doctor_id = admissions.attending_doctor_id;


-- display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.

select first_name, last_name, count(*) as number_of_duplicate 
from patients
group by first_name, last_name
having  count(*)>1;




-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date,
-- gender non abbreviated.

-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.



select
    concat(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) as 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  ELSE 'FEMALE' 
END AS 'gender_type'
from patients



-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)


SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions );
  
  
  
  -- Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.

-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.


SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


-- Show patient_id, weight, height, isObese from the patients table.

-- Display isObese as a boolean 0 or 1.

-- Obese is defined as weight(kg)/(height(m)2) >= 30.

-- weight is in units kg.

-- height is in units cm.


SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;


-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

-- Check patients, admissions, and doctors tables for required information.



SELECT
  p.patient_id,
  p.first_name AS patient_first_name,
  p.last_name AS patient_last_name,
  ph.specialty AS attending_doctor_specialty
FROM patients p
  JOIN admissions a ON a.patient_id = p.patient_id
  JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id
WHERE
  ph.first_name = 'Lisa' and
  a.diagnosis = 'Epilepsy'
  
  
  
 --  All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date


SELECT
  DISTINCT P.patient_id,
  CONCAT(
    P.patient_id,
    LEN(last_name),
    YEAR(birth_date)
  ) AS temp_password
FROM patients P
  JOIN admissions A ON A.patient_id = P.patient_id;
  
  
  
  -- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.

-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.


select 'No' as has_insurance, count(*) * 50 as cost
from admissions where patient_id % 2 = 1 group by has_insurance
union
select 'Yes' as has_insurance, count(*) * 10 as cost
from admissions where patient_id % 2 = 0 group by has_insurance


-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);


-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.


SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as float),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;



-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.


SELECT
 admission_date,
 count(admission_date) as admission_day,
 count(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
 group by admission_date
 
 
 -- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.


select province_name
from province_names
order by
  (case when province_name = 'Ontario' then 0 else 1 end),
  province_name;
  
  
  -- We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.


SELECT
  d.doctor_id as doctor_id,
  CONCAT(d.first_name,' ', d.last_name) as doctor_name,
  d.specialty,
  YEAR(a.admission_date) as selected_year,
  COUNT(*) as total_admissions
FROM doctors as d
  LEFT JOIN admissions as a ON d.doctor_id = a.attending_doctor_id
GROUP BY
  doctor_name,
  selected_year
ORDER BY doctor_id, selected_year