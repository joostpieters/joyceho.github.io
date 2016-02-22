/* Session variables */
SET @count = 100;
SELECT @count;

SELECT MAX(salary) INTO @maxSal FROM employee;
SELECT @maxSal;

SELECT fname, lname FROM employee WHERE salary = @maxSal;

/* Temporary Table */
CREATE TEMPORARY TABLE top5Emp AS
(SELECT * FROM employee ORDER BY salary DESC LIMIT 5);

/* Stored Procedure */
DELIMITER //

CREATE PROCEDURE GetAllEmployees()                
    BEGIN    
    SELECT fname, lname  FROM employee;
    END //   

DELIMITER ;

CALL GetAllEmployees();

/* Stored Procedure Information */

SHOW PROCEDURE STATUS;

SHOW PROCEDURE STATUS WHERE name LIKE '%Emp%';

SHOW CREATE PROCEDURE GetAllEmployees;

/* Multiple statements */

DELIMITER //

CREATE PROCEDURE GetAllEmpDepts()                
 BEGIN    
 SELECT fname, lname   FROM employee;
 SELECT dname, mgrssn  FROM department;
 END //   

DELIMITER ;

CALL GetAllEmpDepts();  

/* Local variable example */
DELIMITER //

CREATE PROCEDURE Variable1()                
 BEGIN    
 DECLARE  myvar  INT ;

 SET myvar = 1234;

 SELECT concat('myvar = ', myvar ) ;                   
 END //   

DELIMITER ;

CALL Variable1();

/* Single valued query local example */
DELIMITER //

CREATE PROCEDURE Variable2()                
 BEGIN    
 DECLARE  myvar  INT ;

 SELECT sum(salary) INTO myvar
 FROM   employee
 WHERE  dno = 4;

 SELECT CONCAT('myvar = ', myvar );                   
 END //   

DELIMITER ;

CALL Variable2();

/* Nested scopes */
DELIMITER //

CREATE PROCEDURE Variable3()
BEGIN
DECLARE x1 CHAR(5) DEFAULT 'outer';
SELECT x1;
  BEGIN
  --  x2 only inside inner scope ! 
  DECLARE x2 CHAR(5) DEFAULT 'inner';    
  SELECT x1;
  SELECT x2;
  END;
SELECT x1;
END; //

DELIMITER ;

CALL Variable3();

/* Local variable shadowing */
DELIMITER //

CREATE PROCEDURE Variable4()
BEGIN
DECLARE x1 CHAR(5) DEFAULT 'outer';
SELECT x1;
  BEGIN
  DECLARE x1 CHAR(5) DEFAULT 'inner';
  SELECT x1;
  END;
SELECT x1;
END; //

DELIMITER ;

CALL Variable4();

/* find employees with salary greater than some value */
DELIMITER //

CREATE PROCEDURE GetEmpWithSal( sal FLOAT )                
 BEGIN    
 SELECT fname, lname, salary
 FROM   employee
 WHERE  salary > sal;   
 END //   

DELIMITER ;

CALL GetEmpWithSal(40000);

/* Stored procedure using OUT parameter */
DELIMITER //

CREATE PROCEDURE OutParam1( IN  x INT,
                            OUT o FLOAT )                
 BEGIN    
 SELECT max(salary)  INTO  o
 FROM   employee
 WHERE  dno = x;   
 END //   

DELIMITER ;

CALL OutParam1( 4, @maxSal);
SELECT @maxSal;

DELIMITER //
CREATE PROCEDURE GetEmpSalLevel( IN essn CHAR(9),
                                 OUT salLevel VARCHAR(9) )
  BEGIN
    DECLARE empSalary DECIMAL(7,2);
    SELECT salary INTO empSalary
    FROM employee
    WHERE ssn = essn;
    IF empSalary < 30000 THEN
      SET salLevel = "Junior";
    ELSEIF (empSalary >= 30000 AND empSalary <= 40000) THEN
      SET salLevel = "Associate";
    ELSE
      SET salLevel = "Executive";
    END IF;
  END //

DELIMITER ;

CALL GetEmpSalLevel("123456789", @salLevel);


DELIMITER //
CREATE PROCEDURE GetEmpBonus( IN essn CHAR(9),
                              OUT bonus DECIMAL(7,2))
  BEGIN
    DECLARE empDept INT;
    SELECT dno INTO empDept
    FROM employee
    WHERE ssn = essn;
    CASE empDept
      WHEN 1 THEN
         SET bonus = 10000;
      WHEN 4 THEN
         SET bonus = 5000;
      ELSE
         SET bonus = 0;
    END CASE;
  END //

DELIMITER ;

CALL GetEmpBonus("123456789", @bonusAmt);

/* LOOP Leave Procedure */
 DELIMITER //
 CREATE PROCEDURE LOOPLoopProc()
   BEGIN
   DECLARE x  INT ;
 SET  x = 0;
   L:  LOOP
      SET  x = x + 1;
      IF  (x >= 5) THEN
       LEAVE L; 
      END IF;
      IF  (x mod 2 = 0) THEN
        ITERATE L; 
      END IF;
      SELECT x;
      END LOOP;    
   END //

 DELIMITER ;

 CALL LOOPLoopProc();

/* Cursor in Stored Procedure */

DELIMITER //
DROP PROCEDURE IF EXISTS cursor1 // 
      
CREATE PROCEDURE cursor1()
BEGIN     
      
DECLARE finished  INTEGER   DEFAULT 0;
DECLARE fname1    CHAR(20)  DEFAULT "";
DECLARE lname1    CHAR(20)  DEFAULT "";
DECLARE nameList  CHAR(100) DEFAULT "";
      
-- 1. Declare cursor for employee 
DECLARE emp_cursor CURSOR FOR 
   SELECT fname, lname FROM employee WHERE salary > 40000;
      
-- 2. Declare NOT FOUND handler
DECLARE CONTINUE HANDLER 
   FOR NOT FOUND SET finished = 1;
      
-- 3. Open the cursor
OPEN emp_cursor;
      
L: LOOP   
      -- 4. Fetch next tuple
  FETCH emp_cursor INTO fname1, lname1;
      -- Handler will set finished = 1 if cursor is empty
  IF finished = 1 THEN 
     LEAVE L;
  END IF;
   -- build emp list
   SET nameList = CONCAT( nameList, fname1, ' ', lname1, ';' );
   END LOOP ;

-- 5. Close cursor when done      
CLOSE emp_cursor;
      
SELECT nameList ;
END //    
      
DELIMITER ;

CALL cursor1();

 /* Stored Function */
DELIMITER //
CREATE FUNCTION employeeRaise(salary DECIMAL(7,2))
  RETURNS DECIMAL(7,2) DETERMINISTIC
  BEGIN
  RETURN (1.1 * salary);
  END //
DELIMITER ;

SELECT ssn, salary, employeeRaise(salary)
FROM employee LIMIT 10;

