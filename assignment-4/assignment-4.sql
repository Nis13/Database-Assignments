create type sex_enum as enum ('F','M');

create table Employees (
id serial primary key,
first_name varchar(255) not null,
last_name varchar(255),
sex sex_enum,
doj date,
"current_date" date not null,
designation varchar(255),
age int ,
salary decimal(10,2),
unit varchar(255),
leaves_used int,
leaves_remaining int,
ratings int,
past_exp int
)

-- copy the dataset from CSV to table
copy Employees (first_name,last_name,sex,doj,"current_date",designation,age,salary,unit,leaves_used,leaves_remaining,ratings,past_exp)
from 'D:\LeapFrog\database\assignment-4\Salary Prediction of Data Professions.csv'
delimiter ','
csv header;
select * from Employees;

--Common Table Expressions (CTEs):
--Question 1: Calculate the average salary by department for all Analysts.
with  
	average_salaries as (
	select unit , avg(salary)
	from employees
	where designation = 'Analyst'
	group by unit
	)
select * from average_salaries;

--Question 2: List all employees who have used more than 10 leaves.
with 
	leaves_employees as (
		select first_name, last_name, leaves_used
		from employees 
		where leaves_used >10
	)
select * from leaves_employees;


--Views:
--Question 3: Create a view to show the details of all Senior Analysts.
create view senior_details as 
	select * 
	from employees
	where designation = 'Senior Analyst';

select * from senior_details;

--Materialized Views:
--Question 4: Create a materialized view to store the count of employees by department
create materialized view employees_count as 
	select unit,count(id)
	from employees
	group by unit;

select * from employees_count;
	
--Procedures (Stored Procedures):
--Question 6: Create a procedure to update an employee's salary by their first name and last
--name
create or replace procedure change_salary(
 new_first_name varchar(255),
 new_last_name varchar(255), 
 updated_salary dec
)
language plpgsql 
as $$
begin
 update employees 
 set salary = updated_salary
 where first_name = new_first_name and last_name = new_last_name;
 commit;
end;$$;

CALL change_salary('OLIVE', 'ANCY', 50000);

select first_name, last_name, salary from employees e 
where first_name = 'OLIVE';

--Question 7: Create a procedure to calculate the total number of leaves used across all
--departments
CREATE OR REPLACE PROCEDURE leaves_departments_used()
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE OR REPLACE VIEW leaves_used AS 
    SELECT unit AS department, SUM(leaves_used) AS total_leaves 
    FROM employees 
    GROUP BY unit;
END;
$$;

CALL leaves_departments_used();

SELECT * FROM leaves_used;









































