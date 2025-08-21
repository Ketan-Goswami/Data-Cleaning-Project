-- INTERMEDIATE -- 

-- JOINS - two + more table together based on a same column
#inner join - returns the rows that are same in both columns from the tables
select * 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id;

#outer join
#left join - everything from left table but only matching rows from the right table
#right join - everyting from right table but only matching rows from the left table

select * 
from employee_demographics as dem
left join employee_salary as sal
on dem.employee_id = sal.employee_id;

select * 
from employee_demographics as dem
right join employee_salary as sal
on dem.employee_id = sal.employee_id;

-- self join - joins with itself
select * 
from employee_salary emp1
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;

-- joining multiple tables together
select * 
from employee_demographics dem
inner join employee_salary sal
	on dem.employee_id = sal.employee_id
inner join parks_departments pd
	on sal.dept_id = pd.department_id;

-- UNIONS - combines the rows from two tables

select first_name, last_name, 'Old Man' as Label
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' as Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'highly paid' as Label
from employee_salary
where salary > 70000
order by first_name, last_name;

