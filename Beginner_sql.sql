-- BEGINNER --

#SELECT - filters the columns of the table
SELECT * 
FROM parks_and_recreation.employee_demographics;

select first_name
from parks_and_recreation.employee_demographics;

#PEMDAS
select first_name,
age,
age + 10
from employee_demographics;

#DISTINCT
select distinct gender, first_name
from employee_demographics;

#WHERE - for filtering the data and rows
select * from employee_salary
where first_name = 'Leslie';

select * from employee_salary
where salary <= 50000;

select * from employee_demographics
where gender != 'Female';

select * from employee_demographics
where birth_date > '1985-01-01';

-- AND OR NOT -- Logical operators
select * from employee_demographics
where birth_date > '1985-01-01' 
AND gender = 'Male';

-- LIKE Statement
-- % and _
select * from employee_demographics
where first_name Like 'a__%';

# Group by - grps together rows that have the same values
select gender, avg(age), max(age) as max_age, min(age), count(age)
from employee_demographics
group by gender;

select occupation, salary
from employee_salary
group by occupation, salary;

-- ORDER BY
select *
from employee_demographics
order by gender, age;


-- HAVING - used for aggregated functions columns after the group by 
select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

-- LIMIT - specify no. of rows in the output
select * from employee_demographics
order by age desc
limit 3;

-- ALIAS - changing name of the column
select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40;