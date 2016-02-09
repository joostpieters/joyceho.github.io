USE companyDB;

/* Retrieve the birthdate and address of the employee whose name is ‘John B. Smith” */
SELECT bdate, address FROM employee where fname = 'John' AND minit='B' AND lname='Smith';

/* List the SSN, last name, and department number of all employees */
SELECT ssn, lname, dno FROM employee;

/* List the department number and name of all departments */
SELECT dnumber, dname FROM department;

/* Do a simple cartesian product */
SELECT ssn, lname, dno, dnumber, dname FROM employee, department;

/* Do a simple join product */
SELECT ssn, lname, dno, dnumber, dname FROM employee, department WHERE dno = dnumber;

/* Find the name and address of employees working in the ‘Research' department */
SELECT ssn, lname, dno, dnumber, dname FROM employee, department WHERE dno = dnumber AND dname = 'Research';

/* Find the name of employees in the ‘Research’ department who earn over $30,000 */
SELECT fname, lname FROM employee, department
    WHERE dno = dnumber AND dname = 'Research' AND salary > 30000;

/* Find the SSN of employees who work on the project ‘ProductX’ */
SELECT essn FROM works_on, project WHERE pno = pnumber and pname = 'ProductX';

/* Find the name of employees who work on the project ‘ProductX’ */
SELECT fname, lname FROM employee, works_on, project WHERE ssn = essn AND pno = pnumber and pname = 'ProductX';

/* For the projects located in ‘Stafford’, find the name of the project,
the name of the controlling department, the last name of the department’s manager,
his address, and birthdate */
SELECT pnumber, dnum, lname, bdate, address FROM project, department, employee
    WHERE dnum = dnumber AND mgrssn = ssn AND plocation = 'Stafford';

/* Get dependent unique names */
SELECT DISTINCT name FROM dependent;

/* Example of * selector */
SELECT * FROM department where dname='Research';

/* Find project numbers of projects worked on by employees who have a daughter named ‘Alice’ */
SELECT pno FROM works_on, dependent WHERE works_on.essn = dependent.essn AND name = 'Alice';

/* List each employees first name, last name, and their manager’s first name and last name */
SELECT e.fname, e.lname, m.fname, m.lname FROM employee e, employee m
    WHERE e.superssn = m.ssn;

/* List all project names that involve an employee whose last name is ‘Smith'
 either as a worker or manager of the department that controls the project */
(SELECT pname FROM project, department, employee
    WHERE dnum = dnumber AND mgrssn = ssn AND lname = 'Smith')
UNION
(SELECT pname FROM project, works_on, employee
    WHERE pnumber = pno and essn = ssn AND lname = 'Smith');

/* Find the name of employees whose SSN is 123456789 or 333445555 */
SELECT fname, lname FROM employee WHERE ssn IN ('123456789', '333445555');

/* Find the name of employees whose DNO is 4 or 5 and are male */
SELECT fname, lname FROM employee WHERE (dno, sex) IN ((4, 'M'), (5, 'M'));

/* Find names of employees whose last name start with ’S' */
SELECT fname, lname FROM employee WHERE lname LIKE 'S%';

/* Find the names of employees who live in Houston */
SELECT fname, lname FROM employee WHERE address LIKE '%Houston%';

/* Sort employees by their salary value in descending order */
SELECT fname, lname, salary FROM employee ORDER BY salary DESC;

/* Sort employees by their salary figures and within the same salary figure, by their last name */
SELECT fname, lname, salary FROM employee ORDER BY salary, lname;


