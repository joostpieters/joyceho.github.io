/* What are the name of the departments
that are located in Houston?*/
SELECT dname, department.dnumber
FROM department, dept_loc
WHERE dlocation = 'Houston'
AND department.dnumber = dept_loc.dnumber;

/* Find the name of the managers who are in
charge of the departments located in Houston */
SELECT fname, minit, lname
FROM employee, department, dept_loc
WHERE dlocation = 'Houston'
AND department.dnumber = dept_loc.dnumber
AND mgrssn = ssn;

/* What are the names of the children whose parents work on ProductX?*/
SELECT name
FROM project, works_on, dependent
WHERE pnumber = pno
AND works_on.essn = dependent.essn
AND pname = 'ProductX';