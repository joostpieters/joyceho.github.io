USE companyDB;

/* Retrieve the birthdate and address of the employee whose name is ‘John B. Smith” */
SELECT bdate, address
FROM employee
WHERE fname = 'John' AND minit='B' AND lname='Smith';

/* List the SSN, last name, and department number of all employees */
SELECT ssn, lname, dno
FROM employee;

/* List the department number and name of all departments */
SELECT dnumber, dname
FROM department;

/* List the projects under department number 5 */
SELECT *
FROM project
WHERE dnum = 5;
