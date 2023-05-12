use assignment;
set sql_safe_updates=0;

#Q1
select * from employee;
select * from employee where deptno = 10 and salary > 3000;

#Q2
select count(*) from students where marks between 50 and 80;
select count(*) from students where marks between 80 and 100;

#Q3
select  distinct city from station where id % 2 = 0;

#Q4
select ((select count(city) from station) - (select count(distinct city) from station)) as difference;

#Q5 - a
select distinct(city) from station where left(city,1) in ('a','e','i','o','u');

#Q5 - b
select DISTINCT(CITY) from station
where left(city,1) in ('a','e','i','o','u') and 
      RIGHT (1,CITY) IN ('a','e','i','o','u');

#Q5 - c
SELECT DISTINCT(CITY) FROM STATION
WHERE  NOT LEFT(CITY,1) IN  ('a','e','i','o','u');

#Q5 - d
SELECT DISTINCT city FROM  station WHERE
    left(city, 1) NOT IN ('a' , 'e', 'i', 'o', 'u')
        AND right(1,city) NOT IN ('a' , 'e', 'i', 'o', 'u');

#Q6
#select * from emp where salary >2000 and hire_date > now() - interval 36 month order by salary desc;
select Concat(first_name, ' ', last_name) as Employee, Concat(salary, '$') as 'Salary($)', hire_date,
      timestampdiff(MONTH, hire_date, current_date()) as 'Total_Months_Joined'
	  from emp where salary > 2000 having Total_Months_Joined < 36
	  order by salary desc;

#Q7
select deptno, sum(salary) as totalsalary from employee group by deptno;

#Q8
select count(name) as 'City more than 100000 population' from city where population > 100000;

#Q9
select sum(population) as 'Total Population in California' from city where district = 'california';

#Q10
select district as District , avg(population) as Average_population from city group by district;

#Q11
select * from orders;
select * from customers;
#select ordernumber, status, customernumber, (select customerName from customers where customers.customernumber = orders.customernumber) as customername, comments FROM orders WHERE status = 'Disputed';
select o.ordernumber, o.status, o.customernumber, c.customername, o.comments from customers c JOIN orders o	USING (customernumber)	Where o.status = 'Disputed';