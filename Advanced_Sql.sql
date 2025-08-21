-- ADVANCED --

-- CTEs - define subqueries that can be used/referenced to main queries 
-- CTEs are unique because they can be used immediately after they are created and not below it
-- because it is not stored like a temp table 

with CTE_Example(Gender, Avg_sal, Max_sal, Min_sal, Sal_count) as
(
select gender, avg(salary) avg_sal, max(salary) max_sal, 
min(salary) min_sal, count(salary) sal_count
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example;
 
-- TEMP Tables 
-- temporary tables for storing intermediate results before inserting it into main table
-- for the particular session only 
-- can be reused again

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
fav_movie varchar(50)
);
select *
from temp_Table;

insert into temp_table values
('Alex', 'Colan', 'Lord of the Rings');
 select *
from temp_table;
 
create temporary table sal_over_50k
select * from employee_salary
where salary >= 50000;

select * from sal_over_50k;
 
-- Stored Procedure
-- way to save sql code to use it again n again
-- can be called and it will execute that particular code

select *
from employee_salary
where salary >= 50000;
 
create procedure large_salary()
select *
from employee_salary
where salary >= 50000;
-- this procedure gets displayed on the left bar under stored procedures

call large_salary();

# DELIMITER - allows to have multiple queries using ;  
DELIMITER $$
create procedure large_sal2()
begin
	select *
	from employee_salary
	where salary >= 50000;
    select *
	from employee_salary
	where salary >= 10000;
end $$

call large_sal2();
 
 
DELIMITER $$
create procedure large_sal3(param_employee_id INT)
begin
	select salary
	from employee_salary
	where employee_id = param_employee_id;
end $$

call large_sal3(1);
 
 
-- TRIGGERS - block of code that will execute when an event occurs in a specific table

-- when a new entry is made in the salary table the demographic table must be updated 
DELIMITER $$
CREATE TRIGGER employee_insert
	# after - used after new entries are updated
    # before - used before deleting the current data
	after insert on employee_salary
    
    # this means that the trigger is going to activated for each row 
    for each row
begin
	insert into employee_demographics(employee_id, first_name, last_name)
    # new - takes new values that are recently updated
    # old - gets old values that were deleted
    values (new.employee_id, new.first_name, new.last_name);
end $$
DELIMITER ;

insert into employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
values(13, 'Jean', 'Ralphio', 'Entertainment', 1000000, NULL);
 
select *
from employee_salary;
 
select *
from employee_demographics;
 
 
-- EVENTS - takes place when it is scheduled to occur
-- scheduled automater tasks

DELIMITER $$
create event delete_retirees
on schedule every 30 second
do 
BEGIN
	delete
    from employee_demographics
    where age >= 60;
END $$
DELIMITER ;

-- to get the error why event didn't got created
-- make sure event scheduler is ON
show variables like 'event%';

select *
from employee_demographics;


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 