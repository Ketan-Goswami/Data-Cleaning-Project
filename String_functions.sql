-- String functions

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2;

select upper('sky');
select lower('SKY');
select first_name, upper(first_name)
from employee_demographics;

-- trim - takes out the whitespaces 
select rtrim('       sky     ');

-- left, right -- 
-- Substring --
select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3, 2),
birth_date,
substring(birth_date, 6,2) as birth_month
from employee_demographics;

-- replace -- 
select first_name, 
replace(first_name, 'A', 'Z')
from employee_demographics;

-- locate --
select locate('x', 'Alexander');
select first_name, locate('An', first_name)
from employee_demographics;

-- concatenation --
select first_name, last_name,
concat(first_name,'  ', last_name) as full_name
from employee_demographics;


 