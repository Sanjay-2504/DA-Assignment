use assignment;
set sql_safe_updates=0;

#Q1
select * from orders;
Delimiter //
CREATE PROCEDURE Order_status (IN in_month INT, IN in_year INT )
BEGIN
SELECT orderNumber, orderDate ,status FROM orders 
WHERE in_month = MONTH(shippeddate) AND in_year = YEAR(shippeddate) ;
END //
call order_status(2004,11);

#Q2 - a
select * from payments;
select * from customers;
DELIMITER //
CREATE FUNCTION purchase_status(in_customerNumber INT)
RETURNS varchar(10)
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE Stat  VARCHAR(20);
DECLARE total FLOAT DEFAULT 0;
SET total = (SELECT SUM(amount) FROM payments WHERE in_customerNumber = customerNumber);
IF total<25000 THEN SET Stat = 'Silver' ;
ELSEIF total > 25000 AND amount <50000  THEN SET Stat = 'Gold' ;
ELSEIF total < 50000  THEN SET Stat ='Platinum';
END IF;
RETURN Stat;
END//
select purchase_status(103);
#Q2 -b
SELECT customerNumber, customername,purchase_status(customernumber) AS MY_STATUS FROM CUSTOMERS;


#Q3
select * from rentals;
select * from movies;
DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
END;

INSERT INTO movies ( id,title, category )Values ( 11, 'The Dark Knight', 'Action/Adventure');
INSERT INTO rentals ( memid, first_name, last_name, movieid ) Values (     9,     'Moin',   'Dalvi',      11 );

  
# Q4
SELECT fname FROM employee ORDER BY salary DESC LIMIT 2, 1;
select empid,fname,salary from employee order by salary desc limit 1 offset 2;

#Q5
select empid,fname,salary,rank() over (order by salary desc) salary_rank from employee;
