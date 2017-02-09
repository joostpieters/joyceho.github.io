/* Find the name of employees in the
‘Research’ department who earn over $30,000 */
SELECT fname, lname
FROM employee, department
WHERE dno = dnumber
AND dname = 'Research' AND salary > 30000;

/* Find the SSN of employees who
work on the project ‘ProductX’ */
SELECT essn
FROM works_on, project
WHERE pno = pnumber and pname = 'ProductX';

/* For the projects located in ‘Stafford’,
find the name of the project,
the name of the controlling department,
the last name of the department’s manager,
his address, and birthdate */
SELECT pnumber, dnum, lname, bdate, address
FROM project, department, employee
WHERE dnum = dnumber
AND mgrssn = ssn AND plocation = 'Stafford';