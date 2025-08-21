-- CASE Statements

select first_name,
last_name,
age,
CASE 
	when age <= 30 then 'Young'
    when age BETWEEN 31 and 50 then 'Old'
    when age >= 50 then 'Sr. Citizen'
END as Age_bracket
from employee_demographics;

-- pay increase
-- < 50000 = 5%
-- > 50000 = 7%
-- bonus
-- Finance = 10% bonus

select first_name, last_name, salary,
CASE
	when salary < 50000 then salary + (salary * 0.05)
    when salary > 50000 then salary + (salary * 0.07)
END as New_salary,
CASE
	when dept_id = 6 then salary * 0.10
END as Bonus
from employee_salary;

-- SUBQUERIES -- 
select * 
from employee_demographics
where employee_id in 
	(select employee_id
    from employee_salary
    where dept_id = 1)
;

select first_name, salary,
(select avg(salary)
from employee_salary)
from employee_salary;	

select avg(max_age)
from
(select gender, avg(age) as avg_age,
max(age) as max_age, min(age) as min_age,
count(age) as age_count 
from employee_demographics
group by gender) as Agg_table;

-- WINDOW Functions - creates a partition based on the applied function
select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id;

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) rank_num,
dense_rank() over(partition by gender order by salary desc) rank_num
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id;












